# iCert7 — GitHub Actions build

## Upload
1. Create a **private** GitHub repository named `iCert7`.
2. Upload all files and folders from this package, preserving `.github/workflows/ios-build.yml`.
3. Open the repository's **Actions** tab.
4. Select **iCert7 iOS build**, press **Run workflow**.
5. When the run finishes, download the artifact named `iCert7-unsigned-xcarchive`.

## Important
This workflow compiles the app for a generic iOS device and creates an **unsigned Xcode archive**.
It does **not** create an installable IPA. An installable IPA requires a valid Apple signing identity
(private key + certificate) and a matching provisioning profile, applied through an Apple-supported
signing workflow. Do not put Apple ID passwords or 2FA codes into GitHub secrets or app forms.
