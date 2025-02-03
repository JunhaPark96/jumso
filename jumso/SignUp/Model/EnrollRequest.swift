import Foundation

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

struct MemberResponse: Codable {
    let email: String
    let nickname: String
}
