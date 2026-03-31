return {
  name = "lit/bad-package-lua",
  version = "1.0.0",
  dependencies = {
    "my-luvit/weblit-app@2.1.1" -- missing comma
    "my-luvit/weblit-auto-headers@2.0.2"
  },
  files = {
    "**.lua",
    "!test*",
    "!example*"
  }
}