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
    hugix.lib.hugoSite {
      inherit theme;
      system = "x86_64-linux";
      contentDir = ./content;
      config = import ./config.nix;
    };
}
