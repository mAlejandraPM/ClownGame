//
//  OngoingGames.swift
//  FinalProject
//
//  Created by Alejandra Pardo on 5/2/18.
//  Copyright © 2018 Alejandra Pardo. All rights reserved.
//

import Foundation
import UIKit


class GameCollectionController: UITableViewController {
    var activeGames: [Game] = [Game]()
    var pushedGame:Game = Game()
    var mainController: MainMenuController?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        tableView.sectionIndexBackgroundColor = UIColor.black
        tableView.sectionIndexColor = UIColor.red
        tableView.sectionIndexTrackingBackgroundColor = UIColor.black
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor.red
    }
    
    
    /* the number of completed and ongoing games
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeGames.count
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ongoing Games"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil)
        cell.backgroundColor = UIColor.black
        cell.textLabel?.text = " Game #\(indexPath.row + 1) with score \(activeGames[indexPath.row].score)"
        cell.textLabel?.textColor = UIColor.yellow
        return cell
    }
    
    
    /* Tells main controller to push selected game */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pushedGame = activeGames.remove(at: indexPath.row)
        UIApplication.shared.sendAction(#selector(MainMenuController.pushGameController), to: presentingViewController as! MainMenuController , from: self, for: nil)
    }
    
    

    
    func saveData(){
        /*print("saving data")
        let docPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let activeGameFilePath: String = docPath + "/activeGames.txt"
        NSKeyedArchiver.archiveRootObject(activeGames, toFile: activeGameFilePath)
        
        let completedGameFilePath: String = docPath + "/completedGames.txt"
        NSKeyedArchiver.archiveRootObject(completedGames, toFile: completedGameFilePath)*/
    }
    
    func loadData(){
        /*print("loading data")
        let docPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let activeGameFilePath: String = docPath + "/activeGames.txt"
        let completedGameFilePath: String = docPath + "/completedGames.txt"
        let fm: FileManager = FileManager()
        if(fm.fileExists(atPath: activeGameFilePath)){
            activeGames =  NSKeyedUnarchiver.unarchiveObject(withFile: activeGameFilePath) as! [GameController]
            for g in activeGames {
                g.endButton.addTarget(self, action: #selector(GameCollectionTableViewController.moveToCompleted), for: UIControlEvents.touchDown)
            }
        }
        else {
            activeGames = []
        }
        
        
        if(fm.fileExists(atPath: completedGameFilePath)){
            completedGames =  NSKeyedUnarchiver.unarchiveObject(withFile: completedGameFilePath) as! [GameController]
        }
        else {
            completedGames = []
        }*/
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* Updates the cell information when returning from a game */
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

