cask "firefox@nightly" do
  version "152.0a1,2026-05-07-02-12-36"

  language "ca" do
    sha256 "22bfe37d6ca6c11c5a7f683d9146832ca7ad4bbd7cc2dedbc8eb5f58a39b6b0e"
    "ca"
  end
  language "cs" do
    sha256 "2b5956399bbf5086604d3582fc935b8b59aa87db6f7a74849fae82c540f02827"
    "cs"
  end
  language "de" do
    sha256 "bfc9e2900f809ea44a8ac20e8cf8570695b5fe9871fbc3fc6b923c12f50b3f11"
    "de"
  end
  language "en-CA" do
    sha256 "1b100daf872e98a684bf2a87aa3f40950385f115a35108bbf359d34e57cba4d9"
    "en-CA"
  end
  language "en-GB" do
    sha256 "aeb5895e7944b91ba65c8c153697d8597271569e384a9690492d41571838e31f"
    "en-GB"
  end
  language "en", default: true do
    sha256 "b003162ab4c11aa08bb6c0012b5e6d6484611d6b4c52f7d002ddec40a74b9072"
    "en-US"
  end
  language "es" do
    sha256 "5be71648e86679a0e2d6409db53224d36eac220af8505ec0051da50846f7d1ca"
    "es-ES"
  end
  language "fr" do
    sha256 "b7a5320474d901e393da379f7190e2d95bd70f5352dc2b6f2f4ead1a5ebe1eae"
    "fr"
  end
  language "it" do
    sha256 "075a023c823ba01210d1170c5e935c306af32799f45f047a4dd7347f34cec4ef"
    "it"
  end
  language "ja" do
    sha256 "f07ca9fe638f10dc52a67c48ea176076229546cde5efe0c7ea1f9f6d623842ef"
    "ja-JP-mac"
  end
  language "ko" do
    sha256 "56ab21ecbd07ec668b0f9d546ea1353f53007e0682400aa2c5166d04e215bbf8"
    "ko"
  end
  language "nl" do
    sha256 "79a33c9ff64959d88f0fa0e2097aabbc365ef88cfec28429d104de725f1643ac"
    "nl"
  end
  language "pt-BR" do
    sha256 "4dff332c0be881df6036e58746dd030f3827d2612e2f32c54e06f438d3ef8c2a"
    "pt-BR"
  end
  language "ru" do
    sha256 "761f2c7fcb36d4e1f4256f469100db7e863f45477a02a7045443e1e82214f552"
    "ru"
  end
  language "uk" do
    sha256 "45b8f6105dbfeea4d27d19e25dbf93385a59457d7ea7fc70929dc63194afce98"
    "uk"
  end
  language "zh-TW" do
    sha256 "64bddb467c7c7ad428f32a9623e5fc44de6d209f74f492aa1058bc39ffd2d7e7"
    "zh-TW"
  end
  language "zh" do
    sha256 "5dae9f8be664de970da0c289eab0e9505819947bcef653b777272f420bad3da9"
    "zh-CN"
  end

  url "https://ftp.mozilla.org/pub/firefox/nightly/#{version.csv.second.split("-").first}/#{version.csv.second.split("-").second}/#{version.csv.second}-mozilla-central#{"-l10n" if language != "en-US"}/firefox-#{version.csv.first}.#{language}.mac.dmg"
  name "Mozilla Firefox Nightly"
  desc "Web browser"
  homepage "https://www.mozilla.org/firefox/channel/desktop/#nightly"

  livecheck do
    url "https://product-details.mozilla.org/1.0/firefox_versions.json"
    regex(%r{/(\d+(?:[._-]\d+)+)[^/]*/firefox}i)
    strategy :json do |json, regex|
      version = json["FIREFOX_NIGHTLY"]
      next if version.blank?

      content = Homebrew::Livecheck::Strategy.page_content("https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central/firefox-#{version}.en-US.mac.buildhub.json")
      next if content[:content].blank?

      build_json = Homebrew::Livecheck::Strategy::Json.parse_json(content[:content])
      build = build_json.dig("download", "url")&.[](regex, 1)
      next if build.blank?

      "#{version},#{build}"
    end
  end

  auto_updates true
  depends_on :macos

  app "Firefox Nightly.app"

  zap trash: [
        "/Library/Logs/DiagnosticReports/firefox_*",
        "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.mozilla.firefox.sfl*",
        "~/Library/Application Support/CrashReporter/firefox_*",
        "~/Library/Application Support/Firefox",
        "~/Library/Caches/Firefox",
        "~/Library/Caches/Mozilla/updates/Applications/Firefox",
        "~/Library/Caches/org.mozilla.firefox",
        "~/Library/Preferences/org.mozilla.firefox.plist",
        "~/Library/Saved Application State/org.mozilla.firefox.savedState",
        "~/Library/WebKit/org.mozilla.firefox",
      ],
      rmdir: [
        "~/Library/Application Support/Mozilla", #  May also contain non-Firefox data
        "~/Library/Caches/Mozilla",
        "~/Library/Caches/Mozilla/updates",
        "~/Library/Caches/Mozilla/updates/Applications",
      ]
end
