//
//  Person.swift
//  Project10
//
//  Created by Lawrence Dizon on 11/30/20.
//

import UIKit

class Person: NSObject, Codable  {
    var name: String
    var image: String
    
    init(name: String, image: String){
        self.name = name
        self.image = image
    }

}
