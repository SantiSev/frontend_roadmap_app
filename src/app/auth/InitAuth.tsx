// components/InitializeAuth.tsx
import { useUserStore } from "@/stores/useUserStore";
import { useEffect } from "react";

export default function InitializeAuth() {
  const initializeUser = useUserStore((state) => state.initializeUser);

  useEffect(() => {
    initializeUser();
  }, [initializeUser]);

  return null;
}
