//
//  Signal.swift
//  Rex
//
//  Created by Neil Pankey on 5/9/15.
//  Copyright (c) 2015 Neil Pankey. All rights reserved.
//

import ReactiveCocoa

public func filterMap<T, U, E>(transform: T -> U?)(signal: Signal<T, E>) -> Signal<U, E> {
    return Signal { observer in
        signal.observe(next: { value in
            if let val = transform(value) {
                sendNext(observer, val)
            }
        }, error: { error in
            sendError(observer, error)
        }, completed: {
            sendCompleted(observer)
        }, interrupted: {
            sendInterrupted(observer)
        })
    }
}