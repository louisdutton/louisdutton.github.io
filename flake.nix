{
  description = "Personal website and blog";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShell.${system} = pkgs.mkShell {
        buildInputs = [ pkgs.hugo ];

        # shellHook = # bash
        #   ''
        #     # bundle install 
        #     export BUNDLE_FORCE_RUBY_PLATFORM=true;
        #   '';
      };
    };
}
