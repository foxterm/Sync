# Sync

[English](README.md) | [中文文档](README_CN.md)

A dedicated Swift concurrency synchronization primitives library for the FoxTerm APP, built on top of the libetos C layer, providing atomic operations, mutex locks, wait groups, and memory reclamation capabilities.

> This library is a dedicated core component for the [FoxTerm](https://foxterm.app/) APP. Feel free to download it: [https://foxterm.app/](https://foxterm.app/)

## Modules

| File | Description |
|------|-------------|
| `Atomic.swift` | Thread-safe 64-bit atomic integer (add / sub / load / store) |
| `Mutex.swift` | Mutex lock with `withLock` closure for automatic lock/unlock |
| `WaitGroup.swift` | Wait group (similar to Go `sync.WaitGroup`), waits for multiple concurrent tasks to complete |
| `MemoryManager.swift` | Physical memory reclaimer, forcibly releases stale memory dynamically allocated by C/C++ |

## Requirements

| Platform | Minimum Version |
|----------|----------------|
| iOS      | 17.0           |
| macOS    | 14.0           |
| Swift    | 5.10           |

## Installation

### Swift Package Manager

```swift
.package(url: "https://github.com/foxterm/Sync.git", branch: "main"),
```

```swift
.product(name: "Sync", package: "Sync"),
```

### CocoaPods

```ruby
pod 'Sync', :git => 'https://github.com/foxterm/Sync.git'
```

### Dependencies

- [libetos](https://github.com/foxterm/libetos) — Low-level C synchronization primitives
- [Extension](https://github.com/foxterm/Extension) — Foundation extensions

## Usage

### Atomic

```swift
let counter = Atomic(initialValue: 0)

counter.add(10)
counter.sub(3)
let value = counter.load    // 7
counter.store(100)
```

### Mutex

```swift
let mutex = Mutex()

// Automatic lock/unlock
let result = mutex.withLock {
    // Critical section
    return someValue
}

// No return value
mutex.withVoid {
    // Critical section
}

// Manual control
mutex.lock()
defer { mutex.unlock() }
```

### WaitGroup

```swift
let wg = WaitGroup()

wg.add(3)
Task {
    defer { wg.done() }
    // Task 1
}
Task {
    defer { wg.done() }
    // Task 2
}
Task {
    defer { wg.done() }
    // Task 3
}
wg.wait() // Blocks until all tasks complete

// Convenience closure (automatic add/done)
wg.with {
    // Task
}
```

### MemoryManager

```swift
MemoryManager.shared.purge()
```

## License

MIT
