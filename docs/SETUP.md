# Setup and Troubleshooting

[Home](../README.md)

## Portable lessons

Install Swift 6 from the [official installation guide](https://www.swift.org/install/) for your operating system. Confirm `swift --version` and `python3 --version`. Run all commands from this repository’s root. Python 3.10+ is sufficient and no third-party Python packages are needed.

```bash
swift build
swift test
swift run study-planner
python3 scripts/verify.py
```

The verifier compiles each example as a separate executable in a temporary directory using Swift 6 language mode and warnings as errors. Files containing `@main` use `-parse-as-library`. It compares standard output to the adjacent `.expected` file and deletes temporary binaries afterward. It never calls the live networking adapter.

For a single synchronous example, this also works:

```bash
swift -swift-version 6 Examples/101/01-values-types.swift
```

For async examples, use the verifier so the entry-point flags are correct:

```bash
python3 scripts/verify.py --example 401/01-async-await
```

## Apple lessons

Use full Xcode with the macOS and iOS Simulator SDKs installed. The 501 samples use APIs available from iOS 17 or macOS 14; UIKit specifically requires iOS. Open Xcode once to finish component installation. Check your selected developer directory using `xcode-select -p`.

If `xcrun` cannot locate the simulator SDK, select your installed Xcode in **Xcode → Settings → Locations → Command Line Tools**. Command Line Tools alone do not supply every SDK used here. Follow the [sample host instructions](../AppleExamples/README.md).

## Common problems

| Symptom | Likely cause | Action |
| --- | --- | --- |
| Manifest rejects tools version | Older toolchain selected | Select an installed Swift 6 toolchain |
| `No such module UIKit` | Compiling for macOS or Linux | Use the iOS simulator target |
| `main attribute cannot be used...` | Wrong compilation mode | Run the supplied verifier |
| Output mismatch | Example or fixture changed | Inspect the behavior before updating expected output |
| `Executed 0 tests` followed by another test report | XCTest shim reports separately | Read the later Swift Testing report |
| Preview cannot find a model container | Missing SwiftData environment | Use the provided preview container |
| First build takes longer | Compiler and SDK caches are cold | Let the initial build finish; inspect actual errors if it fails |

Do not resolve concurrency diagnostics by disabling checks. Identify the value crossing an isolation boundary and its intended owner first. CI checks configured platforms; SDK type checking does not replace simulator or device interaction testing.
