//
//  TestDownloader.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import Foundation

class TestDownloader: HttpDataDownloader {
    func httpData(from: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testQuizzesData
    }
}
