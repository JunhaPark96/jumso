import Foundation
import SwiftUI

enum SignUpStep: Int, CaseIterable {
    case name, birthDay, gender, profile, location, introduction, preference, complete
}

enum Sex: String, Codable {
    case MALE, FEMALE
}

enum BodyType: String, Codable {
    case NONE, SKINNY, SLIM, NORMAL, FAT, MUSCLE
}

enum RelationshipStatus: String, Codable {
    case SINGLE, DOLSING
}

enum Religion: String, Codable {
    case NONE, CHRISTIAN, CATHOLIC, ORTHODOX, JUDAISM, BUDDHISM, ISLAM, HINDUISM, OTHER
}

enum Smoke: String, Codable {
    case NONE, NO, SOMETIMES, OFTEN
}

enum Drink: String, Codable {
    case NONE, NO, SOMETIMES, OFTEN
}
