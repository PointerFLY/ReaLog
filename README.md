# ReaLog
An interactive iOS log monitoring tool.

## Introduction
<img src="https://github.com/PointerFLY/warehouse/blob/master/gifs/ReaLog.gif" width="260">

ReaLog shows log messages directly on screen, which helps developers to access infos when application is running.

## Usage
Add ReaLog to your project with only one line of code!

```Swift
ReaLog.shared.enable()
```
Then you can make thread safe visible logs anywhere, they'll show on the ReaLog window. 

```Swift
ReaLog.shared.addLog("Any log message you want to show")
```

You can either configure or disable ReaLog. 

```Swift
ReaLog.shared.lineFeed = "\n"
ReaLog.shared.dateFormatter.dateFormat = "HH:mm:ss"

ReaLog.shared.window?.floatingBallFrame = CGRect(x: 20, y: 300, width: 60, height: 60)
ReaLog.shared.window?.logViewFrame = CGRect(x: 100, y: 100, width: 200, height: 300)

ReaLog.shared.disable()
...
```

## Requirements
- iOS 8.0+ 
- Xcode 9.0+
- Swift 4.0+

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "PointerFLY/ReaLog" ~> 0.3.0
```
Run `carthage update` to build the framework and drag the built `ReaLog.framework` into your Xcode project.

### Manually 
Download project, open with Xcode, compile the ReaLog framework, retrieve the framework product, and embed it in any other Xcode project.





