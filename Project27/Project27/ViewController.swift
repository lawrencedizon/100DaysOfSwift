 //
//  ViewController.swift
//  Project27
//
//  Created by Lawrence Dizon on 12/17/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        drawRectange()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        
        currentDrawType += 1
        
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectange()
        default:
            break
        }
    }
    
    func drawRectange(){
        
    }
    
}

