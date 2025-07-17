// useUserStore.ts
import { create } from "zustand";
import { jwtDecode } from "jwt-decode";

interface User {
  id: string;
  name: string;
  email: string;
  image: string | null;
}

interface UserStore {
  user: User | null;
  initialized: boolean; // Track initialization state
  setUser: (user: User) => void;
  clearUser: () => void;
  initializeUser: () => Promise<void>;
}

interface DecodedUserProfile {
  sub: string;
  name: string;
  email: string;
  picture?: string;
  exp?: number; // Optional: JWT expiration timestamp
}

export const useUserStore = create<UserStore>((set, get) => ({
  user: null,
  initialized: false,
  setUser: (user) => {
    localStorage.setItem("google_token", JSON.stringify(user));
    set({ user });
  },
  clearUser: () => {
    localStorage.removeItem("google_token");
    set({ user: null });
  },
  initializeUser: async () => {
    if (get().initialized) return; // Skip if already initialized

    const token = localStorage.getItem("google_token");
    if (!token) {
      set({ initialized: true });
      return;
    }

    try {
      const userProfile = jwtDecode<DecodedUserProfile>(token);

      // Check token expiration if needed
      if (userProfile.exp && userProfile.exp * 1000 < Date.now()) {
        throw new Error("Token expired");
      }

      set({
        user: {
          id: userProfile.sub,
          name: userProfile.name,
          email: userProfile.email,
          image: userProfile.picture ?? null,
        },
        initialized: true,
      });
    } catch (error) {
      console.error("Failed to initialize user", error);
      localStorage.removeItem("google_token");
      set({ initialized: true });
    }
  },
}));

// Auto-initialize immediately when store is created
useUserStore.getState().initializeUser();
