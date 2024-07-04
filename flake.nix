{
  description = "Hugix: A Nix wrapper for Hugo";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      toml = pkgs.formats.toml { };
      hugix =
        cfg:
        let
          config = toml.generate "hugo.toml" cfg;
          theme = pkgs.fetchFromGitHub {
            owner = "nunocoracao";
            repo = "blowfish";
            rev = "v2.72.1";
            hash = "sha256-Gacmm7l1Lbc4lw9bsJ1NBas+h+zBd1EeA8hioI8yfR0=";
          };
        in
        pkgs.stdenv.mkDerivation {
          pname = "hugix";
          version = "0.0.1";
          dontInstall = true;
          src = theme;
          buildInputs = with pkgs; [ hugo ];
          buildPhase = ''
            hugo new site tmp
            mkdir -p tmp/themes/${cfg.theme}
            cp -r $src/* tmp/themes/${cfg.theme}
            hugo -s tmp -c ${config} -d $out --noBuildLock
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
