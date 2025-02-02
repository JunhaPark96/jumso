import Foundation

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

struct MemberResponse: Codable {
    let email: String
    let nickname: String
}

struct EnrollRequest: Codable {
    let bornAt: String  // "YYYY-MM-DD" 형식
    let sex: Sex
    let height: Int
    let bodyType: BodyType
    let job: String
    let relationshipStatus: RelationshipStatus
    let religion: Religion
    let smoke: Smoke
    let drink: Drink
    let latitude: Double
    let longitude: Double
    let introduction: String
    let whatSexDoYouWant: Sex
    let howOldDoYouWantMin: Int
    let howOldDoYouWantMax: Int
    let howFarCanYouGo: Int
    let whatKindOfBodyTypeDoYouWant: BodyType
    let whatKindOfRelationshipStatusDoYouWant: RelationshipStatus
    let whatKindOfReligionDoYouWant: Religion
    let whatKindOfSmokeDoYouWant: Smoke
    let whatKindOfDrinkDoYouWant: Drink
    let propertyIds: [Int]
    let notTheseCompanyIds: [Int]
}
