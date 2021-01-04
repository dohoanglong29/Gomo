

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
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
                let tb = tables[indexPath.row]
                if tables[indexPath.row].statu == 3{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActionTableViewController") as! ActionTableViewController
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tb = tables[indexPath.row]
        switch tables[indexPath.row].statu {
        case 0:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            vc.idTable = String(tb.NumberTable ?? 0)
            vc.statusTable1 = "1"
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            vc.idTable = String(tb.NumberTable ?? 0)
            vc.statusTable1 = "1"
            Defined.ref.child(Constans.Ac).child(Constans.idAdmin).child("Table/\(Int(tb.NumberTable ?? 0))").updateChildValues(["statu": 0])
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.cart) as! CartViewController
            vc.idTable = String(tb.NumberTable ?? 0)
            vc.status = tb.statu ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func addMenuItems() -> UIMenu {
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
           
            UIAction(title: "Edit Timesheet", image: UIImage(systemName: "square.and.arrow.down.on.square.fill"), handler: { (_) in
                print("Edit Timesheet")
            }),
            UIAction(title: "View Details", image: UIImage(systemName:"magnifyingglass" ) , handler: { (_) in
                print("Details")
            })
            
        ])
        return menuItems
    }
}
