import "./index.css";
import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { GoogleOAuthProvider } from "@react-oauth/google";
import { RouterProvider } from "react-router-dom";
import router from "./app/router/root";
import { AuthProvider } from "./app/auth/AuthProvider";
import InitializeAuth from "./app/auth/InitAuth";

const clientId = import.meta.env.VITE_GOOGLE_CLIENT_ID as string;

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <GoogleOAuthProvider clientId={clientId}>
      <AuthProvider>
        {/* TODO: later replace this with react hooks to not use useAuth() */}
        <RouterProvider router={router} />
        <InitializeAuth />
      </AuthProvider>
    </GoogleOAuthProvider>
  </StrictMode>,
);
