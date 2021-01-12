
import Foundation
struct Bill: Codable {
    var id: String? = nil
    var numberTable: String? = nil
    var detailFood: String? = nil
    var detailPrice: String? = nil
    var Total:Int? = nil
    var date: String? = nil
    var discouunt:String? = nil
    var time:String? = nil
    var listpricefood:String? = nil
    var listnote:String? = nil
    var totalPay:Int? = nil
    var collector:String? = nil
}

struct BillDetail: Codable {
    var amount: Int?
    var detailFood: String?
    var date: String?
    var time: String?
    var numberTb: String?
    var discount: String?
    var listPriceFood: String?
    var totalPay: String?
}
