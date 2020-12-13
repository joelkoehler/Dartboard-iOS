//
//  ListItem.swift
//  AdventureZone
//
//  Created by Joel Koehler on 12/11/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import CoreData

class ListItem : NSManagedObject {
    @NSManaged var lat: Double
    @NSManaged var lon: Double
    @NSManaged var title: String
}
