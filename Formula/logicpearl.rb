# typed: false
# frozen_string_literal: true

class Logicpearl < Formula
  desc "Deterministic policy artifacts from observed decision traces"
  homepage "https://logicpearl.com"
  version "0.1.5"
  license "MIT"

  depends_on "z3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/LogicPearlHQ/logicpearl/releases/download/v0.1.5/logicpearl-aarch64-apple-darwin.tar.gz"
      sha256 "6e862e95f6e79a953c4e445763467f9211b59c813b825e3fff609a922bf628b6"
    else
      url "https://github.com/LogicPearlHQ/logicpearl/releases/download/v0.1.5/logicpearl-x86_64-apple-darwin.tar.gz"
      sha256 "76e58a5c59f08ab9686e8905d9a3762a05b0b7bb562b41370110ec669114e3fb"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/LogicPearlHQ/logicpearl/releases/download/v0.1.5/logicpearl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c14d888757d8ab29bee203fb2f50befb8d31aba7c13167c9a822f674b32df791"
    end
  end

  def install
    bundle = if (buildpath/"bin/logicpearl").exist?
      buildpath
    else
      Pathname.glob(buildpath/"logicpearl-v*-*").first
    end
    odie "LogicPearl bundle directory was not found" if bundle.nil?

    bin.install bundle/"bin/logicpearl"
    pkgshare.install bundle/"bundle_manifest.json" if (bundle/"bundle_manifest.json").exist?
    doc.install bundle/"README.txt" if (bundle/"README.txt").exist?
    doc.install bundle/"THIRD_PARTY_NOTICES.txt" if (bundle/"THIRD_PARTY_NOTICES.txt").exist?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/logicpearl --version")
    assert_match "quickstart", shell_output("#{bin}/logicpearl --help")
  end
end
