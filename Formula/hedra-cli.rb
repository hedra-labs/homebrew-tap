class HedraCli < Formula
  desc "Command-line interface for the Hedra Web API — API spec 3.17.8"
  homepage "https://github.com/hedra-labs/hedra-cli"
  version "6.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v6.1.0/hedra-cli-aarch64-apple-darwin.tar.gz"
      sha256 "5ba39104d89292ac11f6cc9187dcf2852ba0cfdf9e4ff5b0c244f4eb37ce231f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v6.1.0/hedra-cli-x86_64-apple-darwin.tar.gz"
      sha256 "1e6127e676484db758848b0ef9c754c2a233c1893700378bdcc0db559b05a3da"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v6.1.0/hedra-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8d3b27ab422c9b32b7e7f7504d0446d8308d0eab1142bafb010feebf7c6ee59c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v6.1.0/hedra-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7afd0fb50794ef758369045f62c3a61dde22c36e2fc8b2fe7009108fc599c3f4"
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
