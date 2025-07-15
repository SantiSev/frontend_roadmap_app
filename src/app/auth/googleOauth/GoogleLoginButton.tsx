import { GoogleLogin } from "@react-oauth/google";
import { jwtDecode } from "jwt-decode";

interface GoogleOAuthResponse {
  credential?: string;
  clientId?: string;
  select_by?: string;
}

interface UserProfile {
  name: string;
  email: string;
  picture: string;
  sub: string;
}

import { useNavigate } from "react-router-dom";
import { useUserStore } from "../../../stores/useUserStore";

export default function GoogleLoginButton() {
  const navigate = useNavigate();
  const setUser = useUserStore((state) => state.setUser);
  const handleSuccess = async (response: GoogleOAuthResponse) => {
    try {
      if (response.credential) {
        const userProfile: UserProfile = jwtDecode(response.credential);

        setUser({
          id: userProfile.sub,
          name: userProfile.name,
          email: userProfile.email,
        });

        console.log("User Profile:", userProfile);
        navigate("/");
      }
    } catch (error) {
      console.error("Authentication failed", error);
    }
  };

  const handleError = () => {
    console.error("Login Failed");
  };

  return (
    <div className="flex items-center justify-center mt-4">
      <GoogleLogin
        onSuccess={handleSuccess}
        onError={handleError}
        useOneTap
        auto_select={true}
      />
    </div>
  );
}
