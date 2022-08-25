# clima

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Vault
You need to create vault secrets for openweather.org in assets/vault/secrets.json.

For instance:
```json
[
  {
    "appid": "0e1ba6a9adf8a6cc75b086c7a68acecc"
  }
]
```

Also you need to configure assets folder on pubspec.yaml:

```yaml
  assets:
    - images/
    - assets/vault/secrets.json
```
