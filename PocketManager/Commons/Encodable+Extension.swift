//
//  Encodable+Extension.swift
//  PocketManager
//
//  Created by Bartek Fira on 15/07/2022.
//

import Foundation

extension Encodable {
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func dictionary() throws -> [String: Any] {
        guard let dict = try JSONSerialization.jsonObject(with: jsonData(), options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dict
    }
}
