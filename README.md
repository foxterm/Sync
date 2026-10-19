# Sync

FoxTerm APP 专用 Swift 并发同步原语库，基于 libetos C 层实现，提供原子操作、互斥锁、等待组及内存回收能力。

## 模块

| 文件 | 功能 |
|------|------|
| `Atomic.swift` | 线程安全的 64 位原子整数（add / sub / load / store） |
| `Mutex.swift` | 互斥锁，支持 `withLock` 闭包自动加锁解锁 |
| `WaitGroup.swift` | 等待组（类似 Go `sync.WaitGroup`），等待多个并发任务完成 |
| `MemoryManager.swift` | 物理内存回收器，强制释放 C/C++ 动态分配的滞留内存 |

## 环境要求

| 平台 | 最低版本 |
|------|---------|
| iOS  | 17.0    |
| macOS | 14.0   |
| Swift | 5.10   |

## 安装

```ruby
pod 'Sync', :git => 'https://github.com/foxterm/Sync.git'
```

### 依赖

- [libetos](https://github.com/foxterm/libetos) — 底层 C 同步原语
- [Extension](https://github.com/foxterm/Extension) — Foundation 扩展

## 使用

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

// 自动加锁解锁
let result = mutex.withLock {
    // 临界区
    return someValue
}

// 无返回值
mutex.withVoid {
    // 临界区
}

// 手动控制
mutex.lock()
defer { mutex.unlock() }
```

### WaitGroup

```swift
let wg = WaitGroup()

wg.add(3)
Task {
    defer { wg.done() }
    // 任务 1
}
Task {
    defer { wg.done() }
    // 任务 2
}
Task {
    defer { wg.done() }
    // 任务 3
}
wg.wait() // 阻塞等待全部完成

// 便捷闭包方式（自动 add/done）
wg.with {
    // 任务
}
```

### MemoryManager

```swift
MemoryManager.shared.purge()
```

## 许可证

MIT
