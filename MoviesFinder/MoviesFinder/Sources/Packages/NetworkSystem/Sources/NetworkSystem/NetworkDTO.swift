//
//  NetworkDTO.swift
//  NetworkSystem
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation

public struct NetworkDTO {
    let timeout: TimeInterval
    let retry: Int
    let showLog: Bool
    let cache: Bool

    public init(
        timeout: TimeInterval = 60,
        retry: Int = 0,
        showLog: Bool = false,
        cache: Bool = false
    ) {
        self.timeout = timeout
        self.retry = retry
        self.showLog = showLog
        self.cache = cache
    }
}
