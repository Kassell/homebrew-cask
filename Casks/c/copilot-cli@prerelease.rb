cask "copilot-cli@prerelease" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.44-0"
  sha256 arm:          "1399108171c906127a4e9a14e303a5de99d7fe15421b9f407a41bd16296245f5",
         intel:        "4e16cff2dabcb1c9905e86984dcb2399f046edfe8b19c63ba4e8ce6f7af37cd3",
         arm64_linux:  "f795dabdce35fa1d82df196b1771d92187523ad0f19cd46579b1f860e7e410e1",
         x86_64_linux: "4fc845f0f37694330ee8796859503c1cbbc36018f3509e1b5931003f1b557ff8"

  url "https://github.com/github/copilot-cli/releases/download/v#{version}/copilot-#{os}-#{arch}.tar.gz"
  name "GitHub Copilot CLI"
  desc "Brings the power of Copilot coding agent directly to your terminal"
  homepage "https://docs.github.com/en/copilot/concepts/agents/about-copilot-cli"

  livecheck do
    url :url
    regex(/^v?(\d+(?:[.-]\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  auto_updates true
  conflicts_with cask: "copilot-cli"
  depends_on macos: ">= :ventura"

  binary "copilot"

  zap trash: "~/.copilot"
end
