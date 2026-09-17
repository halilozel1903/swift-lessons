#!/usr/bin/env python3
"""Compile examples in Swift 6 mode, compare output, and verify local Markdown links."""
import argparse
import json
from pathlib import Path
import re
import subprocess
import tempfile
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parents[1]


def check_links():
    checked = 0
    for document in sorted(ROOT.rglob("*.md")):
        if any(part in {".build", ".git", ".swiftpm"} for part in document.parts):
            continue
        for destination in re.findall(r"\]\(([^)]+)\)", document.read_text()):
            if destination.startswith(("https://", "http://", "mailto:", "#")):
                continue
            target = unquote(destination.split("#", 1)[0])
            if not (document.parent / target).exists():
                raise RuntimeError(f"Broken link in {document.relative_to(ROOT)}: {destination}")
            checked += 1
    for source in sorted(ROOT.glob("Examples/*/*.swift")):
        level = source.parent.name
        lesson = ROOT / f"Curriculum/Swift-{level}/{source.stem}.md"
        snippet = "```swift\n" + source.read_text().strip() + "\n```"
        if snippet not in lesson.read_text():
            raise RuntimeError(f"Lesson snippet differs from {source.relative_to(ROOT)}")
    for source in sorted(ROOT.glob("AppleExamples/*.swift")):
        lesson = ROOT / f"Curriculum/Swift-501/{source.stem}.md"
        snippet = "```swift\n" + source.read_text().strip() + "\n```"
        if snippet not in lesson.read_text():
            raise RuntimeError(f"Lesson snippet differs from {source.relative_to(ROOT)}")
    print(f"PASS: {checked} local file links (external URLs and anchors are not checked)", flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--example", help="Run one example, e.g. 101/01-values-types")
    parser.add_argument("--docs-only", action="store_true")
    args = parser.parse_args()
    check_links()
    if args.docs_only:
        return
    entries = json.loads((ROOT / "scripts/examples.json").read_text())
    if args.example:
        entries = [entry for entry in entries if entry["source"] == f"Examples/{args.example}.swift"]
        if not entries:
            parser.error("Unknown example. See scripts/examples.json for valid paths.")
    with tempfile.TemporaryDirectory(prefix="swift-lessons-") as directory:
        for index, entry in enumerate(entries):
            executable = Path(directory) / f"example-{index}"
            command = ["swiftc", "-swift-version", "6", "-warnings-as-errors"]
            if entry["library"]:
                command.append("-parse-as-library")
            command += [str(ROOT / entry["source"]), "-o", str(executable)]
            subprocess.run(command, check=True, timeout=180)
            result = subprocess.run([str(executable)], check=True, capture_output=True, text=True, timeout=20)
            expected = (ROOT / entry["expected"]).read_text()
            if result.stdout != expected:
                raise RuntimeError(f"{entry['source']}\nExpected: {expected!r}\nActual: {result.stdout!r}")
            print(f"PASS: {entry['source']}", flush=True)
    print(f"PASS: {len(entries)} portable examples", flush=True)


if __name__ == "__main__":
    main()
