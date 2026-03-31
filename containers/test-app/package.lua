return {
    name = "my-luvit/lit-sample-docker-app",
    version = "0.0.0",
    private = true,
    dependencies = {
      "my-luvit/require@2",
      "my-luvit/pretty-print@2",
      "my-luvit/coro-fs@2",
      "my-luvit/weblit-app@3",
      "my-luvit/weblit-auto-headers@2",
      "my-luvit/weblit-logger@2"
    },
    files = {"**.lua", "!test*"}
}
