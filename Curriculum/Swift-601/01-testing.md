# Testing Behavior and Failure Paths

Swift 601 · Engineering and Delivery · 30–45 minutes plus practice

[Level overview](README.md) · [Next lesson](02-architecture.md)

## Before you start

Complete Swift 501 or demonstrate its exit criteria. You should be able to explain the behavior in this lesson and adapt its example to a different input before moving on.

## The concept

A useful test describes observable behavior and fails when that behavior regresses. Prefer boundary cases and meaningful invariants over tests that simply repeat an implementation. Keep time, randomness, networking, and persistent state under control by injecting dependencies or using fixtures.

The capstone uses Swift Testing with #expect, throwing tests, async tests, and parameterized inputs. Tests can execute concurrently, so each test creates its own state. The example below is a runnable algorithm demonstration; the actual test declarations live in Tests/LearningCoreTests. Read those tests alongside the model and identify the contract each protects.

## Worked example

[Complete source](../../Examples/601/01-testing.swift)

```swift
func completionRate(completed: Int, total: Int) -> Double? {
    guard total >= 0, completed >= 0, completed <= total else { return nil }
    return total == 0 ? 0 : Double(completed) / Double(total)
}
let cases = [(0, 0), (1, 2), (2, 2), (3, 2)]
for (completed, total) in cases {
    if let rate = completionRate(completed: completed, total: total) {
        print("\(completed)/\(total): \(rate)")
    } else {
        print("\(completed)/\(total): invalid")
    }
}
```

## Run it

Run commands from the repository root.

```bash
python3 scripts/verify.py --example 601/01-testing
```

Expected output:

```text
0/0: 0.0
1/2: 0.5
2/2: 1.0
3/2: invalid
```

## Why it works

The function defines empty-plan behavior rather than dividing by zero. Invalid states produce nil. In the capstone, validated models prevent many such invalid states from existing in the first place.

## Common mistake

A green unit suite does not establish accessibility, UI navigation, performance, or live-server compatibility. Maintain separate integration and manual checks for those contracts.

## Practice

Add a parameterized test for the four cases, then add a negative completed count. Decide whether nil or a typed error makes the better API.

<details>
<summary>Solution direction — try it yourself first</summary>

Assert exact results for the boundary cases and absence for invalid inputs. Choose a typed error when callers need to explain why the input was rejected.

</details>

## Check your understanding

- Explain the example without reading it line by line.
- Identify which behavior belongs to the language and which behavior is a design choice in this example.
- Try one valid boundary input and one invalid input; describe the intended result before running it.

## Continue

Read the next lesson from the [level overview](README.md). Use the [official references](../../docs/RESOURCES.md) for language and framework details.
