import GoogleLoginButton from "../auth/googleOauth/GoogleLoginButton";

export default function SignIn() {
  return (
    <div className="h-full flex flex-col  items-center justify-center">
      <div className="font-semibold"> Welcome to the Roadmap App!</div>
      <GoogleLoginButton />
    </div>
  );
}
