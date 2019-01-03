//
//  ViewController.swift
//  MuseumAPI
//
//  Created by Stephanie Ramirez on 12/28/18.
//  Copyright © 2018 Stephanie Ramirez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var objectIDs = [Int]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        //searchEvents(keyword: "1")
        searchBar.autocapitalizationType = .none
        fetchIds()
    }
    
    private func fetchIds() {
        MuseumAPIClient.getObjectIds { (appError, objectIds) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let objectIds = objectIds {
                self.objectIDs = objectIds
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? DetailViewController else { fatalError("indexPath, detailViewController nil")}
        let objectId = objectIDs[indexPath.row]
        detailViewController.objectId = objectId
    }
//    func loadData() {
//        let myUrl = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/objects")!
//        if let data = try? Data.init(contentsOf: myUrl) {
//            do {
//                let objectID = try JSONDecoder().decode(ObjectIDs.self, from: data)
//
//            } catch {
//                print(error)
//            }
//        }
//
//
//    }
//    private func searchEvents(keyword: String) {
//        MuseumAPIClient.searchEvents(keyword: keyword) { (error, objects) in
//            if let error = error {
//                print("hello \(error.errorMessage())")
//            } else if let objects = objects {
//                self.objects = objects
//            }
//        }
//    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCell", for: indexPath)
        let object = objectIDs[indexPath.row]
        cell.textLabel?.text = String(object)
        

        return cell
    }
}

extension ViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder() // dismiss the keyboard
//        guard let searchText = searchBar.text,
//            !searchText.isEmpty,
//            let searchTextEncoded = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
//                return
//        }
//        searchEvents(keyword: searchTextEncoded)
//    }
}

