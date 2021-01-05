

import UIKit
import Firebase
import BetterSegmentedControl

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedCustoms: BetterSegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnCart: UIButton!
    var menus = [Menu]()
    var strFood = [Menu]()
    let searchController = UISearchController(searchResultsController: nil)
    var statusTable1 = ""
    var idTable = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
    }
    fileprivate func initComponent() {
        getFoodsData()
        btnCart.addShadow(radius: 5)
        btnCart.addBoder(radius: 7,color: #colorLiteral(red: 0.2274329066, green: 0.5870787501, blue: 0.9447389245, alpha: 0.8470588235))
        FoodCell.registerCellByNib(collectionView)
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        segmentedCustoms.segments = LabelSegment.segments(withTitles: ["Đồ ăn", "Đồ uống ", "Đồ khác"],normalTextColor: #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1),selectedTextColor: #colorLiteral(red: 0.9254901961, green: 0.9568627451, blue: 0.9921568627, alpha: 1))
    }

    @IBAction func segmentedSelectMenu(_ sender: BetterSegmentedControl) {
        switch sender.index {
        case 0:
            getFoodsData()
        case 1:
            getDrinksData()
        default:
            getOthersData()
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
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Menu/Food").observe(DataEventType.value) { (DataSnapshot) in
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
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Menu/Drink").observe(DataEventType.value) { (DataSnapshot) in
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
    
    func getOthersData(){
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Menu/Other").observe(DataEventType.value) { (DataSnapshot) in
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
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return strFood.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = FoodCell.loadCell(collectionView, path: indexPath) as! FoodCell
        cell.setUpData(data: strFood[indexPath.row])
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
