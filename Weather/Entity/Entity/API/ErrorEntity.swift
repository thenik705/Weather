//
//  ErrorEntity.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import Foundation

class ErrorEntity: NSObject, Codable {

    private var code: Int?
    let message: String?

    private enum CodingKeys: String, CodingKey {
        case code
        case message = "error"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

    func setCode(_ code: Int) {
        self.code = code
    }
    
    func getErrorTitle() -> String {
        return message ?? "Error occurred, try again"
    }
}
