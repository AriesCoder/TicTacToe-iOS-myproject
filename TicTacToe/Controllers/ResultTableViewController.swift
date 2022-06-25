//
//  ResultTableViewController.swift
//  TicTacToe
//
//  Created by Aries Lam on 6/15/22.
//

import UIKit
import RealmSwift

class ResultTableViewController: UITableViewController {
    let realm = try! Realm()
    var players : Results<Player>?
    var playerWin: String?
    var score: Int?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50.0
        tableView.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        if let player = players?[indexPath.row]{
            cell.textLabel?.text = player.name
            cell.detailTextLabel?.text = "\(player.score )"
            cell.textLabel?.font = UIFont(name:"Marker Felt Thin", size: 20)
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.font = UIFont(name:"Marker Felt Thin", size: 20)
            cell.detailTextLabel?.textColor = UIColor.white
            cell.backgroundColor = .black
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            deleteRow(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    
    func deleteRow(at indexPath: IndexPath) {
        if let rowToDel = players?[indexPath.row]{
            do{
                try realm.write{
                    realm.delete(rowToDel)
                }
            }catch{
                print(" Error to delele Category \(error)")
            }
        }
    }



}
