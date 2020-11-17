//
//  ViewController.swift
//  Project 7
//
//  Created by Lawrence Dizon on 11/7/20.
//

import UIKit

//
// MARK:- View Controller
//
class ViewController: UITableViewController {
    //
    //MARK:- View Controller Properties
    //
    var petitions = [Petition]()
    
    var filteredPetitions = [Petition]()
    
    //
    // MARK:- ViewController States
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "White House Petitions"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.magnifyingglass"), style: .plain, target: self, action: #selector(promptForSearch))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(showCredits))
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=1000&limit=100"
        }
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
            
        }
        showError()
    }
   
    
    //
    // MARK:- JSON Parser
    //
    
    func parse(json: Data){
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            filteredPetitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    //
    // MARK:- Parsor Error Message
    //
    func showError(){
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    //
    // MARK:- TableView Properties
    //
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //
    //MARK:- Alert Controllers
    //
    @objc func showCredits(){
        let ac = UIAlertController(title: "Credits", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .cancel))
        
        present(ac, animated: true)
    }
    
    @objc func promptForSearch(){
        let ac = UIAlertController(title: "Type petition", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submitCheck(answer)
        }
        ac.addAction(submitAction)
        present(ac,animated: true)
    }
    
    func submitCheck(_ answer: String){
        if(answer.isEmpty){
            return
        }
        filteredPetitions.removeAll()
        let lowerAnswer = answer.lowercased()
        for petition in petitions {
            if petition.body.lowercased().contains(lowerAnswer) || petition.title.lowercased().contains(lowerAnswer){
                filteredPetitions.append(petition)
            }
        }
        tableView.reloadData()
        
        
    }
}

