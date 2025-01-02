import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import AxiosInstance from "../../services/AxiosInstance";
import "./Login.css";

const Login = ({ setIsAuthenticated }) => {
  const navigate = useNavigate();
  const handleRegisterClick = () => {
    navigate("/register");
  };

  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");

    if (!username.trim() || !password.trim()) {
      setError("Both fields are required.");
      setLoading(false);
      return;
    }

    try {
      const response = await AxiosInstance.post(
        "/login",
        new URLSearchParams({
          username,
          password,
        }),
        {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        }
      );

      const { access_token, refresh_token } = response.data;

      localStorage.setItem("access_token", access_token);
      localStorage.setItem("refresh_token", refresh_token);

      setIsAuthenticated(true);
      alert("Login successful!");
      navigate("/");
    } catch (err) {
      console.error("Login failed:", err.response?.data || err.message);
      setError(err.response?.data?.detail || "An error occurred.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-container">
      <div className="heading">
        <h2>Sign In</h2>
        <p>Enter your credentials below to login</p>
      </div>
      <form onSubmit={handleLogin}>
        <div className="form-data">
          <div className="entity">
            <input
              type="text"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              required
              placeholder="Email"
            />
          </div>
          <div className="entity">
            <input
              type={showPassword ? "text" : "password"}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              placeholder="Password"
            />
          </div>
          <div className="show-password">
            <input
              type="checkbox"
              id="show-password"
              checked={showPassword}
              onChange={() => setShowPassword(!showPassword)}
            />
            <label htmlFor="show-password">Show Password</label>
          </div>
          {error && <p className="error">{error}</p>}
          <button className="btn" type="submit" disabled={loading}>
            {loading ? "Logging in..." : "Sign in"}
          </button>
          <div className="divider">
            <span>or</span>
          </div>
          <button
            className="apple-signin"
            type="button"
            onClick={handleRegisterClick}
          >
            Register
          </button>
        </div>
      </form>
    </div>
  );
};

export default Login;
