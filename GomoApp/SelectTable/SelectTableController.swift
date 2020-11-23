//
//  SelectTableController.swift
//  Gomo
//
//  Created by Vương Toàn Bắc on 11/3/20.
//

import UIKit
import Firebase

class SelectTableController: UIViewController {
    
    var tables = [Table]()
    var status = 1
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableCCell.registerCellByNib(collectionView)
        getNumberTable()
        collectionView.reloadData()
        

        
        let dateThis = dateFormatTime(date: Date())
        print(dateThis)
    }
    
    func dateFormatTime(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getNumberTable(){
        Defined.ref.child("Table").observe(DataEventType.value) { (DataSnapshot) in
            self.tables.removeAll()
            if let snapshort = DataSnapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshort {
                    let id = snap.key
                    if let value = snap.value as? [String: Any] {
                        let statu = value["statu"] as! Int
                        let numberTable = value["NumberTable"] as! Int
                        let table = Table(statu: statu, NumberTable: numberTable)
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
        print(tables.count)
        return tables.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TableCCell.loadCell(collectionView, path: indexPath) as! TableCCell
        cell.setUp(data: tables[indexPath.row])
        switch tables[indexPath.row].statu  {
        case 0:
            cell.statusTable.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        case 1:
            cell.statusTable.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        default:
            cell.statusTable.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tb = tables[indexPath.row]

        switch tables[indexPath.row].statu {
        
        case 0:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constans.cart) as! CartViewController
            vc.idTable = String(tb.NumberTable ?? 0)
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            vc.idTable = String(tb.NumberTable ?? 0)
            Defined.ref.child("Table/\(Int(tb.NumberTable ?? 0))").updateChildValues(["statu": 0])
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailBillViewController") as! DetailBillViewController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.numberTb = String(tb.NumberTable ?? 0)
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}
