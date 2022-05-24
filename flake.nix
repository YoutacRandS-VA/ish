{
  description = "Linux shell for iOS";

  inputs = {
    mars-std.url = "github:mars-research/mars-std";
  };

  outputs = { self, mars-std, ... }: let
    # System types to support.
    supportedSystems = [ "x86_64-linux" ];
  in mars-std.lib.eachSystem supportedSystems (system: let
    pkgs = mars-std.legacyPackages.${system};
  in {
    devShell = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        meson ninja pkg-config
        sqlite libarchive
        llvmPackages_12.lld
        llvmPackages_12.clang-unwrapped
      ];
    };
  });
}
