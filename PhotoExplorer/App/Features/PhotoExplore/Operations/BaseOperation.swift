//
//  MainOperation.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/7/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

class BaseOperation: Operation {
    override var isAsynchronous: Bool {
        return true
    }

    private var _isExecuting = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }

    override var isExecuting: Bool {
        return _isExecuting
    }

    private var _isFinished: Bool = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }

    override var isFinished: Bool {
        return _isFinished
    }

    override func start() {
        _isExecuting = true
        execute()
    }

    func execute() {
        fatalError("Override if planned to use this")
    }

    func finish() {
        _isExecuting = false
        _isFinished = true
    }
}

