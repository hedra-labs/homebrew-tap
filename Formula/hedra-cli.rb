class HedraCli < Formula
  desc "Command-line interface for the Hedra Web API — API spec 3.13.3"
  homepage "https://github.com/hedra-labs/hedra-cli"
  version "4.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v4.0.0/hedra-cli-aarch64-apple-darwin.tar.gz"
      sha256 "15a2be8c4c5b7415bd92a485f56061f4ed9f45f424d9091477a44facb8dd4dc9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v4.0.0/hedra-cli-x86_64-apple-darwin.tar.gz"
      sha256 "5ec9e1c4ba66c7f6b726aa8a88b57aacdd9fa83dd3d57a6b379663d8c85771a5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v4.0.0/hedra-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dd472ec7a70c68e4da12d8c4969ab40446c6ac8a1d7a3f24bd0439e0536d79a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v4.0.0/hedra-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3a79dbc8b47e85fbf48bd5c79e707e03392e34526cee661843f049e71ea94829"
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
