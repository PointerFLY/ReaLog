# ReaLog
An interactive iOS log monitoring tool.

## Introduction
![ReaLog](https://github.com/PointerFLY/warehouse/blob/master/gifs/ReaLog.gif)

ReaLog shows log messages directly on screen, which helps developers to access infos when application is running.

## Usage
Add ReaLog to your project with only one line of code!

```Swift
ReaLog.shared.enable()
```
Then you can make visible logs anywhere, they'll show on the ReaLog window.

```Swift
ReaLog.shared.addLog("Any log message you want to show")
```

You can either configure or disable ReaLog. 

```Swift
ReaLog.shared.disable()
ReaLog.shared.isAutoAddLineFeed = true
...
```

## Requirements
- iOS 8.0+ 
- Xcode 8.2+
- Swift 3.0+

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "PointerFLY/ReaLog" ~> 0.1
```
Run `carthage update` to build the framework and drag the built `Alamofire.framework` into your Xcode project.

### Manually 
Download project, open with Xcode, compile the ReaLog framework, retrieve the framework product, and embed it in any other Xcode project.





