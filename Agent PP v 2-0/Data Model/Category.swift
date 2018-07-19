//
//  Category.swift
//  Agent PP v 2-0
//
//  Created by Сергей Михайлов on 18.07.2018.
//  Copyright © 2018 Сергей Михайлов. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
