//
//  WordsModelElement.swift
//  SkyengUIKit
//
//  Created by Mac on 29.06.2023.
//

import Foundation

struct WordsModelElement: Codable {
    let id: Int?
    let text: String?
    let meanings: [Meaning]
}

struct Meaning: Codable {
    let id: Int?
    let partOfSpeechCode: String?
    let translation: Translation
    let previewURL, imageURL, transcription, soundURL: String?

    enum CodingKeys: String, CodingKey {
        case id, partOfSpeechCode, translation
        case previewURL = "previewUrl"
        case imageURL = "imageUrl"
        case transcription
        case soundURL = "soundUrl"
    }
}

struct Translation: Codable {
    let text, note: String?
}

typealias WordsModel = [WordsModelElement]
