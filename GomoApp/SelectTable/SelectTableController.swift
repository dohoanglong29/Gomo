

import UIKit
import Firebase



class SelectTableController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var tables = [Table]()
    var status = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableCCell.registerCellByNib(collectionView)
        getNumberTable()
        collectionView.reloadData()
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
                let tb = tables[indexPath.row]
                if tables[indexPath.row].statu == 3{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: Constans.megerTable) as! ActionTableViewController
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.idTable = String(tb.NumberTable ?? 1)
                    self.present(vc, animated: true, completion: nil)
                }else{
                    
                }
            }
        }
    }
    
    func getNumberTable(){
        Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table").observe(DataEventType.value) { (DataSnapshot) in
            self.tables.removeAll()
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshort {
                    _ = snap.key
                    if let value = snap.value as? [String: Any] {
                        let nameCreactor = value["nameCreactor"] as? String
                        let statu = value["statu"] as! Int
                        let numberTable = value["NumberTable"] as! Int
                        let table = Table(statu: statu, NumberTable: numberTable, nameCreactor: nameCreactor)
                        self.tables.append(table)
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }
}

extension SelectTableController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tables.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TableCCell.loadCell(collectionView, path: indexPath) as! TableCCell
        cell.setUp(data: tables[indexPath.row])
        switch tables[indexPath.row].statu  {
        case 0:
            cell.subView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        case 1:
            cell.subView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        default:
            cell.subView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            return self.addMenuItems(for: indexPath.row)
        })
    }
 
    func addMenuItems(for index:Int) -> UIMenu {
        let tb = tables[index]
        switch tables[index].statu {
        case 0:
            let menuItems = UIMenu(title: "", options: .displayInline, children: [
                UIAction(title: Constans.menu_oder, image: UIImage(named: "ic_food"), handler: { (_) in
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.vc) as! ViewController
                    vc.idTable = String(tb.NumberTable ?? 0)
                    vc.statusTable1 = "1"
                    Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(tb.NumberTable ?? 0))").updateChildValues(["statu": 0])
                    self.navigationController?.pushViewController(vc, animated: true)
                }),
                
                UIAction(title: Constans.menu_cart, image: UIImage(named: "ic_cart"), handler: { (_) in
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.cart) as! CartViewController
                    vc.idTable = String(tb.NumberTable ?? 0)
                    vc.status = tb.statu ?? 0
                    self.navigationController?.pushViewController(vc, animated: true)
                }),
                
                UIAction(title: Constans.menu_status, image: UIImage(named: "ic_table"), handler: { (_) in
                    Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(tb.NumberTable ?? 0))").updateChildValues(["statu": 1])
                }),
            ])
            return menuItems
        case 1:
            let menuItems = UIMenu(title: "", options: .displayInline, children: [
                UIAction(title: Constans.menu_keeptable, image: UIImage(named: "ic_hold") , handler: { (_) in
                    Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(tb.NumberTable ?? 0))").updateChildValues(["statu": 0])
                }),
                
                UIAction(title: Constans.menu_oder, image: UIImage(named: "ic_food"), handler: { (_) in
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.vc) as! ViewController
                    vc.idTable = String(tb.NumberTable ?? 0)
                    vc.statusTable1 = "1"
                    Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(tb.NumberTable ?? 0))").updateChildValues(["statu": 0])
                    self.navigationController?.pushViewController(vc, animated: true)
                }),
                
            ])
            return menuItems
        default:
            let menuItems = UIMenu(title: "", options: .displayInline, children: [
                UIAction(title: Constans.menu_callfood, image: UIImage(named: "ic_food"), handler: { (_) in
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:Constans.vc) as! ViewController
                    vc.idTable = String(tb.NumberTable ?? 0)
                    vc.statusTable1 = "1"
                    vc.updateCart = "updateCart"
                    self.navigationController?.pushViewController(vc, animated: true)
                }),
                
                UIAction(title: Constans.menu_cart, image: UIImage(named: "ic_cart"), handler: { (_) in
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.cart) as! CartViewController
                    vc.idTable = String(tb.NumberTable ?? 0)
                    vc.status = tb.statu ?? 0
                    self.navigationController?.pushViewController(vc, animated: true)
                }),
                
                UIAction(title: Constans.menu_meger, image: UIImage(named: "ic_merge" ) , handler: { (_) in
                    if self.tables[index].statu == 3{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constans.megerTable) as! ActionTableViewController
                        vc.modalPresentationStyle = .fullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .overCurrentContext
                        vc.idTable = String(tb.NumberTable ?? 1)
                        self.present(vc, animated: true, completion: nil)
                    }
                })
            ])
            return menuItems
        }
    }
}
