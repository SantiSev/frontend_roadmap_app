import GoogleLoginButton from "../auth/googleOauth/GoogleLoginButton";

const SignIn: React.FC = () => {
  return (
    <div className="w-screen flex flex-col  items-center justify-center">
      <div className="font-semibold"> Welcome to the Roadmap App!</div>
      <GoogleLoginButton />
    </div>
  );
};

export default SignIn;
