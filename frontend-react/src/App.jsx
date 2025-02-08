import React, { useState, useEffect } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Navbar from "./components/Navbar/Navbar";
import Login from "./components/Login/Login";
import Register from "./components/Register/Register";
import FileUpload from "./components/FileUpload/FileUpload";
import { FileProvider } from "./contexts/FileContext";
import Homepage from "./components/Homepage/Homepage";


const App = () => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  useEffect(() => {
    if (localStorage.getItem("access_token")) {
      setIsAuthenticated(true);
    }
  }, []);

  const handleFileSelect = (file) => {
    console.log("Selected file:", file);
  };

  return (
    <FileProvider>
      <Router>
        <Navbar
          isAuthenticated={isAuthenticated}
          setIsAuthenticated={setIsAuthenticated}
        />
        <Routes>
          <Route
            path="/"
            element={
              isAuthenticated ? (
                <FileUpload
                  onFileSelect={handleFileSelect}
                  buttonLabel="Browse File"
                />
              ) : (
                <Homepage />
              )
            }
          />
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
