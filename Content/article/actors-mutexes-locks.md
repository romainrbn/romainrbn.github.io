---
author: Romain Rabouan
description: A performance comparison of Mutexes, NSLocks and Actors in Swift.
date: 2024-12-01 15:30
tags: Core Swift, Performance
published: true
image: /images/photos/mutexes.png
---
# Comparing Actors, Locks and Mutexes performance

Let's compare performance between the good old NSLock, the more recent actors and the brand new Mutex.

## An introduction to `Mutexes`

In the world of programming, especially when dealing with multithreading, the need for synchronization arises to ensure that shared resources are accessed safely. One common synchronization tool is the mutex, short for "mutual exclusion."

A mutex is a locking mechanism that ensures only one thread can access a critical section of code or a shared resource at a time. When a thread locks a mutex, other threads attempting to lock the same mutex must wait until it is unlocked. This prevents race conditions, where multiple threads might read and write to shared data simultaneously, leading to unpredictable results.

### Why Use Mutexes?
Imagine a scenario where two threads are trying to update the same variable:

```swift
var sharedCounter = 0

DispatchQueue.global().async {
    for _ in 0..<1000 {
        sharedCounter += 1
    }
}

DispatchQueue.global().async {
    for _ in 0..<1000 {
        sharedCounter += 1
    }
}
```

Without synchronization, both threads may try to update sharedCounter simultaneously, leading to incorrect results. A mutex can solve this problem by ensuring that only one thread updates the counter at a time.

### How Mutexes Work:
- Lock: A thread acquires the mutex lock before entering the critical section.
- Critical Section: The code that accesses the shared resource.
- Unlock: The thread releases the lock after completing its operation, allowing other threads to proceed.

Mutexes were implemented this year with iOS 18. Here is how you can use them in your code:

```swift
final class WithMutex: Sendable {
    private let _storage = Mutex<Int>(0)

    init() { }

    func enqueue(item: Int) {
        _storage.withLock { storage in
            storage += 1
        }
    }
}
```

### What's the difference with actors?

An actor is a concurrency-safe type in Swift that automatically serializes access to its properties and methods.
Instead of locking and unlocking, you interact with the actor's properties asynchronously, letting Swift handle the synchronization.


## A performance comparison:

### Compare these three small algorithms:

```swift
actor WithActor {
    private var storage: Int = 0

    func enqueue(item: Int) {
        storage += 1
    }
}
```

```swift
final class WithMutex: Sendable {
    private let _storage = Mutex<Int>(0)

    init() { }

    func enqueue(item: Int) {
        _storage.withLock { storage in
            storage += 1
        }
    }
}
```

```swift
struct WithLock: @unchecked Sendable {
    private var storage: Int = 0

    private let lock = NSLock()

    init() {}

    mutating func enqueue(item: Int) {
        lock.withLock {
            storage += 1
        }
    }
}
```

Let's compare running these three algorithms with this large operation:

We can now observe a large difference of time: Here the good old `NSLock` only takes 1.31 seconds to complete, nearly followed by the new `Mutex`.
The actor, on the contrary, takes a huge 13.1 seconds to run!

```swift
enum AlgorithmMethod: String, CaseIterable {
    case `actor` = "actor"
    case mutex = "Mutex"
    case nsLock = "NSLock"
}
```

```swift
struct MutexDisplayer {
    let lockAlgorithm = WithNSLock()
    let actorAlgorithm = WithActor()
    let mutexAlgorithm = WithMutex()

    let numberOfTasks: Int = 10
    let numberOfItems: Int = 1_000_000

    static func runAlgorithms() async {
        for method in AlgorithmMethod.allCases {
            let timeBegin = CFAbsoluteTimeGetCurrent()

            numberOfTasks.forEach { _ in
                numberOfItems.forEach { i in
                    switch method {
                    case .nsLock: lockAlgorithm.enqueue(item: i)
                    case .actor: await actorAlgorithm.enqueue(item: i)
                    case .mutex: mutexAlgorithm.enqueue(item: i)
                    }
                }
            }

            let elapsed = CFAbsoluteTimeGetCurrent() - timeBegin
            print("\(method.rawValue): elapsed time = \(elapsed) seconds")
        }
    }
}
