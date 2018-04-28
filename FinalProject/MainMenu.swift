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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
            }
    
    @objc func makeNewGame(){
        print("making a new game")
        self.present(GameController(), animated: true, completion: nil)
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
