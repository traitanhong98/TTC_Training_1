//
//  MyQueue.swift
//  Example
//
//  Created by admin on 1/5/21.
//

import Foundation

class Queue<T> {
    private var elements: [T] = []
    
    let queue = DispatchQueue(label: "customQueue")
    func pushDispatch(_ element: T) {
        queue.async {
            self.elements.append(element)
        }
    }
    
    func popDispatch() -> T? {
        var element: T?
        queue.sync {
            guard !elements.isEmpty else {
                return
            }
            element = self.elements.removeFirst()
        }
        return element
    }
    
    let semaphore = DispatchSemaphore(value: 1)
    func pushSemaphore(_ element: T) {
        semaphore.wait()
        self.elements.append(element)
        semaphore.signal()
    }
    
    func popSemaphore() -> T? {
        var element: T?
        semaphore.wait()
        if !elements.isEmpty {
            element = self.elements.removeFirst()
        }
        semaphore.signal()
        return element
    }
    
    let lock = NSLock()
    func pushLock(_ element: T) {
        lock.lock()
        self.elements.append(element)
        lock.unlock()
    }
    
    func popLock() -> T? {
        var element: T?
        lock.lock()
        if !elements.isEmpty {
            element = self.elements.removeFirst()
        }
        lock.unlock()
        return element
    }
}
