# Github-Release-Action
Publish Github releases from package.json changes in an action

## Usage
An example workflow
```
workflow "Publish Release" {
  on = "push"
  resolves = ["create release"]
}

action "create release" {
  uses = "bbenoist/Github-Release-PackageJson-Action@master"
  args = "Automated release triggered from package.json"
  secrets = ["GITHUB_TOKEN"]
}
```

## Argument

The message which should appear in the release
