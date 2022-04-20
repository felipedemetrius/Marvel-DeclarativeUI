//
//  Media.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Foundation

// MARK: - Media
public struct Media: Codable {
    public var id: Int?
    public var title: String?
    public var description: String?
    public var resourceURI: String?
    public var thumbnail: Thumbnail?
    public var creators: MediaShort?
    public var characters: MediaShort?
    public var urls: [URLElement] = []

    public var urlImage: String? {
        guard let thumb = thumbnail?.path else {return nil}
        guard let extensionPath = thumbnail?.thumbnailExtension else {return nil}
        return thumb + "." + extensionPath
    }

    public init() { }
}
