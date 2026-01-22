# Flutter File Download & Storage Setup
---
## 📦 Dependencies (`pubspec.yaml`)

```yaml
dependencies:
  get: ^4.6.6
  dio: ^5.4.0
  permission_handler: ^11.3.0
  file_saver: ^0.2.12
  device_info_plus: ^10.1.0
```
## 🤖 Android Configuration

### AndroidManifest.xml

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

## 🍎 iOS Configuration

### Info.plist

```xml
<key>LSSupportsOpeningDocumentsInPlace</key>
<true/>
<key>UIFileSharingEnabled</key>
<true/>
```
