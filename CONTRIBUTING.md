# Contributing

Thank you for helping make Swift easier to learn. Keep lesson prose, code comments, identifiers, issues, and pull requests in English. Prefer concrete explanations, small examples, and documented tradeoffs.

## Propose a change

Open an issue for a substantial new topic or structural change. Small corrections can go directly to a pull request. Describe the learner problem, the proposed improvement, and the toolchain or platform involved. Avoid posting credentials or private project data.

## Local workflow

1. Fork and clone the repository, then create a focused branch.
2. Update the lesson and its complete source together.
3. Update expected output only when the intended behavior changes.
4. Run the required checks below.
5. Open a pull request with the behavior change and verification results.

```bash
swift test
swift run study-planner
python3 scripts/verify.py
```

For Apple sample changes, also run `bash scripts/check-apple.sh` and manually exercise the relevant sample in Xcode. If your machine cannot run an Apple check, say so explicitly in the pull request.

## Lesson standards

- Explain the problem, the language mechanism, and a practical tradeoff.
- Include complete source, expected output or interaction, a common mistake, and an exercise.
- Keep portable examples deterministic and offline.
- Compile with Swift 6 language mode; do not hide warnings or disable concurrency checking.
- Use meaningful English names and avoid force unwrapping as a convenience.
- Register portable examples in `scripts/examples.json` and add an adjacent `.expected` file.
- Keep source snippets in lesson Markdown synchronized with the complete source.
- Cite primary documentation when linking to language or framework behavior.
- Identify minimum SDK versions and distinguish type checking from interaction testing.

## Scope and review

Prefer one concept or correction per pull request. Add behavior tests for model or algorithm changes. Documentation-only corrections do not need artificial unit tests. New dependencies require a clear educational benefit and maintenance plan.

By contributing, you agree that your contribution is provided under this repository’s MIT license. See the [code of conduct](CODE_OF_CONDUCT.md).
