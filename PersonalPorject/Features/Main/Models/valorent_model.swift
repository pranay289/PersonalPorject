import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(ValorentModel.self, from: jsonData)

struct ValorentModel: Codable {
    let status: Int?
    let data: [Datum]?

    init(status: Int = 0, data: [Datum] = []) {
        self.status = status
        self.data = data
    }

    enum CodingKeys: String, CodingKey {
        case data
        case status
    }
}

struct Datum: Identifiable, Codable {
    var id: UUID {
        // You can assign any unique value for 'id' here
        // For example, use the 'uuid' as the source for 'id'
        return UUID()
    }
    let uuid, displayName, description, developerName: String?
    let characterTags: [String]?
    let displayIcon, displayIconSmall, bustPortrait, fullPortrait: String?
    let fullPortraitV2, killfeedPortrait, background: String?
    let backgroundGradientColors: [String]?
    let assetPath: String?
    let isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest,
        isBaseContent: Bool?
    let role: Role?
    let abilities: [Ability]?

    enum CodingKeys: CodingKey {
        case uuid
        case displayName
        case description
        case developerName
        case characterTags
        case displayIcon
        case displayIconSmall
        case bustPortrait
        case fullPortrait
        case fullPortraitV2
        case killfeedPortrait
        case background
        case backgroundGradientColors
        case assetPath
        case isFullPortraitRightFacing
        case isPlayableCharacter
        case isAvailableForTest
        case isBaseContent
        case role
        case abilities
    }

}

struct Ability: Codable {
    let slot, displayName, description: String?
    let displayIcon: String?

    enum CodingKeys: CodingKey {
        case slot
        case displayName
        case description
        case displayIcon
    }
}

struct Role: Codable {
    let uuid, displayName, description: String?
    let displayIcon: String?
    let assetPath: String?

    enum CodingKeys: CodingKey {
        case uuid
        case displayName
        case description
        case displayIcon
        case assetPath
    }
}

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//            return true
//    }
//
//    public var hashValue: Int {
//            return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//            let container = try decoder.singleValueContainer()
//            if !container.decodeNil() {
//                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//            }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//            var container = encoder.singleValueContainer()
//            try container.encodeNil()
//    }
//}
//
