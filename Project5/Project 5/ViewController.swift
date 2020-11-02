//
//  ViewController.swift
//  Project 5
//
//  Created by Lawrence Dizon on 10/28/20.
//

import UIKit
//
//MARK: - View Controller
//
class ViewController: UITableViewController {
    //
    //MARK: - ViewController Variables and Properties
    //
    var allWords = [String]()
    var usedWords = [String]()
    
    
    //
    //MARK: - View Controller Event States
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        
        startGame()

    }
    
    //
    // MARK: - View Controller methods
    //
    @objc func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    //
    //MARK: - UITableView Config
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    //
    //MARK: - UIAlertController Config
    //
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
        
       
    }
    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        if isPossible(word: lowerAnswer){
            if isOriginal(word: lowerAnswer) && title?.lowercased() != lowerAnswer{
                if isReal(word: lowerAnswer) && isValidLengthCheck(word: lowerAnswer){
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }else {
                    if(answer.count) <= 3 {
                        showErrorMessage(errorTitle: "Word is too short", errorMessage: "Words must be 3 or more characters long")
                    }else{
                        showErrorMessage(errorTitle: "Word not recognized", errorMessage: "You can't just make them up, you know!")
                    }
                }
            }else {
                if title?.lowercased() == lowerAnswer{
                    showErrorMessage(errorTitle: "Start word is not allowed", errorMessage: "Please try a valid word")
                }else{
                    showErrorMessage(errorTitle: "Word already used", errorMessage: "Be more original")
                }
                
            }
        }else {
            guard let title = title else { return }
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title.lowercased())")
        }
        
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String){
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert   )
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    //
    //MARK: - Game word checking methods
    //
    
    func isValidLengthCheck(word: String) -> Bool{
        return word.count > 3
    }
    

    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    
}

 
