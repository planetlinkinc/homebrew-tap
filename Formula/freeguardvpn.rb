# typed: false
# frozen_string_literal: true

class Freeguardvpn < Formula
  desc "Command-line VPN client powered by mihomo core"
  homepage "https://freeguardvpn.com"
  version "0.8.1"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/planetlinkinc/freeguard-releases/releases/download/v#{version}/freeguard-darwin-arm64.tar.gz"
      sha256 "0b746d439728885349b8a3f55da3354e861e33e4ce0659ac5f387916d4fd5a5f"
    else
      url "https://github.com/planetlinkinc/freeguard-releases/releases/download/v#{version}/freeguard-darwin-amd64.tar.gz"
      sha256 "75c783d0de3801cb9814179b6ef39a46b0768c5503275aff8ec6289509f57057"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/planetlinkinc/freeguard-releases/releases/download/v#{version}/freeguard-linux-arm64.tar.gz"
      sha256 "3397e56f48efdc1f1e797f340893d04e9e43ffd44db3710d8625cfa44642676a"
    else
      url "https://github.com/planetlinkinc/freeguard-releases/releases/download/v#{version}/freeguard-linux-amd64.tar.gz"
      sha256 "e0d6ce5cc83c3fc34ce49036e3e24722d6d5a64d1726da10bcfea027b8c15b84"
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
