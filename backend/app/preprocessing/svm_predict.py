from math import log2

import numpy as np
from scipy.io import wavfile


class PitchClassProfiler:
    def __init__(self, file_name):
        self.file_name = file_name
        self.read = False

    def _read_file(self):
        try:
            self._frequency, self._samples = wavfile.read(self.file_name)
        except Exception as e:
            print(f"Error reading {self.file_name}: {e}")
            self._frequency = None
            self._samples = np.array([])
            self.read = False
            return

        # Convert to mono if stereo
        if len(self._samples.shape) > 1:
            self._samples = np.mean(self._samples, axis=1)

        if self._samples.dtype == np.int16:
            self._samples = self._samples / 32768.0
        elif self._samples.dtype == np.int32:
            self._samples = self._samples / 2147483648.0
        elif self._samples.dtype == np.float32:
            pass

        self.read = True

    def frequency(self):
        if not self.read:
            self._read_file()
        return self._frequency

    def samples(self):
        if not self.read:
            self._read_file()
        return self._samples

    def fourier(self, window_samples):
        return np.fft.fft(window_samples)

    def pcp(self, X):
        fs = self.frequency()
        if fs is None:
            print("Frequency information is missing.")
            return [0] * 12

        fref = 130.81  # Reference frequency for C3
        N = len(X)
        if N == 0:
            return [0] * 12

        def M(l, p):
            if l == 0:
                return -1
            return round(12 * log2((fs * l) / (N * fref))) % 12

        pcp = np.zeros(12)

        for p in range(12):
            for l in range(1, N // 2):
                if p == M(l, p):
                    pcp[p] += abs(X[l]) ** 2

        total_energy = np.sum(pcp)

        if total_energy == 0:
            pcp_norm = np.zeros(12)
        else:
            pcp_norm = pcp / total_energy

        return pcp_norm.tolist()

    def get_profiles(self, window_duration=1.0, overlap=0.0):
        """
        Compute PCP for each window of given duration and overlap with integer second timestamps.
        """
        fs = self.frequency()
        window_size = int(fs * window_duration)
        step_size = window_size
        total_samples = len(self.samples())

        profiles_list = []
        timestamps = []
        current_pointer = 0
        timestamp_counter = 1

        while current_pointer + window_size <= total_samples:
            window_samples = self.samples()[
                current_pointer : current_pointer + window_size
            ]
            X = self.fourier(window_samples)
            pcp = self.pcp(X)
            profiles_list.append(pcp)
            timestamps.append(timestamp_counter)
            current_pointer += step_size
            timestamp_counter += 1

        return profiles_list, timestamps


def consolidate_chords(predictions):
    consolidated = []
    start_time = predictions[0]["timestamp"] - 1
    current_chord = predictions[0]["chord"]

    for i in range(1, len(predictions)):
        if predictions[i]["chord"] == current_chord:
            continue
        else:
            consolidated.append(
                {
                    "start": start_time,
                    "end": predictions[i - 1]["timestamp"],
                    "chord": current_chord,
                }
            )
            start_time = predictions[i]["timestamp"] - 1
            current_chord = predictions[i]["chord"]

    consolidated.append(
        {
            "start": start_time,
            "end": predictions[-1]["timestamp"] + 1,
            "chord": current_chord,
        }
    )

    return consolidated
