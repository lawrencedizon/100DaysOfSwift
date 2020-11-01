//
//  WebsiteTableTableViewController.swift
//  Project4
//
//  Created by Lawrence Dizon on 11/1/20.
//

import UIKit

class WebsiteTableTableViewController: UITableViewController {

    let websites = WebsiteData()
    
    override func viewDidLoad() {
        title = "Websites"
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()


    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return websites.websites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)
        cell.textLabel?.text = websites.websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let website = storyboard?.instantiateViewController(identifier: "WebViewController") as?
            WebViewController {
            website.selectedWebsite = websites.websites[indexPath.row]
            navigationController?.pushViewController(website, animated: true)
        }
    }

}
