import React from "react";
import "./Homepage.css";
import { useNavigate } from "react-router-dom";

const Homepage = () => {
  const navigate = useNavigate();

  return (
    <div className="homepage-container">
      <div className="homepage-content">
        <img
          src="/assets/music.png"
          alt="Get Your Chords"
          className="homepage-image"
        />
        <button
          className="homepage-button"
          onClick={() => navigate("/register")}
        >
          GET STARTED
        </button>
      </div>
    </div>
  );
};

export default Homepage;
