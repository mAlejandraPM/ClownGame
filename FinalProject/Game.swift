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
    var gameMaxX: Int
    var gameMaxY: Int
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        game = Game()
        actionView = GameView(frame: CGRect(x:0,y:0,width:0,height:0), enemies: game.currentEnemies, projectiles: [])
        actionView.game = self.game
        currentProjectiles = []
        player = TravelingObject(pX: 0, pY: 0, vX: 0, vY: 0)
        game.level = 3
        controls = MotionControls()
        gameLoop = Thread()
        gameMaxX = 0 // needed because bounds & frame cannot be accessed in the secondary thread
        gameMaxY = 0
        
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
        
        actionView.playerO = self.player
        
    }
    
    
    
    
    /* Wait until the view has loaded to being updating game state and display */
    override func viewDidLoad() {
        displayTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1/60), target: self, selector: #selector(updateGameDisplay), userInfo: nil, repeats: true)

        gameLoop.start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // center the player to initial position
        player.currentX = Double(gameMaxX) / 2 - Double(gameMaxX) / 10  // subtraction used to center
        player.currentY = Double(gameMaxY) - Double(gameMaxY) / 8
    }
    
    
    /* Updates the logic components of that represent the state of the game */
    func updateGameState(){
        var dtime: Date = Date()
        while(true){
            let timePassed: Double =  0.0 - dtime.timeIntervalSince(Date())
            for e in game.currentEnemies {
                e.currentX = e.currentX + Double(e.vX) * timePassed
                e.currentY = e.currentY + Double(e.vY) * timePassed
            }
            
            // update time to now
            dtime = Date()
            
            if game.level == 1000 {
                Thread.exit()
            }
            
            
        }
    }
    
    
    @objc func updateGameDisplay(){
        // This will update set the max values for moving objects
        // needed b/c frame for background is initalized to 0,0,0,0 and set after view did load
        gameMaxX = Int(actionView.frame.maxX)
        gameMaxY = Int(actionView.frame.maxY)
        
        // calls layout of "moving" views
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
    var enemyViews: [UIImageView]
    var enemyFrames: [CGRect]
    var playerO: TravelingObject
    var player: UIImageView
    var projectiles: [UIImageView]
    var game: Game
    

    init(frame: CGRect, enemies:[TravelingObject], projectiles: [TravelingObject]) {
        self.enemyViews = []
        self.enemyFrames = []
        self.projectiles = []
        player = UIImageView()
        playerO = TravelingObject(pX: 0, pY: 0, vX: 0, vY: 0)
        game = Game()
        super.init(frame: frame)
        
        for e in game.currentEnemies {
            // create a view with the clown
            let eView: UIImageView = UIImageView()
            print("\(e.currentY, e.currentX)")
            eView.image = UIImage(named: "images/clown.png")
            self.enemyViews.append(eView)
            addSubview(eView)
        }
        
        
        player.image = UIImage(named: "images/person.png")
        
        
        addSubview(player)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        for (e, v) in zip(game.currentEnemies, enemyViews) {
            // override the frame with one indicating new position
            let eFrame: CGRect = CGRect(x: CGFloat(e.currentX), y: CGFloat(e.currentY), width: bounds.maxX / 7, height: bounds.maxX / 8)
            v.frame = eFrame
        }
        
        /*for p in projectiles {
            // create a view with the pie
            let pView: UIImageView = UIImageView(frame: CGRect(x: CGFloat(p.currentX), y: CGFloat(p.currentY), width: bounds.maxX / 7, height: bounds.maxX / 8))
            pView.image = UIImage(named: "images/pie.jpg")
            addSubview(pView)
        }*/
        
        // render the player's character
        player.frame = CGRect(x: CGFloat(playerO.currentX), y: CGFloat(playerO.currentY), width: frame.maxX / 5, height: frame.maxY / 9)
        
    }
}

/* Represents a the game state */
class Game: NSObject, Codable {
    var level: Int
    var score: Int
    var currentEnemies: [TravelingObject]
 
    override init() {
        level = 1
        score = 0
        currentEnemies = Levels.level1Enemies
        super.init()
    }
}


/* Represents object that can move in the game */
class TravelingObject: NSObject, Codable {
    var startX: Double
    var startY: Double
    var vX: Int
    var vY: Int
    var currentX:Double
    var currentY: Double
    
    init(pX: Double, pY: Double, vX: Int, vY: Int) {
        startX = pX
        startY = pY
        self.vX = vX
        self.vY = vY
        currentX = pX
        currentY = pY
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
