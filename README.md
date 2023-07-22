# Le_Snacks

Eth Global Paris 2023

## Getting Started

install
```bash 
brew install swiftlint
```

fix all
`swiftlint --fix`

fastlane setup
```bash
xcode-select --install
brew install fastlane
fastlane init
```

fastlane screenshots
```bash
fastlane snapshot init
```

fastlane to testflight 

add to fastfile 
```
lane :beta do
  build_app(scheme: "LeSnacks",
            workspace: "LeSnacks.xcworkspace",
            include_bitcode: true)
end

```

```bash
fastlane beta
```
