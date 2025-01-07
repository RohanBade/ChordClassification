import React, { useRef, useState, useContext, useEffect } from "react";
import AxiosInstance from "../../services/AxiosInstance";
import { FileContext } from "./../../contexts/FileContext";
import WaveSurfer from "wavesurfer.js";
import RegionsPlugin from "wavesurfer.js/dist/plugins/regions.esm.js";
import "./FileUpload.css";

const FileUpload = ({ onFileSelect, buttonLabel = "Upload Audio File" }) => {
  const inputFileRef = useRef(null);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState(null);
  const [responseData, setResponseData] = useState(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [audioReady, setAudioReady] = useState(false);
  const [fileURL, setFileURL] = useState(null);

  const random = (min, max) => Math.random() * (max - min) + min;
  const randomColor = () =>
    `rgba(${random(0, 255)}, ${random(0, 255)}, ${random(0, 255)}, 0.5)`;

  const [waveSurfer, setWaveSurfer] = useState(null);

  useEffect(() => {
    if (fileURL) {
      const regions = RegionsPlugin.create();
      const ws = WaveSurfer.create({
        container: "#waveform",
        waveColor: "rgb(200, 0, 200)",
        progressColor: "rgb(100, 0, 100)",
        url: fileURL,
        plugins: [regions],
      });

      setWaveSurfer(ws);

      ws.on("ready", () => {
        setAudioReady(true);
        if (responseData && responseData.predictions) {
          responseData.predictions.forEach((region) => {
            regions.addRegion({
              start: region.start,
              end: region.end,
              content: region.chord || "Region",
              color: randomColor(),
              drag: false,
              resize: false,
              minLength: 1,
              maxLength: 10,
            });
          });
        }
      });

      return () => {
        if (ws) ws.destroy();
      };
    }
  }, [fileURL, responseData]);

  const handleFileChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      const tempURL = URL.createObjectURL(file);
      setFileURL(tempURL);
      onFileSelect(file);
      uploadFile(file);
    }
  };

  const uploadFile = async (file) => {
    const formData = new FormData();
    formData.append("file", file);

    setUploading(true);
    setError(null);
    setResponseData(null);

    try {
      const response = await AxiosInstance.post("/upload/", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });

      console.log("Upload success:", response.data);
      setUploading(false);
      setResponseData(response.data);
    } catch (err) {
      console.error("Upload failed:", err);
      setUploading(false);
      setError("Failed to upload the file. Please try again.");
    }
  };

  const togglePlayPause = () => {
    if (waveSurfer) {
      if (isPlaying) {
        waveSurfer.pause();
      } else {
        waveSurfer.play();
      }
      setIsPlaying(!isPlaying);
    }
  };

  const handleKeyDown = (e) => {
    if (e.key === " " || e.key === "Spacebar") {
      e.preventDefault();
      togglePlayPause();
    }
  };

  useEffect(() => {
    document.addEventListener("keydown", handleKeyDown);
    return () => {
      document.removeEventListener("keydown", handleKeyDown);
    };
  }, [isPlaying]);

  return (
    <div>
      <button
        onClick={() => inputFileRef.current.click()}
        className="upload-button"
      >
        {buttonLabel}
      </button>
      <input
        type="file"
        accept="audio/wav"
        ref={inputFileRef}
        style={{ display: "none" }}
        onChange={handleFileChange}
      />

      {uploading && <p>Uploading...</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}

      {fileURL && (
        <div
          id="waveform"
          style={{
            width: "100%",
            height: "200px",
            marginTop: "20px",
            border: "1px solid #ccc",
          }}
        ></div>
      )}

      {audioReady && (
        <button
          onClick={togglePlayPause}
          style={{
            marginTop: "20px",
            padding: "10px 20px",
            backgroundColor: "#007bff",
            color: "#fff",
            border: "none",
            borderRadius: "5px",
            display: "flex",
            justifyContent: "center",
          }}
        >
          {isPlaying ? "Pause" : "Play"}
        </button>
      )}
    </div>
  );
};

export default FileUpload;
