import React, { useState, useEffect } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Navbar from "./components/Navbar/Navbar";
import Login from "./components/Login/Login";
import Register from "./components/Register/Register";
import FileUpload from "./components/FileUpload/FileUpload";
import { FileProvider } from "./contexts/FileContext";

const App = () => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  useEffect(() => {
    if (localStorage.getItem("access_token")) {
      setIsAuthenticated(true);
    }
  }, []);

  const handleFileSelect = (file) => {
    console.log("Selected file:", file);
    // You can handle the file (upload, preview, etc.)
  };

  return (
    <FileProvider>
      <Router>
        <Navbar
          isAuthenticated={isAuthenticated}
          setIsAuthenticated={setIsAuthenticated}
        />
        {isAuthenticated && (
          <FileUpload
            onFileSelect={handleFileSelect}
            buttonLabel="Upload Audio File"
          />
        )}
        <Routes>
          <Route
            path="/login"
            element={<Login setIsAuthenticated={setIsAuthenticated} />}
          />
          <Route path="/register" element={<Register />} />
        </Routes>
      </Router>
    </FileProvider>
  );
};

export default App;
