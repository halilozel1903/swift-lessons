# Glossary

[Home](../README.md)

| Term | Meaning in this course |
| --- | --- |
| Actor | A reference type that isolates mutable state |
| ARC | Automatic Reference Counting for class-instance lifetimes |
| Associated type | A protocol placeholder selected by a conforming type |
| Associated value | Data carried by a particular enum case |
| Binding | A read/write connection to state owned elsewhere |
| Codable | The combination of Encodable and Decodable |
| Copy-on-write | Shared storage that becomes independent when mutation requires it |
| Dependency injection | Passing a collaborator into its consumer |
| Existential | A value abstracted behind a protocol, commonly written with `any` |
| Generic | Code parameterized by types while preserving their relationships |
| Identity | Whether two references designate the same instance |
| Invariant | A rule that must hold for every valid instance or state |
| Isolation | Rules governing which execution context may access state |
| Main actor | The global actor used for main-thread UI work |
| Opaque result | A hidden but consistent underlying result type, written with `some` |
| Optional | A value that may be present or absent |
| Reentrancy | Another actor operation can run while an async operation is suspended |
| Sendable | A concurrency-safety contract for values crossing isolation boundaries |
| Structured concurrency | Child-task lifetimes bounded by their parent scope |
| Suspension point | A place where async execution may pause without blocking its thread |
| Target | A build unit in a Swift package |
| Value semantics | Independent observable values after assignment and mutation |

The glossary gives orientation, not a replacement for precise language rules. Follow the [official references](RESOURCES.md) for those details.
