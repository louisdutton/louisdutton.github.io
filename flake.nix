{
  description = "Personal website and blog";

  inputs = {
    hugix.url = "github:louisdutton/hugix";
    theme = {
      url = "github:nunocoracao/blowfish";
      flake = false;
    };
  };

  outputs =
    { hugix, theme, ... }:
    let
      name = "website";
      system = "x86_64-linux";
    in
    {
      packages.${system}.default = hugix.lib.generate {
        inherit system name theme;
        content = ./content;
        cfg = import ./config.nix;
      };
    };
}
