class HedraCli < Formula
  desc "Command-line interface for the Hedra Web API — API spec 3.9.0"
  homepage "https://github.com/hedra-labs/hedra-cli"
  version "3.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v3.0.2/hedra-cli-aarch64-apple-darwin.tar.gz"
      sha256 "07de4a551d546b2fa4c53c04c4402d531c966df6cc181f9fa97af4243d677b49"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v3.0.2/hedra-cli-x86_64-apple-darwin.tar.gz"
      sha256 "dcc93b64b381a8597b67918ae5dcfdf74976b3bad95f6b87a9e4edd142b2972f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v3.0.2/hedra-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "50db00d2ad744f3d404be32efad9de8d56ef450c63b78b4adf1c59dc13e70d34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v3.0.2/hedra-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c774511bf460409d81dc699a8b627e7dbbc5e92ef79292120359bd828b28d1c7"
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
