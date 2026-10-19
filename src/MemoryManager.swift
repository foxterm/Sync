// FoxTerm | MemoryManager.swift
// Copyright (c) 2025-2026 foxterm.app
// Created by foxterm@foxmail.com

import Darwin
import Foundation
#if os(macOS)
    import AppKit
#elseif os(iOS)
    import UIKit
#endif
/// 专治 C/C++ 动态分配(如 Tree-sitter)物理内存不归还的垃圾回收器
public final class MemoryManager: @unchecked Sendable {
    public static let shared = MemoryManager()
    private let queue = DispatchQueue(label: "app.foxterm.memory.purge", qos: .utility)

    /// 手动强制触发物理内存回收
    /// - Parameter force: 是否忽略节流限制
    public func purge() {
        queue.async { [weak self] in
            guard self != nil else { return }
            _ = autoreleasepool {
                malloc_zone_pressure_relief(nil, 0)
            }

            #if DEBUG
                print("♻️", "🧹 [MemoryManager] 物理内存回收已完成")
            #endif
        }
    }
}
