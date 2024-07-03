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
      devShell.${system} = pkgs.mkShell {
        buildInputs = [
          pkgs.hugo
          scripts.dev
        ];
      };
    };
}
