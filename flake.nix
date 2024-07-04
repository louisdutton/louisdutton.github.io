{
  description = "Personal website and blog";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      scripts = {
        dev = pkgs.writeShellScriptBin "dev" ''
          hugo server -D --buildDrafts
        '';
      };
    in
    {
      defaultPackage.x86_64-linux = pkgs.stdenv.mkDerivation {
        name = "website";
        src = self;
        buildInputs = [ pkgs.hugo ];
        buildPhase =
          let
            theme = pkgs.fetchFromGitHub {
              owner = "nunocoracao";
              repo = "blowfish";
              rev = "v2.72.1";
              hash = "sha256-Gacmm7l1Lbc4lw9bsJ1NBas+h+zBd1EeA8hioI8yfR0=";
            };
          in
          # bash
          ''
            hugo new site $out
            mkdir $out/themes/blowfish
            cp -r ${theme}/* $out/themes/blowfish
            cd $out
            hugo -t blowfish
          '';
      };

      devShell.${system} = pkgs.mkShell {
        buildInputs = [
          pkgs.hugo
          scripts.dev
        ];
      };

    };
}
