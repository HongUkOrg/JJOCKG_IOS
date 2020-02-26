//
//  Logger.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/22.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum LogLevel: String, CaseIterable {
    case error = "❤️ ERROR"
    case warning = "💛 WARNING"
    case debug = "💚 DEBUG"
    case info = "💙 INFO"
    case verbose = "💜 VERBOSE"
    case unknown = "☠️ UNKNOWN"
}

protocol LoggerProtocol {
    static var logLevels: [LogLevel] { get }

    static func setLevel(_ target: LogLevel)
    static func setLevels(_ targets: [LogLevel])

    static func error(_ msg: String, file: StaticString, line: UInt)
    static func warning(_ msg: String, file: StaticString, line: UInt)
    static func debug(_ msg: String, file: StaticString, line: UInt)
    static func info(_ msg: String, file: StaticString, line: UInt)
    static func verbose(_ msg: String, file: StaticString, line: UInt)
    static func unknown(_ msg: String, file: StaticString, line: UInt)
}

final class Logger: LoggerProtocol {
    static private(set) var logLevels = LogLevel.allCases

    static func setLevel(_ target: LogLevel) {
        var levels: [LogLevel] = []
        for level in LogLevel.allCases {
            levels.append(level)
            if level == target {
                break
            }
        }
        Logger.logLevels = levels
    }

    static func setLevels(_ targets: [LogLevel]) {
        Logger.logLevels = targets
    }

    static func error(_ msg: String, file: StaticString = #file, line: UInt = #line) {
        Logger.log(msg, level: .error, file: file, line: line)
    }

    static func warning(_ msg: String, file: StaticString = #file, line: UInt = #line) {
        Logger.log(msg, level: .warning, file: file, line: line)
    }

    static func debug(_ msg: String, file: StaticString = #file, line: UInt = #line) {
        Logger.log(msg, level: .debug, file: file, line: line)
    }

    static func info(_ msg: String, file: StaticString = #file, line: UInt = #line) {
        Logger.log(msg, level: .info, file: file, line: line)
    }
    
    static func verbose(_ msg: String, file: StaticString = #file, line: UInt = #line) {
        Logger.log(msg, level: .verbose, file: file, line: line)
    }

    static func unknown(_ msg: String, file: StaticString = #file, line: UInt = #line) {
        Logger.log(msg, level: .unknown, file: file, line: line)
    }
    
    static private func log(_ msg: String, level: LogLevel = .verbose, file: StaticString, line: UInt) {
        if Logger.logLevels.contains(level) {
            #if DEBUG || QA
            print("\(level.rawValue) :: \(msg) #\(file):L\(line)")
            #else
            NSLog("\(level.rawValue) :: \(msg) #\(file):L\(line)")
            #endif
        }
    }
}
