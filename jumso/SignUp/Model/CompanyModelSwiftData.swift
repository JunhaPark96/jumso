import SwiftData

@Model
class Company {
    var id: Int
    var name: String
    var alias: String?
    var color: String
    var emails: [String]
    var enabled: Bool
    var scale: String?
    var order: String?
    var logo_url: String?

    // 기본 생성자
    init(id: Int, name: String, alias: String?, color: String, emails: [String], enabled: Bool, scale: String?, order: String?, logo_url: String?) {
        self.id = id
        self.name = name
        self.alias = alias
        self.color = color
        self.emails = emails
        self.enabled = enabled
        self.scale = scale
        self.order = order
        self.logo_url = logo_url
    }
}
