{
  description = "Personal website and blog";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hugix.url = "github:louisdutton/hugix";
  };

  outputs =
    { hugix, nixpkgs, ... }:
    let
      name = "website";
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = hugix.lib.generate {
        inherit system name;
        theme = pkgs.fetchFromGitHub {
          owner = "nunocoracao";
          repo = "blowfish";
          rev = "v2.72.1";
          hash = "sha256-Gacmm7l1Lbc4lw9bsJ1NBas+h+zBd1EeA8hioI8yfR0=";
        };
        cfg = {
          baseURL = "https://louisdutton.dev";
          languageCode = "en-gb";
          title = "Louis Dutton";
          theme = "blowfish";
        };
      };
    };
}
