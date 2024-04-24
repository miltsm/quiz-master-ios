//
//  HttpDataDownloader.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import Foundation

let validStatus = 200...299

protocol HttpDataDownloader {
    func httpData(from: URL) async throws -> Data
}

extension URLSession: HttpDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse), validStatus.contains(response.statusCode) else {
            throw QuizError.networkError
        }
        return data
    }
}
