class HedraCli < Formula
  desc "Command-line interface for the Hedra Web API — API spec 3.22.0"
  homepage "https://github.com/hedra-labs/hedra-cli"
  version "8.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v8.0.0/hedra-cli-aarch64-apple-darwin.tar.gz"
      sha256 "7aa3d384dd81a3427715eb206163c3a6e081f2d5a38ec466f76c0bdeb6c9000c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v8.0.0/hedra-cli-x86_64-apple-darwin.tar.gz"
      sha256 "2409f6a85f9f91ac00265e310f00c510b91f527e91e3367d4e97daf051b0be14"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v8.0.0/hedra-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eef27506970b669c6830aee086ad6d4d0ce4b19d3253aef5fc65648bbc457216"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hedra-labs/hedra-cli/releases/download/v8.0.0/hedra-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "98b92362e84bfc31844de96cd4a41b9daf2041c6e033c8070ad555e7d0dee1e9"
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
