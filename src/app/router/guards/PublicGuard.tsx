interface Props {
  children: React.ReactNode;
}

export default function PublicGuard({ children }: Props): React.ReactNode {
  return (
    <div>
      <div className="font-extrabold">Public Route</div>
      {children}
    </div>
  );
}
