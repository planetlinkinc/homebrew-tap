# typed: false
# frozen_string_literal: true

class Freeguardvpn < Formula
  desc "Command-line VPN client powered by mihomo core"
  homepage "https://freeguardvpn.com"
  version "0.2.0"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_darwin_arm64.tar.gz"
      sha256 "f2dc8ac80345cd8bdacc0b15f9f74d7888332a44b664eb5e0d5632dfa69c375a"
    else
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_darwin_amd64.tar.gz"
      sha256 "75478360c5b7232a53fa52ea3b21f8868518b7316cd4214efc3eeb1edba222c0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_linux_arm64.tar.gz"
      sha256 "c835a5add4a106af4a194ca68037af7ea04dabeee8014999da65858c6e08f1e9"
    else
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_linux_amd64.tar.gz"
      sha256 "f0768a44555c5a95e4b23de07a962c4fe508e4149918d998cf70ce91b4302c9e"
    end
  end

  def install
    bin.install "freeguard"

    # Install bundled dependencies (mihomo + GeoIP)
    freeguard_dir = "#{Dir.home}/.freeguard"
    if File.directory?(".freeguard")
      mkdir_p "#{freeguard_dir}/bin"
      cp ".freeguard/bin/mihomo", "#{freeguard_dir}/bin/mihomo" if File.exist?(".freeguard/bin/mihomo")
      chmod 0755, "#{freeguard_dir}/bin/mihomo" if File.exist?("#{freeguard_dir}/bin/mihomo")
      cp ".freeguard/geoip.metadb", "#{freeguard_dir}/geoip.metadb" if File.exist?(".freeguard/geoip.metadb")
    end
  end

  test do
    assert_match "FreeGuard CLI", shell_output("#{bin}/freeguard version")
  end
end
