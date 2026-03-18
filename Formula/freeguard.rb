# typed: false
# frozen_string_literal: true

class Freeguard < Formula
  desc "Command-line VPN client powered by mihomo core"
  homepage "https://freeguardvpn.com"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_darwin_arm64.tar.gz"
      sha256 "40acc453b52e8600180ac10d95868bde69156417c10b9f753d21f494554e6535"
    else
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_darwin_amd64.tar.gz"
      sha256 "cd0ddd53d78e9c2b07d9882c91655e8c21814ccee58e4c23f496a6d5c0e39b76"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_linux_arm64.tar.gz"
      sha256 "c0e2227d27ebbee2a2d5d581a7309822143f0ab900d7873dcaa98720244d87cb"
    else
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_linux_amd64.tar.gz"
      sha256 "0f54a5ca0c2a284473c5142060ce7da5232aa0460bf75eda91d44e47eccb83d5"
    end
  end

  def install
    bin.install "freeguard"
  end

  test do
    assert_match "FreeGuard CLI", shell_output("#{bin}/freeguard version")
  end
end
