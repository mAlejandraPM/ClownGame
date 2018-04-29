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
    var actionView: GameView
    var currentProjectiles: [TravelingObject]
    var player: TravelingObject
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        game = Game()
        actionView = GameView()
        currentProjectiles = []
        player = TravelingObject()
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
        
        // set up views that contain the moving pieces
        background = UIImageView()
        background.image = UIImage(named: imageName)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        gameLoop = Thread(block: updateGameState)
        
        view.addSubview(background)        
        view.addSubview(controls)
        background.addSubview(actionView)
        
        setLayouts()
        
        actionView.enemies = game.currentEnemies
        actionView.playerO = self.player
        
    }
    
    
    
    
    /* Wait until the view has loaded to being updating game state and display */
    override func viewDidLoad() {
        displayTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1/60), target: self, selector: #selector(updateGameDisplay), userInfo: nil, repeats: true)

        gameLoop.start()
    }
    
    
    /* Updates the logic components of that represent the state of the game */
    func updateGameState(){
        while(true){
            player.currentX = 350 / 2
            player.currentY = 500 - 50
            
            if game.level == 1000 {
                Thread.exit()
            }
            
            
        }
    }
    
    
    @objc func updateGameDisplay(){
        print("updating game display")
        actionView.setNeedsLayout()
    }
    
    
    
    func setLayouts(){
        // sets the layouts of the three main components
        controls.translatesAutoresizingMaskIntoConstraints = false
        background.translatesAutoresizingMaskIntoConstraints = false
        actionView.translatesAutoresizingMaskIntoConstraints = false
        
        let views:[String : UIView] = ["controls": controls, "bg": background, "action": actionView]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[controls]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bg]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[bg][controls]|", options: [], metrics: nil, views: views))
        
        // sets the layout of the actionview to entirely overlap the image view
        background.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[action]|", options: [], metrics: nil, views: views))
        background.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[action]|", options: [], metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


/* The view that contains all of the moving pieces of the game,
 the targets, the player's character, and the projectiles */
class GameView: UIView {
    var enemies: [TravelingObject]
    var playerO: TravelingObject
    var player: UIImageView
    var projectiles: [TravelingObject]
    
    override init(frame: CGRect) {
        enemies = []
        playerO = TravelingObject()
        player = UIImageView()
        player.image = UIImage(named: "images/person.png")
        projectiles = []
        super.init(frame: frame)
        addSubview(player)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        print("CLOWN FACES")
       /* for e in enemies {
            // create a view with the clown
            let eView: UIImageView = UIImageView(frame: CGRect(x: CGFloat(e.currentX), y: CGFloat(e.currentY), width: bounds.maxX / 7, height: bounds.maxX / 8))
            eView.image = UIImage(named: "images/clown.png")
            addSubview(eView)
        }*/
        
        /*for p in projectiles {
            // create a view with the pie
            let pView: UIImageView = UIImageView(frame: CGRect(x: CGFloat(p.currentX), y: CGFloat(p.currentY), width: bounds.maxX / 7, height: bounds.maxX / 8))
            pView.image = UIImage(named: "images/pie.jpg")
            addSubview(pView)
        }*/
        
        // render the player's character
        //player.frame = CGRect(x: CGFloat(playerO.currentX - 25), y: CGFloat(playerO.currentY - 25, width: bounds.maxX / 7, height: bounds.maxX / 8)
        
       // player.frame = CGRect(x: CGFloat(318), y: CGFloat(530), width: 5, height: 5)
        
        player.frame = CGRect(x: CGFloat(playerO.currentX), y: CGFloat(playerO.currentY), width: 70, height: 70)
        
        print(playerO.currentX)
       print(playerO.currentY)
        print(frame.maxX)
        print(frame.maxY)
        
        
        
    }
}


class Game: NSObject, Codable {
    var level: Int
    var score: Int
    var lastDeployed: Int // the last clown deployed on the level
    var currentEnemies: [TravelingObject]
 
    override init() {
        level = 1
        score = 0
        lastDeployed = 0
        currentEnemies = []
        super.init()
    }
}


class TravelingObject: NSObject, Codable {
    var startX: Int
    var startY: Int
    var speed: Int
    var currentX:Int
    var currentY: Int
    
    // TODO change this to take all params
    override init() {
        startX = 0
        startY = 0
        speed = 0
        currentX = 0
        currentY = 0
        
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

// four image views hosrixzonatlly divided
class LivesLeft: UIView {
    
}
