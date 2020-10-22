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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        image.layer.borderWidth = 0.5
    }
    
    @objc func shareTapped(){
        print("testing shareTapped")
    }

}
