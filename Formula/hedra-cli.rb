class HedraCli < Formula
  desc "Command-line interface for the Hedra Web API — API spec 3.16.9"
  homepage "https://github.com/hedra-labs/hedra-cli"
  version "5.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v5.4.0/hedra-cli-aarch64-apple-darwin.tar.gz"
      sha256 "86c82fbc7be24190a2d9bc7e7eb8891b3f8ef2a5132fb41b6c74f5b88fe3be7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v5.4.0/hedra-cli-x86_64-apple-darwin.tar.gz"
      sha256 "f1e257c38c18f4c6d7bf42f78659a86d9fb27c653773b0a99025908e2f4864e0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v5.4.0/hedra-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d999fe79e41ee27c5788ebdc172b4c02032d88f2585297beebe208a6704a28bf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v5.4.0/hedra-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "225335a8b2d8d139ba7aa3f11710b90d13c41de901f31cb8fd8b4f938b92b488"
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
