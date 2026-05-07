cask "hive-app" do
  arch arm: "-arm64"

  version "1.1.0"
  sha256 arm:   "e3924186da517038b656e931f6b513bf22a7c00d885231f74aaebf9b8cbf3218",
         intel: "c13449d99c297c8c46941b14cae850f7f98fd05c9808710ed69e3fbb51709f2f"

  url "https://github.com/morapelker/hive/releases/download/v#{version}/Hive-#{version}#{arch}.dmg"
  name "Hive"
  desc "AI agent orchestrator for parallel coding across projects"
  homepage "https://github.com/morapelker/hive"

  auto_updates true
  depends_on macos: ">= :monterey"

  app "Hive.app"

  zap trash: [
    "~/.hive",
    "~/Library/Application Support/hive",
    "~/Library/Logs/hive",
    "~/Library/Preferences/com.hive.app.plist",
    "~/Library/Saved Application State/com.hive.app.savedState",
  ]
end
