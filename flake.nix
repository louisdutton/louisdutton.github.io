{
  description = "Hugix: A Nix wrapper for Hugo";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      toml = pkgs.formats.toml { };

      hugix =
        cfg:
        let
          config = toml.generate "hugo.toml" cfg;
        in
        pkgs.stdenv.mkDerivation {
          pname = "hugix";
          version = "0.0.1";
          src = pkgs.fetchFromGitHub {
            owner = "nunocoracao";
            repo = "blowfish";
            rev = "v2.72.1";
            hash = "sha256-Gacmm7l1Lbc4lw9bsJ1NBas+h+zBd1EeA8hioI8yfR0=";
          };
          dontInstall = true;
          buildInputs = with pkgs; [ hugo ];
          buildPhase = ''
            hugo new site $out
            mkdir -p $out/themes/${cfg.theme}
            cp -r $src/* $out/themes/${cfg.theme}
            rm $out/hugo.toml
            cp ${config} $out/hugo.toml
          '';
        };
    in
    {
      defaultPackage.${system} = hugix {
        baseURL = "https://louisdutton.dev";
        languageCode = "en-gb";
        title = "Louis Dutton";
        theme = "blowfish";
      };
    };
}
