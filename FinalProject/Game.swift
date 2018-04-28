//
//  Game.swift
//  FinalProject
//
//  Created by Alejandra Pardo on 4/26/18.
//  Copyright © 2018 Alejandra Pardo. All rights reserved.
//

import Foundation
import UIKit

class GameController: UIViewController {
    var controls: MotionControls
    var game: Game
    var background: UIImageView
    var displayTimer: Timer?
    var logicTimer: Timer?
    var gameLoop: Thread
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        game = Game()
        game.level = 3
        controls = MotionControls()
        gameLoop = Thread()
        // set the background image
        let imageName: String
        if game.level == 1{
            imageName = "images/background1.jpg"
        } else if game .level == 2 {
            imageName = "images/background2.jpg"
        } else {
         imageName = "images/background3.jpg"
        }
        
        background = UIImageView(image: UIImage(named: imageName))
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        gameLoop = Thread(block: updateGameState)
        
        view.addSubview(background)        
        view.addSubview(controls)
        setLayouts()
        
    }
    
    
    
    
    /* Wait until the view has loaded to being updating game state and display */
    override func viewDidLoad() {
        displayTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1/60), target: self, selector: #selector(updateGameDisplay), userInfo: nil, repeats: true)

        gameLoop.start()
    }
    
    
    /* Updates the logic components of that represent the state of the game */
    func updateGameState(){
        while(true){
            print("game state")
            game.level += 1
            print("update game \(game.level)")
        }
    }
    
    
    @objc func updateGameDisplay(){
        print("updating the game visuals")
        print(game.level)
       /// use to cancel timer between level timer?.invalidate()
        // draw the enemies
        // draw the persion
        // draw the projectiles
    }
    
    
    
    func setLayouts(){
        controls.translatesAutoresizingMaskIntoConstraints = false
        background.translatesAutoresizingMaskIntoConstraints = false
        
        let views:[String : UIView] = ["controls": controls, "bg": background]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[controls]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bg]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[bg][controls]|", options: [], metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Game: NSObject {
    var level: Int
    var score: Int
    var lastDeployed: Int // the last clown deployed on the level
 
    override init() {
        level = 1
        score = 0
        lastDeployed = 0
        super.init()
    }
    
    
}



class MotionControls: UIView {
    let moveLeft: UIButton = UIButton()
    let moveRight: UIButton = UIButton()
    let moveUp: UIButton = UIButton()
    let moveDown: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        moveLeft.setTitle("left", for: UIControlState.normal)
        moveRight.setTitle("right", for: UIControlState.normal)
        moveUp.setTitle("up", for: UIControlState.normal)
        moveDown.setTitle("down", for: UIControlState.normal)
        
        moveLeft.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        moveRight.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        moveUp.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        moveDown.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        
        moveLeft.translatesAutoresizingMaskIntoConstraints = false
        moveRight.translatesAutoresizingMaskIntoConstraints = false
        moveUp.translatesAutoresizingMaskIntoConstraints = false
        moveDown.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(moveLeft)
        addSubview(moveRight)
        addSubview(moveUp)
        addSubview(moveDown)
        
        let views:[String : UIView] = ["moveLeft": moveLeft, "moveRight": moveRight, "moveUp": moveUp, "moveDown": moveDown]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[moveLeft][moveDown][moveUp][moveRight]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[moveLeft]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[moveRight]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[moveUp]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[moveDown]|", options: [], metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: moveLeft, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: moveDown, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: moveDown, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: moveUp, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: moveUp, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: moveRight, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: moveLeft, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: moveDown, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: moveDown, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: moveUp, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: moveUp, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: moveRight, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LivesLeft: UIView {
    
}
