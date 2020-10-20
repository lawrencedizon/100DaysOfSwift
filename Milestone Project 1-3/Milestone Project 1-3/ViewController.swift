//
//  ViewController.swift
//  Milestone Project 1-3
//
//  Created by Lawrence Dizon on 10/19/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var flagNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFlags()
    }
    
    func getFlags(){
        let fm = FileManager.default
                let path = Bundle.main.resourcePath!
                let items = try! fm.contentsOfDirectory(atPath: path)
        
        //Find out this bug
                
//        for item in items {
//
//            if item.hasSuffix("png"){
//                print(item)
//            }
//
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flag", for: indexPath)
        
        cell.textLabel?.text = flagNames[indexPath.row]
        return cell
    }


}

