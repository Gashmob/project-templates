{ stdenv
, cmake
, ninja
}:

stdenv.mkDerivation {
  pname = "my_lib";
  version = "0.1.0";

  src = ./../..;

  nativeBuildInputs = [ cmake ninja ];
}
