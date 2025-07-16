import { createContext } from "react";
import type { UserProfile } from "./AuthProvider";

interface AuthContextType {
  user: UserProfile | null;
  isAuthenticated: boolean;
  logout: () => void;
}

export const AuthContext = createContext<AuthContextType | undefined>(
  undefined,
);
