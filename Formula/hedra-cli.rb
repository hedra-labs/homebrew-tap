class HedraCli < Formula
  desc "Command-line interface for the Hedra Web API — API spec 3.16.6"
  homepage "https://github.com/hedra-labs/hedra-cli"
  version "5.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v5.3.0/hedra-cli-aarch64-apple-darwin.tar.gz"
      sha256 "b607cf059ef3078760d804d3fd19124ff75c1a6b2968526f8c154ee7e533c3a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v5.3.0/hedra-cli-x86_64-apple-darwin.tar.gz"
      sha256 "54f0d1404109449a00b0d26cebd96e43ec2d9c6d7eb53428e9e4c2b9e815241f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v5.3.0/hedra-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b3d8baf99945dc4d76e411b0ccbe40ff89fcd4e16989757f16c7e91586bf4b49"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v5.3.0/hedra-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6e8953f5fce2c1e74319155ee4c8bd926b147d44b3fbc383785bfa315bf8f7ee"
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
