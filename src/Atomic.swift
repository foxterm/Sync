// FoxTerm | Atomic.swift
// Copyright (c) 2025-2026 foxterm.app
// Created by foxterm@foxmail.com

import Extension
import Foundation
import libetos

/// 原子操作类，提供线程安全的 64 位整数运算
/// 适用于无需复杂锁机制的高频计数场景，如流量监控或任务计数
public final class Atomic {
    /// 指向 C 语言托管内存的指针
    private let _ptr: UnsafeMutablePointer<etos_sync_atomic_int64_t>

    public init(initialValue: Int64 = 0) {
        _ptr = etos_sync_atomic_create(initialValue)!
    }

    deinit {
        etos_sync_atomic_free(_ptr)
        #if DEBUG
            print("♻️", "Atomic 资源已释放")
        #endif
    }
}

public extension Atomic {
    @inline(__always)
    func add(_ delta: some FixedWidthInteger) {
        etos_sync_atomic_add(_ptr, delta.int64)
    }

    @inline(__always)
    func sub(_ delta: some FixedWidthInteger) {
        etos_sync_atomic_sub(_ptr, delta.int64)
    }

    /// 以原子方式读取当前数值
    @inline(__always)
    var load: Int64 {
        etos_sync_atomic_load(_ptr)
    }

    /// 以原子方式写入新值
    @inline(__always)
    func store(_ value: Int64) {
        etos_sync_atomic_store(_ptr, value)
    }
}
