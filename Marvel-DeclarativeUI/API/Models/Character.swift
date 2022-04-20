//
//  Character.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Foundation

// MARK: - Character
public struct Character: Codable {
    public var id: Int?
    public var name, characterDescription, modified: String?
    public var resourceURI: String?
    public var urls: [URLElement]?
    public var thumbnail: Thumbnail?
    public var events, series, comics, stories: MediaShort?

    public var urlImage: String? {
        guard let thumb = thumbnail?.path else {return nil}
        guard let extensionPath = thumbnail?.thumbnailExtension else {return nil}
        return thumb + "." + extensionPath
    }

    enum CodingKeys: String, CodingKey {
        case id, name
        case characterDescription = "description"
        case modified, resourceURI, urls, thumbnail, comics, stories, events, series
    }

    public init() {  }
}

// MARK: - MediaShort
public struct MediaShort: Codable {
    public var available, returned: Int?
    public var collectionURI: String?
    public var items: [MediaItem]?
}

// MARK: - MediaItem
public struct MediaItem: Codable {
    public var resourceURI, name: String?, type: String?
}

// MARK: - Thumbnail
public struct Thumbnail: Codable {
    public var path, thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
public struct URLElement: Codable {
    public var type, url: String?
}
