import React from "react";
import { Link, useNavigate } from "react-router-dom";

const Navbar = ({ isAuthenticated, setIsAuthenticated }) => {
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.removeItem("access_token");
    localStorage.removeItem("refresh_token");
    setIsAuthenticated(false);
    navigate("/login");
  };

  return (
    <nav>
      <Link to="/">Home</Link> |
      {!isAuthenticated && (
        <>
          <Link to="/login">Login</Link> |<Link to="/register">Register</Link> |
        </>
      )}
      {isAuthenticated && (
        <button onClick={handleLogout} className="btn-logout">
          Logout
        </button>
      )}
    </nav>
  );
};

export default Navbar;
