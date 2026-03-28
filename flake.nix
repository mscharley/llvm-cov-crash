{
	description = "Minimal repro: llvm-cov SIGSEGV with --branch on async_trait code";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		flake-utils.url = "github:numtide/flake-utils";
		rust-overlay = {
			url = "github:oxalica/rust-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, flake-utils, rust-overlay }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				overlays = [ (import rust-overlay) ];
				pkgs = import nixpkgs {
					inherit system overlays;
				};
				rustToolchain = pkgs.rust-bin.nightly.latest.default.override {
					extensions = [ "llvm-tools-preview" ];
				};
			in
			{
				devShells.default = pkgs.mkShell {
					buildInputs = [
						rustToolchain
						pkgs.cargo-llvm-cov
					];
				};
			}
		);
}
