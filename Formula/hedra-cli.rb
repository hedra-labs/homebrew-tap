class HedraCli < Formula
  desc "Command-line interface for the Hedra Web API — API spec 3.24.10"
  homepage "https://www.hedra.com/docs"
  version "9.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v9.0.0/hedra-cli-aarch64-apple-darwin.tar.gz"
      sha256 "faf88a18ff28cdaeaa9744cff5f3bf81c1ef1534a5dd67482b2aa92652c6cafa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v9.0.0/hedra-cli-x86_64-apple-darwin.tar.gz"
      sha256 "20f66895a840f20d0ccbb564cdce573c2e2015b60fbe7095b961394166f984e5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v9.0.0/hedra-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ae2e2f5ff0a20ef4b463be3e059214976a720a3d97b3c240820cc2f66a06ee0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v9.0.0/hedra-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "22cf7eab7aa109778074e92a3d69e466d0da04fc7c8e7d038524ddc49aac175d"
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
