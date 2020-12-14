//
//  ViewController.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 10/21/20.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var search1Bar: UISearchBar!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnCart: UIButton!
    var menus = [Menu]()
    var strFood = [Menu]()
    let searchController = UISearchController(searchResultsController: nil)

    var statusTable1 = ""
    var idTable = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFoodsData()
        if statusTable1 == "1"{
            btnCart.isHidden = false
        }else{
            btnCart.isHidden = true
        }
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController

        FoodCell.registerCellByNib(collectionView)
        btnCart.layer.borderWidth = 0.1
        btnCart.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        btnCart.layer.cornerRadius = 35
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: collectionView)
                 if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
                    print(indexPath)
                 }
            }
    }
    
    @IBAction func btnSelectMenu(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            getFoodsData()
        }else{
            getDrinksData()
        }
    }
    
    @IBAction func btnCart(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.cart) as! CartViewController
        vc.btnAddFood.isEnabled = false
        vc.idTable = idTable
        vc.statustable = statusTable1
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    
    func getFoodsData(){
        Defined.ref.child("Account").child("115133369612982521880").child("Menu/Food").observe(DataEventType.value) { (DataSnapshot) in
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                self.menus.removeAll()
                for snap in snapshort {
                    let id = snap.key
                    if let value = snap.value as? [String: Any] {
                        let namefood = value["namefood"] as! String
                        let imagefood = value["imagefood"] as! String
                        let notefood = value["notefood"] as! String
                        let pricefood = value["price"] as! Int
                        let status = value["statusFood"] as? String
                        let menu = Menu(id: id, name: namefood, image: imagefood, note: notefood, price: pricefood, statusFood: status)
                        self.menus.append(menu)
                    }
                }
            }
            self.strFood = self.menus
            self.collectionView.reloadData()
        }
    }
    
    func getDrinksData(){
        Defined.ref.child("Account").child("115133369612982521880").child("Menu/Drink").observe(DataEventType.value) { (DataSnapshot) in
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                self.menus.removeAll()
                for snap in snapshort {
                    let id = snap.key
                    if let value = snap.value as? [String: Any] {
                        let namefood = value["namefood"] as! String
                        let imagefood = value["imagefood"] as! String
                        let notefood = value["notefood"] as! String
                        let pricefood = value["price"] as! Int
                        let status = value["statusFood"] as? String
                        let menu = Menu(id: id, name: namefood, image: imagefood, note: notefood, price: pricefood,statusFood: status)
                        self.menus.append(menu)
                    }
                }
            }
            self.strFood = self.menus
            self.collectionView.reloadData()
        }
    }
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return strFood.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = FoodCell.loadCell(collectionView, path: indexPath) as! FoodCell
        cell.setUpData(data: strFood[indexPath.row])
        if strFood[indexPath.row].statusFood == "0" {
            cell.bView.alpha = 0.5
        }else{
            cell.bView.alpha = 1
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.detailFood) as! DetailFoodControlerViewController
        let m = strFood[indexPath.row]
        if menus[indexPath.row].statusFood == "0" {
            
        }else{
            vc.ImgFood = m.image ?? ""
            vc.NameFood = m.name ?? ""
            vc.NoteFood = m.note ?? ""
            vc.PriceFood = m.price ?? 1
            vc.idTable = idTable
            self.present(vc, animated: true, completion: nil)
        }
        
       
    }
}
extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            strFood = menus
        } else {
            strFood = menus.filter {$0.name!.lowercased().contains(searchController.searchBar.text!.lowercased())}
        }
        collectionView.reloadData()
    }
}
