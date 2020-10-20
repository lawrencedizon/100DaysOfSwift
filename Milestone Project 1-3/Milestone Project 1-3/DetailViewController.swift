//
//  DetailViewController.swift
//  Milestone Project 1-3
//
//  Created by Lawrence Dizon on 10/20/20.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var image: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flagImage = selectedImage {
            image.image = UIImage(named: flagImage)
            
        }
        
        image.layer.borderWidth = 0.5
            
           
    }

}
