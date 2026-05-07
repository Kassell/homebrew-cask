cask "thunderbird@daily" do
  version "152.0a1,2026-05-07-09-18-06"

  language "cs" do
    sha256 "97e28803f65cd79c50b898db6ac60253dd8f6b7d4a66afbee65143e6161a6f1e"
    "cs"
  end
  language "de" do
    sha256 "4ca92295f9756e1d035c44ce2326198cba6fb6ae1f9900eff922103ccd2ac883"
    "de"
  end
  language "en-GB" do
    sha256 "880c653d82efee7067ad6e81350a35ee226c4fd01f90461c999ad3a9895082c6"
    "en-GB"
  end
  language "en", default: true do
    sha256 "d7ab5e1d8ae07146887e180833ec80cb4134e010390a56e53de59f4aa9a5010b"
    "en-US"
  end
  language "fr" do
    sha256 "53421a716c068291c55f2f7f954555b3faf7848899509bf1277b9cf217f5312d"
    "fr"
  end
  language "gl" do
    sha256 "da518fd3cf5235b52854d58ca742bd4de92527f1be9ac9ca024614c2aed636fc"
    "gl"
  end
  language "it" do
    sha256 "e8d27cf2c6c7c61519d0c065e37e311bed5ebdb48a26781e0d8bcdcf02a2982f"
    "it"
  end
  language "ja" do
    sha256 "45d8f998424929eebd294c40d68267a20a9ddca03f27b97d133d8988db2e56a1"
    "ja-JP-mac"
  end
  language "nl" do
    sha256 "a68d2489d295ab3f39449fb11ed4fa60d60af32610c509cdb41637538432fdc5"
    "nl"
  end
  language "pl" do
    sha256 "8ebfcdf371552014ccb79e0a5b26a264b1bfdf2e897ffcaef6a9daf387a8b3eb"
    "pl"
  end
  language "pt" do
    sha256 "8a9ae23f6e85923826fcfbe9a1e0a9249dc57d12692308cccbf1cd61f72bf866"
    "pt-PT"
  end
  language "pt-BR" do
    sha256 "ebf51852847cc7f3d3eee0ae819b4ce3f0883126fba05f7806c51a5a244c0fb4"
    "pt-BR"
  end
  language "ru" do
    sha256 "cb675afbe849981bdb946ed85bb2a8e8842485450a1fa19180a2700b25f8149b"
    "ru"
  end
  language "uk" do
    sha256 "dff19a62545d4e8129a02c4e8c618c44d8fd7a8a17e38ae8ea1b3c14fc5ada89"
    "uk"
  end
  language "zh-TW" do
    sha256 "5539e926b840dbfcc2c8b9650217d4930890c6dcf089067c340612d7c129573f"
    "zh-TW"
  end
  language "zh" do
    sha256 "50788260602da792f0c974026a6fb7cf79ebd5c5a83ac03019bbee2c010f8636"
    "zh-CN"
  end

  url "https://ftp.mozilla.org/pub/thunderbird/nightly/#{version.csv.second.split("-").first}/#{version.csv.second.split("-").second}/#{version.csv.second}-comm-central#{"-l10n" if language != "en-US"}/thunderbird-#{version.csv.first}.#{language}.mac.dmg",
      verified: "ftp.mozilla.org/"
  name "Mozilla Thunderbird Daily"
  desc "Customizable email client"
  homepage "https://www.thunderbird.net/#{language}/download/daily/"

  livecheck do
    url "https://product-details.mozilla.org/1.0/thunderbird_versions.json"
    regex(%r{/(\d+(?:[._-]\d+)+)[^/]*/thunderbird}i)
    strategy :json do |json, regex|
      version = json["LATEST_THUNDERBIRD_NIGHTLY_VERSION"]
      next if version.blank?

      content = Homebrew::Livecheck::Strategy.page_content("https://ftp.mozilla.org/pub/thunderbird/nightly/latest-comm-central/thunderbird-#{version}.en-US.mac.buildhub.json")
      next if content[:content].blank?

      build_json = Homebrew::Livecheck::Strategy::Json.parse_json(content[:content])
      build = build_json.dig("download", "url")&.[](regex, 1)
      next if build.blank?

      "#{version},#{build}"
    end
  end

  auto_updates true
  depends_on :macos

  app "Thunderbird Daily.app"

  zap trash: [
        "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.mozilla.thunderbird*.sfl*",
        "~/Library/Caches/Mozilla/updates/Applications/Thunderbird*",
        "~/Library/Caches/Thunderbird",
        "~/Library/Preferences/org.mozilla.thunderbird*.plist",
        "~/Library/Saved Application State/org.mozilla.thunderbird*.savedState",
        "~/Library/Thunderbird",
      ],
      rmdir: "~/Library/Caches/Mozilla"
end
