//
//  JSONDecoderExtension.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Foundation

public extension JSONDecoder {

    private static let nestedModelKeyPathCodingUserInfoKey = CodingUserInfoKey(rawValue: "keypath")!

    private struct Key: CodingKey {
        let stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }

        let intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    private struct ModelResponse<TargetModel: Decodable>: Decodable {
        let model: TargetModel

        init(from decoder: Decoder) throws {
            var keyPaths = (decoder.userInfo[JSONDecoder.nestedModelKeyPathCodingUserInfoKey] as? String)?.split(separator: ".") ?? []

            let popLast = keyPaths.popLast() ?? ""
            let lastKey = String(popLast)

            var targetContainer = try decoder.container(keyedBy: Key.self)
            for keyPath in keyPaths {
                let key = Key(stringValue: String(keyPath))!
                targetContainer = try targetContainer.nestedContainer(keyedBy: Key.self, forKey: key)
            }
            model = try targetContainer.decode(TargetModel.self, forKey: Key(stringValue: lastKey)!)
        }
    }

    func decode<T: Decodable>(_ type: T.Type, from data: Data, keyPath: String?) throws -> T {
        if let keyPath = keyPath {
            self.userInfo[JSONDecoder.nestedModelKeyPathCodingUserInfoKey] = keyPath
            return try self.decode(ModelResponse<T>.self, from: data).model
        } else {
            return try self.decode(type, from: data)
        }
    }
}
