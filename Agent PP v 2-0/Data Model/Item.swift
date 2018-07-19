//
//  Item.swift
//  Agent PP v 2-0
//
//  Created by Сергей Михайлов on 18.07.2018.
//  Copyright © 2018 Сергей Михайлов. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
