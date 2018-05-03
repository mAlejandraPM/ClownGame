//
//  MainMenu.swift
//  FinalProject
//
//  Created by Alejandra Pardo on 4/26/18.
//  Copyright © 2018 Alejandra Pardo. All rights reserved.
//

import Foundation
import UIKit

class MainMenuController: UIViewController {
    var newGameController: GameController
    var highScoreController: HighScoresController
    var ongoingGameController: GameCollectionController
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        newGameController = GameController(nibName: nil, bundle: nil, theGame: Game())
        highScoreController = HighScoresController()
        ongoingGameController = GameCollectionController(style: UITableViewStyle.plain)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        ongoingGameController.mainController = self
        highScoreController.hView.returnButton.addTarget(self, action: #selector(MainMenuController.returnToMain), for: UIControlEvents.touchUpInside)
        
        let gameName: UILabel = UILabel()
        let startButton: UIButton = UIButton()
        let resumeButton: UIButton = UIButton()
        let highScoresButton: UIButton = UIButton()
        
        view.addSubview(gameName)
        view.addSubview(startButton)
        view.addSubview(resumeButton)
        view.addSubview(highScoresButton)
    
        setButtonLayouts(name: gameName, start: startButton, resume: resumeButton, highScores: highScoresButton)
        styleObjects(name: gameName, start: startButton, resume: resumeButton, highScores: highScoresButton)
    
        startButton.addTarget(self, action: #selector(makeNewGame), for: UIControlEvents.touchUpInside)
        highScoresButton.addTarget(self, action: #selector(gotoHighScores), for: UIControlEvents.touchUpInside)
        resumeButton.addTarget(self, action: #selector(showOngoingGames), for:  UIControlEvents.touchUpInside)
    }
    
    // remove ongoing game controller and push game
    @objc func pushGameController(){
        let resumedGame = GameController(nibName: nil, bundle: nil, theGame:  ongoingGameController.pushedGame)
        newGameController = resumedGame
        dismiss(animated: false, completion: nil)
        self.present(resumedGame, animated: false, completion: nil)
    }
    
    
    @objc func showOngoingGames(){
        self.present(ongoingGameController, animated: false, completion: nil)
    }
    
    @objc func makeNewGame(){
    
        let newGame = Game()
        print("making new game \(newGame)")
        newGameController = GameController(nibName: nil, bundle: nil, theGame: newGame)
        self.present(newGameController, animated: false, completion: nil)
    }
    
    @objc func saveGame(){
        dismiss(animated: false, completion: nil)
        ongoingGameController.activeGames.insert(newGameController.game, at: 0)
        
    }
    
    
    @objc func gotoHighScores(){
        self.present(highScoreController, animated: false, completion: nil)
    }
    
    /* dismisses the high score page, and the game screen if led there by finishing game */
    @objc func returnToMain(){
        dismiss(animated: false, completion: nil)
    }
    
    
    /*
    takes user to high score page if warrented, else returns them to main menu */
    func returnFromGame(score: Int){
        let sortedTop5 = HighScoresController.top5.sorted {$0.score > $1.score}
        if sortedTop5.count == 5 {
            if score > sortedTop5[HighScoresController.top5.count - 1].score {
                // push high score view with space for new name
                for (index, t) in sortedTop5.enumerated() {
                    if score > t.score {
                        highScoreController.hView.setNewScore(order: index + 1, score: String(score) + "      " + String(describing: Date()))
                        break
                    }
                }
                
                dismiss(animated: false, completion: nil)
                gotoHighScores()
            }
            else {
                // returns user to the main menu
                dismiss(animated: false, completion: nil)
            }
            
        }
        else {
            if score > sortedTop5[HighScoresController.top5.count - 1].score {
                for (index, t) in sortedTop5.enumerated() {
                    if score > t.score {
                        highScoreController.hView.setNewScore(order: index + 1, score: String(score) + "      " + String(describing: Date()))
                        break
                    }
                }
            }
            else {
                highScoreController.hView.setNewScore(order: HighScoresController.top5.count + 1, score: String(score) + "      " + String(describing: Date()))
            }
            dismiss(animated: false, completion: nil)
            gotoHighScores()
        }
    }
        
    

    
    func styleObjects(name: UILabel, start: UIButton, resume: UIButton, highScores: UIButton){
        // Format the game name
        let gameNameString: NSMutableAttributedString = NSMutableAttributedString()
        gameNameString.append(NSAttributedString(string: "WHACK-A-CLOWN"))
        gameNameString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "AmericanTypewriter-CondensedBold", size: name.font.pointSize * 2)! , range:  NSRange(location: 0, length: gameNameString.length))
        
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow, range: NSRange(location: 1, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 2, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow, range: NSRange(location: 3, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 4, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow, range: NSRange(location: 5, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 6, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow, range: NSRange(location: 7, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 8, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow, range: NSRange(location: 9, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 10, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow, range: NSRange(location: 11, length: 1))
        gameNameString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 12, length: 1))
        
        name.attributedText = gameNameString
        name.textAlignment = NSTextAlignment.center
        name.adjustsFontSizeToFitWidth = true
        
        start.setTitle("Start Game", for: UIControlState.normal)
        resume.setTitle("Resume Game", for: UIControlState.normal)
        highScores.setTitle("High Scores", for: UIControlState.normal)
       
        start.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        resume.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        highScores.setTitleColor(UIColor.cyan, for: UIControlState.normal)
    }
    

    func setButtonLayouts(name: UILabel, start: UIButton, resume: UIButton, highScores: UIButton){
        name.translatesAutoresizingMaskIntoConstraints = false
        start.translatesAutoresizingMaskIntoConstraints = false
        resume.translatesAutoresizingMaskIntoConstraints = false
        highScores.translatesAutoresizingMaskIntoConstraints = false
        
        let views:[String : UIView] = ["name": name, "start": start, "resume": resume, "highScores": highScores]
    
         view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[name]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[start]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[resume]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[highScores]-|", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-[start][resume][highScores]-|", options: [], metrics: nil, views: views))
        
        view.addConstraint(NSLayoutConstraint(item: name, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: start, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: start, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: resume, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
         view.addConstraint(NSLayoutConstraint(item: resume, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: highScores, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
