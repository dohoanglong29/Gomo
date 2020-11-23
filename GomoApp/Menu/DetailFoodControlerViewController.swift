//
//  DetailFoodControlerViewController.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 10/23/20.
//

import UIKit
import Firebase
import SDWebImage

class DetailFoodControlerViewController: UIViewController {
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var lblFood: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblSoLuong: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnCong: UIButton!
    @IBOutlet weak var btnTru: UIButton!
    
    
    
    var ImgFood = ""
    var NameFood = ""
    var PriceFood:Int = 1
    var NoteFood = ""
    var NumberCount = 1
    var idTable = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        customsButton()
        
    }
    
    func customsButton(){
        subView.layer.cornerRadius = 5
        btnTru.layer.cornerRadius = 17
        btnCong.layer.cornerRadius = 17
        btnTru.layer.borderWidth = 0.7
        btnCong.layer.borderWidth = 0.7
    }
    
    func setUp(){
        imageFood.sd_setImage(with: URL(string: ImgFood ), completed: nil)
        lblFood.text = NameFood
        lblNote.text = NoteFood
        lblPrice.text = String(PriceFood) + "đ"
        lblCount.text = String(NumberCount)
        lblTotal.text = String(PriceFood) + "đ"
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnIncrease(_ sender: Any) {
        NumberCount += 1
        lblCount.text = String(NumberCount)
        lblTotal.text = String(NumberCount * PriceFood)
        lblSoLuong.text = "Số Lượng:\(NumberCount)"
        
    }
    
    @IBAction func btnReduction(_ sender: Any) {
        NumberCount -= 1
        lblCount.text = String(NumberCount)
        lblTotal.text = String(NumberCount * PriceFood)
        lblSoLuong.text = "Số Lượng:\(NumberCount)"
    }
    
    
    @IBAction func btnAddCart(_ sender: Any) {
        let writeData: [String: Any] = [
            "namefood": NameFood,
            "countfood": NumberCount,
            "pricefood": NumberCount * PriceFood,
            "imagefood": ImgFood]
        Defined.ref.child("Table/\(Int(idTable) ?? 0)/ListFood").childByAutoId().setValue(writeData)
        self.dismiss(animated: true, completion: nil)
        
        
    }
}
