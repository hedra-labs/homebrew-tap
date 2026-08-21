class HedraCli < Formula
  desc "Command-line interface for the Hedra Web API — API spec 3.9.0"
  homepage "https://github.com/hedra-labs/hedra-cli"
  version "3.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v3.0.0/hedra-cli-aarch64-apple-darwin.tar.gz"
      sha256 "e448ebb7cc33ba1c584e4731f11c237457e22af8995ba07401cee3d59442d953"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v3.0.0/hedra-cli-x86_64-apple-darwin.tar.gz"
      sha256 "d3b573b93e09e43ccc25d76832bbe6006e23b5c7603dea05cecf5794024a74d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v3.0.0/hedra-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "35ec20650c9a5c5cd966bb516cb9b14f72beff01abbef41720d88a90711c0338"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v3.0.0/hedra-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e1d3e79ec9c923b8f8ee46e0b17f83289c38dd01b3356a73a6b1a2dfa6ab21ce"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hedra-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hedra-cli"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hedra-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hedra-cli"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
