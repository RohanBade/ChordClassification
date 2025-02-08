import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";

import AxiosInstance from "../../services/AxiosInstance";
import "./Register.css";

const Register = () => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    username: "",
    email: "",
    password: "",
  });
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const validateForm = () => {
    const { username, email, password } = formData;

    if (!username.trim() || username.trim().length < 3) {
      setError("Full Name must be at least 3 characters long.");
      return false;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email.trim() || !emailRegex.test(email)) {
      setError("Please enter a valid email address.");
      return false;
    }

    const passwordRegex =
      /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
    if (!password.trim() || !passwordRegex.test(password)) {
      setError(
        "Password must be at least 8 characters long, include an uppercase letter, a number, and a special character."
      );
      return false;
    }

    setError("");
    return true;
  };

  const handleRegister = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");

    if (!validateForm()) {
      setLoading(false);
      return;
    }

    const { username, email, password } = formData;

    if (!username.trim() || !email.trim() || !password.trim()) {
      setError("All fields are required.");
      setLoading(false);
      return;
    }

    try {
      const response = await AxiosInstance.post("/user/create", {
        name: username,
        email,
        password,
      });

      if (response.status === 200) {
        alert("Registration successful!");
        setFormData({ username: "", email: "", password: "" });
        navigate("/login");
      }
    } catch (error) {
      if (error.response) {
        console.error("Error response:", error.response.data.detail);
        setError(error.response.data.detail);
      } else if (error.request) {
        console.error("No response from server:", error.request);
        setError("No response. Please try again later.");
      } else {
        console.error("Error:", error.message);
        setError("An error occurred. Please try again.");
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="register-container">
      <div className="heading">
        <h2>Create Your Account</h2>
        <p>Fill in the details to register</p>
      </div>
      <form onSubmit={handleRegister}>
        <div className="form-data">
          <div className="entity">
            <input
              type="text"
              id="username"
              name="username"
              value={formData.username}
              onChange={handleInputChange}
              required
              placeholder="Enter your username"
            />
          </div>
          <div className="entity">
            <input
              type="email"
              id="email"
              name="email"
              value={formData.email}
              onChange={handleInputChange}
              required
              placeholder="Enter your email"
            />
          </div>
          <div className="entity">
            <input
              type={showPassword ? "text" : "password"}
              id="password"
              name="password"
              value={formData.password}
              onChange={handleInputChange}
              required
              placeholder="Enter your password"
            />
          </div>
          <div className="show-password">
            <input
              type="checkbox"
              id="showPassword"
              checked={showPassword}
              onChange={() => setShowPassword(!showPassword)}
            />
            <label htmlFor="showPassword">Show Password</label>
          </div>
          {error && <p className="error">{error}</p>}
          <button className="btn" type="submit" disabled={loading}>
            {loading ? "Registering..." : "Register"}
          </button>
        </div>
      </form>
      <div className="login-link">
        <p style={{ color: "gray" }}>
          Already have an account?{" "}
          <Link style={{ color: "skyblue" }} to="/login">
            Login
          </Link>
        </p>
      </div>
    </div>
  );
};

export default Register;
