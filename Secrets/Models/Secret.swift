import Foundation

struct Secret: Codable, Hashable, Identifiable {
    let id: UUID
    let title: String
    let body: String

    init(
        id: UUID = UUID(),
        title: String,
        body: String
    ) {
        self.id = id
        self.title = title
        self.body = body
    }
}
