
import Foundation
struct Cart: Codable {
    var id: String? = nil
    var count: Int? = nil
    var image: String? = nil
    var name: String? = nil
    var price: Int? = nil
    var note: String? = nil
}
struct CartDetails: Codable {
    var id: String?
    var count: Int?
    var image: String?
    var name: String?
    var price: Int?
    var note: String?
}


