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
    var progress: ProgressView
    var game: Game
    var background: UIImageView
    var displayTimer: Timer?
    var logicTimer: Timer?
    var gameLoop: Thread
    var actionView: GameView
    var gameMaxX: Int
    var gameMaxY: Int
    var lastLevel: Int
    var firingTimer: Timer?
    var moveLeftTimer: Timer?
    var moveRightTimer: Timer?
    var moveUpTimer: Timer?
    var moveDownTimer: Timer?
    
     init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, theGame: Game ) {
        print("making new controller")
        game = theGame
        lastLevel = game.level
        controls = MotionControls()
        progress = ProgressView()
        actionView = GameView(frame: CGRect(x:0,y:0,width:0,height:0), enemies: game.currentEnemies, projectiles: [])
        actionView.game = self.game
        gameLoop = Thread()
        
        // needed because bounds & frame cannot be accessed in the secondary thread
        gameMaxX = 0
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
        
        view.addSubview(progress)
        view.addSubview(background)
        background.addSubview(actionView)
        view.addSubview(controls)
        
       
        setLayouts()
        
        setActionTargets()
    }
    
    /* sets up the actions taken by each of the game controller buttons */
    func setActionTargets() {
        controls.moveUp.addTarget(self, action: #selector(movePlayerUp), for: UIControlEvents.touchDown)
        controls.moveDown.addTarget(self, action: #selector(movePlayerDown), for: UIControlEvents.touchDown)
        controls.moveLeft.addTarget(self, action: #selector(movePlayerLeft), for: UIControlEvents.touchDown)
        controls.moveRight.addTarget(self, action: #selector(movePlayerRight), for: UIControlEvents.touchDown)
        controls.fire.addTarget(self, action: #selector(firePie), for: UIControlEvents.touchDown)
        
        let longPresssFire = UILongPressGestureRecognizer(target: self, action: #selector(longFire))
        let longPressRight = UILongPressGestureRecognizer(target: self, action: #selector(longRight))
        let longPressLeft = UILongPressGestureRecognizer(target: self, action: #selector(longLeft))
        let longPressUp = UILongPressGestureRecognizer(target: self, action: #selector(longUp))
        let longPressDown = UILongPressGestureRecognizer(target: self, action: #selector(longDown))

        controls.fire.addGestureRecognizer(longPresssFire)
        controls.moveRight.addGestureRecognizer(longPressRight)
        controls.moveLeft.addGestureRecognizer(longPressLeft)
        controls.moveUp.addGestureRecognizer(longPressUp)
        controls.moveDown.addGestureRecognizer(longPressDown)
    }
    
    @objc func movePlayerUp() {
        if game.player.currentY > 0 {
            game.player.currentY -= 10
        }
    }
    @objc func longUp(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            moveUpTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(movePlayerUp), userInfo: nil, repeats: true)
        }
        
        if sender.state == .ended {
            moveUpTimer?.invalidate()
            moveUpTimer = nil
        }
    }
    
    
    @objc func movePlayerDown() {
        if game.player.currentY < Double(background.frame.maxY - background.frame.maxY / 9) {
            game.player.currentY += 10
        }
    }
    @objc func longDown(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            moveDownTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(movePlayerDown), userInfo: nil, repeats: true)
        }
        
        if sender.state == .ended {
            moveDownTimer?.invalidate()
            moveDownTimer = nil
        }
    }
    
    
    @objc func movePlayerLeft() {
        if game.player.currentX > 0 {
            game.player.currentX -= 10
        }
    }
    @objc func longLeft(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            moveLeftTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(movePlayerLeft), userInfo: nil, repeats: true)
        }
        
        if sender.state == .ended {
            moveLeftTimer?.invalidate()
            moveLeftTimer = nil
        }
    }

    
    
    @objc func movePlayerRight() {
        if game.player.currentX < Double(background.frame.maxX - background.frame.maxX / 5) {
            game.player.currentX += 10
        }
    }
    @objc func longRight(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            moveRightTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(movePlayerRight), userInfo: nil, repeats: true)
        }
        
        if sender.state == .ended {
            moveRightTimer?.invalidate()
            moveRightTimer = nil
        }
    }
    

    /* adds a new pie to the game which moves straight up from the place the players postion during launch */
    @objc func firePie() {
        // add a traveling ob inst to game
        let newProjectile = TravelingObject(pX: game.player.currentX + Double(gameMaxX / 20), pY: game.player.currentY - 10, vX: 0, vY: 700)
        
        game.currentProjectiles.append(newProjectile)
    }
    
    @objc func longFire(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
           firingTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.65), target: self, selector: #selector(firePie), userInfo: nil, repeats: true)
        }
        
        if sender.state == .ended {
            print("ended")
            firingTimer?.invalidate()
            firingTimer = nil
        }
    }
    
    
    /* Wait until the view has loaded to being updating display */
    override func viewDidLoad() {
    /*    displayTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1/60), target: self, selector: #selector(updateGameDisplay), userInfo: nil, repeats: true)
        print("starting the display loop")*/
    }
    
    /* wait until subview are loaded to be able to center character and begin game logic */
    override func viewDidAppear(_ animated: Bool) {
        // center the player to initial position
        displayTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1/60), target: self, selector: #selector(updateGameDisplay), userInfo: nil, repeats: true)
        
        game.player.currentX = Double(UIScreen.main.bounds.maxX) / 2.2
        game.player.currentY = Double(UIScreen.main.bounds.maxX) / 1.01
  
        gameLoop.start()
    }

    
    
    /* Updates the logic components of that represent the state of the game */
    func updateGameState(){
        var dtime: Date = Date()
        while(true){
            
            if gameLoop.isCancelled {
                print("cancelling game loop")
                break
            }
            let timePassed: Double =  0.0 - dtime.timeIntervalSince(Date())
            
            // Use time passed to update enemies
            for e in game.currentEnemies {
                // enemy has moved into the screen
                if !e.active && e.currentX > 0 && e.currentX < Double(gameMaxX) && e.currentY > 0 && e.currentY < Double(gameMaxY) {
                    e.active = true
                }
                
                e.currentX = e.currentX + Double(e.vX) * timePassed
                e.currentY = e.currentY + Double(e.vY) * timePassed
                
                // enemy has moved through the screen
                if e.active &&  !e.eliminated && ((e.currentX < 0 - Double(gameMaxX / 5) || e.currentX > Double(gameMaxX)) || (e.currentY < 0 - Double(gameMaxY / 9)  || e.currentY > Double(gameMaxY))) {
                    e.eliminated = true
                }
            }
            
            
            // update projectiles
            for (index, p) in game.currentProjectiles.enumerated() {
                p.currentY = p.currentY - Double(p.vY) * timePassed
                if (p.currentX < 0 - Double(gameMaxX / 5) || p.currentX > Double(gameMaxX)) || (p.currentY < 0 - Double(gameMaxY / 9)  || p.currentY > Double(gameMaxY)) {
                    game.currentProjectiles.remove(at: index)
                }
            }
            
            // update time to now
            dtime = Date()
            
            // check for collisions
            // collisions only have an effect between enemies and other items
            for e in game.currentEnemies {
                if e.eliminated {
                    print("eliminated")
                }
                
                // check agains player
                if !e.eliminated && areOverlapping(obj1: e, obj2: game.player) {
                    e.eliminated = true
                    game.livesLeft -= 1
                    print(game.livesLeft)
                    
                    if game.livesLeft <= 0 {
                        // game over
                        Thread.exit()
                        break
                    }
                    
                }
                
                // check for projectile hits
                for p in game.currentProjectiles {
                    if !e.eliminated && areOverlapping(obj1: e, obj2: p) {
                        e.eliminated = true
                        p.eliminated = true
                        game.score += 5
                    }
                }
            }
            
            if allEliminated() {
                // level complete, breaking without changing alive value
                if game.level == 3 {
                    // endgame
                    print("GAME DONE")
                    break
                    
                }
                else {
                    // LEVEL UP
                    print("level up")
                    game.currentProjectiles = []
                    game.player.currentX = Double(gameMaxX) / 2 - Double(gameMaxX) / 10  // subtraction used to center
                    game.player.currentY = Double(gameMaxY) - Double(gameMaxY) / 8
                    game.level += 1
                    if game.level == 2 {
                        game.currentEnemies = Levels.level2Enemies
                    }
                    
                    if game.level == 3 {
                        game.currentEnemies = Levels.level3Enemies
                    }
                }
            }
        }
    }
    
    
    func gameOver() {
        // either high score screen or main menu
    }
    
    func levelComplete() {
        print("LEVEL COMPLETE")
    }
    
    
    /* determined if two objects have collided */
    func areOverlapping(obj1: TravelingObject, obj2: TravelingObject) -> Bool {
        if obj2.currentX + Double(gameMaxX) / 10 > obj1.currentX && obj2.currentX + Double(gameMaxX) / 10 < obj1.currentX + Double(gameMaxX) / 10 &&
            obj2.currentY > obj1.currentY && obj2.currentY < obj1.currentY + Double(gameMaxX) / 10 {
            print("HIT 1")
            return true
        }

       if obj2.currentX > obj1.currentX && obj2.currentX  < obj1.currentX + Double(gameMaxX) / 10  &&
            obj2.currentY > obj1.currentY && obj2.currentY < obj1.currentY + Double(gameMaxX) / 11 {
            print("HIT 2")
            return true
        }
        
       
        return false
    }
    
    
    func allEliminated() -> Bool {
        for e in game.currentEnemies {
            if e.eliminated == false {
                return false
            }
        }
        return true
    }
    
    @objc func updateGameDisplay(){
        // This will update set the max values for moving objects
        // needed b/c frame for background is initalized to 0,0,0,0 and set after view did load
        gameMaxX = Int(actionView.frame.maxX)
        gameMaxY = Int(actionView.frame.maxY)
        
        // calls layout of "moving" views
        actionView.setNeedsLayout()
        
        // update lives and scores
        progress.lives.setLives(remaining: game.livesLeft)
        progress.score.text = String(game.score)
        
        // player has leveled up
        if lastLevel != game.level {
            lastLevel = game.level
            if game.level == 2 {
                background.image = UIImage(named: "images/background2.jpg")
            }
            else {
                background.image = UIImage(named: "images/background3.jpg")
            }
        }
        
        if gameLoop.isFinished {
            displayTimer?.invalidate()
            presentGameOver()
        }
    }
    
    
    @objc func saveGame(){
        if let pvc = presentingViewController {
            gameLoop.cancel()
            displayTimer?.invalidate()
            UIApplication.shared.sendAction(#selector((pvc as! MainMenuController).saveGame), to: pvc, from: self, for: nil)
        }
        
    }
    
    
    func presentGameOver(){
        let gameOverController = UIAlertController(title: "Game Over", message: "Your total score is \(game.score)", preferredStyle: .alert)       
        gameOverController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction) in (self.presentingViewController as! MainMenuController).returnFromGame(score: self.game.score) }))
        present(gameOverController, animated: true, completion: nil)
    }
    
    func setLayouts(){
        // sets the layouts of the three main components
        controls.translatesAutoresizingMaskIntoConstraints = false
        background.translatesAutoresizingMaskIntoConstraints = false
        actionView.translatesAutoresizingMaskIntoConstraints = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        
        let views:[String : UIView] = ["controls": controls, "bg": background, "action": actionView, "progress": progress]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[progress][bg][controls]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[controls]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bg]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[progress]|", options: [], metrics: nil, views: views))
        
        
        // sets the layout of the actionview to entirely overlap the image view
        background.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[action]|", options: [], metrics: nil, views: views))
        background.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[action]|", options: [], metrics: nil, views: views))
        
        view.addConstraint(NSLayoutConstraint(item: progress, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: background, attribute: NSLayoutAttribute.height, multiplier: 0.2, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: controls, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: background, attribute: NSLayoutAttribute.height, multiplier: 0.1, constant: 0.0))
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




/* The view that contains all of the moving pieces of the game,
 the targets, the player's character, and the projectiles
 */
class GameView: UIView {
    var enemyViews: [UIImageView]
    var player: UIImageView
    var projectileViews: [UIImageView]
    var game: Game
    

    init(frame: CGRect, enemies:[TravelingObject], projectiles: [TravelingObject]) {
        self.enemyViews = []
        self.projectileViews = []
        player = UIImageView()
        game = Game()
        super.init(frame: frame)
        self.backgroundColor = UIColor(cgColor: UIColor.black.cgColor.copy(alpha: 0.6)!)
        
        for e in game.currentEnemies {
            // create a view with the clown for each enemy in the game
            let eView: UIImageView = UIImageView()
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
    
    
    /* renders the moving pieces of the game */
    override func layoutSubviews(){
        if enemyViews.count < game.currentEnemies.count {
            for _ in 1 ... (game.currentEnemies.count - enemyViews.count) {
                let eView: UIImageView = UIImageView()
                eView.image = UIImage(named: "images/clown.png")
                self.enemyViews.append(eView)
                addSubview(eView)
            }
        }
        for (e, v) in zip(game.currentEnemies, enemyViews) {
            // override the frame with one indicating new position
            if !e.eliminated {
                let eFrame: CGRect = CGRect(x: CGFloat(e.currentX), y: CGFloat(e.currentY), width: bounds.maxX / 10, height: bounds.maxX / 11)
                v.frame = eFrame
            }
            else {
                // put the frame out of sight
                let eFrame: CGRect = CGRect(x: -1, y: -1, width: 0, height: 0)
                v.frame = eFrame
            }
        }
        
        
        // remove old projectile frames
        for pv in projectileViews {
            pv.removeFromSuperview()
        }
        
        // place new projectile frames
        for p in game.currentProjectiles {
            // create a view with the pie
            if !p.eliminated {
                let pView: UIImageView = UIImageView(frame: CGRect(x: CGFloat(p.currentX), y: CGFloat(p.currentY), width: bounds.maxX / 13, height: bounds.maxX / 12))
                pView.image = UIImage(named: "images/pie.png")
                projectileViews.append(pView)
                addSubview(pView)
            }
        }
        
        // render the player's character
        player.frame = CGRect(x: CGFloat(game.player.currentX), y: CGFloat(game.player.currentY), width: frame.maxX / 5, height: frame.maxY / 9)
    }
}




/*
 Represents a the game state
 */
class Game: NSObject, NSCoding {
    
    var level: Int
    var score: Int
    var currentEnemies: [TravelingObject]
    var currentProjectiles: [TravelingObject]
    var player: TravelingObject
    var livesLeft: Int
 
    override init() {
        level = 1
        score = 0
        currentEnemies = Levels.level1Enemies
        player = TravelingObject(pX: 0, pY: 0, vX: 0 ,vY: 0)
        currentProjectiles = []
        livesLeft = 4
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(level, forKey: "level")
        aCoder.encode(score, forKey: "score")
        aCoder.encode(currentEnemies, forKey: "currentEnemies")
        aCoder.encode(currentProjectiles, forKey: "currentProjectiles")
        aCoder.encode(player, forKey: "player")
        aCoder.encode(livesLeft, forKey: "livesLeft")
    }
    
    required init?(coder aDecoder: NSCoder) {
        level = Int(aDecoder.decodeInt32(forKey: "level"))
        score = Int(aDecoder.decodeInt32(forKey: "score"))
        currentEnemies = aDecoder.decodeObject(forKey: "currentEnemies") as! [TravelingObject]
        currentProjectiles = aDecoder.decodeObject(forKey: "currentProjectiles") as! [TravelingObject]
        player =  aDecoder.decodeObject(forKey: "player") as! TravelingObject
        livesLeft = Int(aDecoder.decodeInt32(forKey: "livesLeft"))
    }
    
}


/*
 Represents object that can move in the game
 */
class TravelingObject: NSObject, NSCoding {

    var startX: Double
    var startY: Double
    var vX: Int
    var vY: Int
    var currentX:Double
    var currentY: Double
    var active: Bool
    var eliminated: Bool
    
    init(pX: Double, pY: Double, vX: Int, vY: Int) {
        startX = pX
        startY = pY
        self.vX = vX
        self.vY = vY
        currentX = pX
        currentY = pY
        active = false
        eliminated = false
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(startX, forKey: "startX")
        aCoder.encode(startY, forKey: "startY")
        aCoder.encode(vX, forKey: "vX")
        aCoder.encode(vY, forKey: "vY")
        aCoder.encode(currentX, forKey: "currentX")
        aCoder.encode(currentY, forKey: "currentY")
        aCoder.encode(active, forKey: "active")
        aCoder.encode(eliminated, forKey: "eliminated")
    }
    
    required init?(coder aDecoder: NSCoder) {
        startX = aDecoder.decodeDouble(forKey: "startX")
        startY = aDecoder.decodeDouble(forKey: "startY")
        vX = Int(aDecoder.decodeInt32(forKey: "vX"))
        vY = Int(aDecoder.decodeInt32(forKey: "vY"))
        currentX = aDecoder.decodeDouble(forKey: "currentX")
        currentY = aDecoder.decodeDouble(forKey: "currentY")
        active = aDecoder.decodeBool(forKey: "active")
        eliminated = aDecoder.decodeBool(forKey: "eliminated")        
    }
    
}



