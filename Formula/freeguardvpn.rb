# typed: false
# frozen_string_literal: true

class Freeguardvpn < Formula
  desc "Command-line VPN client powered by mihomo core"
  homepage "https://freeguardvpn.com"
  version "0.1.1"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_darwin_arm64.tar.gz"
      sha256 "1e72e776b96b5f7385e0c6d55cd781a61c89f091283c50dc213035137b7c6bfb"
    else
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_darwin_amd64.tar.gz"
      sha256 "b020600881e3027f08fdf2a3bddcb76b6a57f0c3ef3144f70da2df02d85036a6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_linux_arm64.tar.gz"
      sha256 "d7ea26d05fcee2d693c31bf590072ac4e37adb67f4f8c9bff7f4b6b6a0b20990"
    else
      url "https://downloadcli.freeguardvpn.com/cli/v#{version}/freeguard-cli_#{version}_linux_amd64.tar.gz"
      sha256 "daa4b7987550ba5ab6c66512b83eeca5abe347c27fc401664ae57a7b5b8fcc59"
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
