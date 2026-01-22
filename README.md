# Flutter File Download & Storage Setup
---
## 📦 Dependencies (`pubspec.yaml`)

```yaml
dependencies:
  get: ^4.7.3
  dio: ^5.9.0
  permission_handler: ^12.0.1
  file_saver: ^0.3.1
  device_info_plus: ^12.3.0
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
