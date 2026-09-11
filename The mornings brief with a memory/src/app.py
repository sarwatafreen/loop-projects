"""Tiny sample app used to demonstrate the Morning Brief loop."""


def greet(name):
    # TODO: validate that name is not empty before greeting
    return f"Hello, {name}!"


def main():
    print(greet("world"))
    # TODO: read the name from command-line arguments instead of hard-coding it
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
