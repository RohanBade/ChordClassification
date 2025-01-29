import React, { useRef, useState, useContext, useEffect } from "react";
import AxiosInstance from "../../services/AxiosInstance";
import { FileContext } from "./../../contexts/FileContext";
import WaveSurfer from "wavesurfer.js";
import RegionsPlugin from "wavesurfer.js/dist/plugins/regions.esm.js";
import Play from "/assets/1.png";
import Pause from "/assets/2.png";
import "./FileUpload.css";

const FileUpload = ({ onFileSelect, buttonLabel = "Browse File" }) => {
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
    <div className="upload">
      {uploading && <p style={{ color: "white" }}>Uploading...</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
      {audioReady && (
        <button onClick={togglePlayPause} className="play-pause">
          <img
            src={isPlaying ? Pause : Play}
            alt={isPlaying ? "Pause" : "Play"}
          />
        </button>
      )}

      {fileURL && (
        <div
          id="waveform"
          style={{
            width: "90%",
            marginTop: "20px",
            color: "white",
          }}
        ></div>
      )}

      <div className="upload-section">
        <img src="/assets/upload.png" style={{ width: "100px" }} alt="" />
        <p>Upload Audio Files Here</p>
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
        <p className="file-info">Supported File: WAV | Max file size: 40 MB</p>
      </div>
    </div>
  );
};

export default FileUpload;
