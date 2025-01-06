import React, { useRef, useState, useContext } from "react";
import AxiosInstance from "../../services/AxiosInstance";
import { FileContext } from "./../../contexts/FileContext";
import "./FileUpload.css";

const FileUpload = ({ onFileSelect, buttonLabel = "Upload Audio File" }) => {
  const inputFileRef = useRef(null);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState(null);
  const [responseData, setResponseData] = useState(null);

  const { setFileURL } = useContext(FileContext);

  const handleFileChange = (e) => {
    const file = e.target.files[0];
    if (file) {
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

      if (response.data && response.data.fileURL) {
        setFileURL(response.data.fileURL);
      } else {
        const fileURL = URL.createObjectURL(file);
        setFileURL(fileURL);
      }
    } catch (err) {
      console.error("Upload failed:", err);
      setUploading(false);
      setError("Failed to upload the file. Please try again.");
    }
  };

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
        accept="audio/*"
        ref={inputFileRef}
        style={{ display: "none" }}
        onChange={handleFileChange}
      />

      {uploading && <p>Uploading...</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}

      {responseData && (
        <div>
          <h3>Upload Response:</h3>
          <pre>{JSON.stringify(responseData, null, 2)}</pre>
        </div>
      )}
    </div>
  );
};

export default FileUpload;
