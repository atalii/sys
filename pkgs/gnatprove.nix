{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "gnatprove";
  version = "13.2.0-1";

  src = fetchTarball {
    url = "https://github.com/alire-project/GNAT-FSF-builds/releases/download/gnatprove-13.2.0-1/gnatprove-x86_64-linux-13.2.0-1.tar.gz";
    sha256 = "18ljqhgd4ih7vidwsqvn7d690c1wzlriw5xykxbhmfm31a5i2b2p";
  };

  installPhase = ''
    cp -r $src $out
  '';

  nativeBuildInputs = with pkgs; [ autoPatchelfHook ];

  buildInputs = with pkgs; [ zlib ];
}
