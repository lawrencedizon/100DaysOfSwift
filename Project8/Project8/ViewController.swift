//
//  ViewController.swift
//  Project8
//
//  Created by Lawrence Dizon on 11/9/20.
//

import UIKit

//
//MARK:- ViewController
//
class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answerLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    override func loadView(){
        view = UIView()
        view.backgroundColor = .white
        
        //more code to come
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
        scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
    
        scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        
        ])
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Tets")
        
    }


}

