cask "tablepro" do
  arch arm: "arm64", intel: "x86_64"

  version "0.39.0"
  sha256 arm:   "ddf8bde0c784e4492f96e7f17cc1d1a800200fd73969e1129f84e03c0a4e1eeb",
         intel: "65c84c9c77b841f147eb4390bb9f487457238734436a7a394e9a62e7f1bc0f50"

  url "https://github.com/TableProApp/TablePro/releases/download/v#{version}/TablePro-#{version}-#{arch}.dmg",
      verified: "github.com/TableProApp/TablePro/"
  name "TablePro"
  desc "Native database client for many database types"
  homepage "https://tablepro.app/"

  livecheck do
    url "https://raw.githubusercontent.com/TableProApp/TablePro/main/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: ">= :sonoma"

  app "TablePro.app"

  zap trash: [
    "~/Library/Application Support/TablePro",
    "~/Library/Caches/com.TablePro",
    "~/Library/HTTPStorages/com.TablePro",
    "~/Library/Preferences/com.TablePro.plist",
  ]
end
