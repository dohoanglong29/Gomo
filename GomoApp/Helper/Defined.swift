//
//  Defined.swift
//  GomoApp
//
//  Created by Vương Toàn Bắc on 11/23/20.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


class Defined {
    static let defaults = UserDefaults.standard
    static let storage = Storage.storage().reference()
    static let ref = Database.database().reference()
    static let formatter = NumberFormatter()
}
