//
//  GameControls.swift
//  FinalProject
//
//  Created by Alejandra Pardo on 5/1/18.
//  Copyright © 2018 Alejandra Pardo. All rights reserved.
//

import Foundation
import  UIKit

/*
 Controls the motion of the players character and the launching of projectiles
 */
class MotionControls: UIView {
    var moveLeft: UIButton = UIButton()
    var moveRight: UIButton = UIButton()
    var moveUp: UIButton = UIButton()
    var moveDown: UIButton = UIButton()
    var fire: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        moveLeft.setTitle("left", for: UIControlState.normal)
        moveRight.setTitle("right", for: UIControlState.normal)
        moveUp.setTitle("up", for: UIControlState.normal)
        moveDown.setTitle("down", for: UIControlState.normal)
        fire.setTitle("fire", for: UIControlState.normal)
        
        moveLeft.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        moveRight.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        moveUp.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        moveDown.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        fire.setTitleColor(UIColor.orange, for: UIControlState.normal)
        
        moveLeft.backgroundColor = UIColor.black
        moveRight.backgroundColor = UIColor.black
        moveUp.backgroundColor = UIColor.black
        moveDown.backgroundColor = UIColor.black
        fire.backgroundColor = UIColor.black
        
        moveLeft.translatesAutoresizingMaskIntoConstraints = false
        moveRight.translatesAutoresizingMaskIntoConstraints = false
        moveUp.translatesAutoresizingMaskIntoConstraints = false
        moveDown.translatesAutoresizingMaskIntoConstraints = false
        fire.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(moveLeft)
        addSubview(moveRight)
        addSubview(moveUp)
        addSubview(moveDown)
        addSubview(fire)
        
        let views:[String : UIView] = ["moveLeft": moveLeft, "moveRight": moveRight, "moveUp": moveUp, "moveDown": moveDown, "fire": fire]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[moveLeft][moveDown][fire][moveUp][moveRight]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[moveLeft]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[moveRight]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[moveUp]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[moveDown]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[fire]|", options: [], metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: moveLeft, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: moveDown, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: moveDown, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: moveUp, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: moveUp, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: moveRight, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: moveUp, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: fire, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: moveLeft, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: moveDown, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: moveDown, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: moveUp, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: moveUp, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: moveRight, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: moveUp, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: fire, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
 Contains the players score and the lives the player has left
 */
class ProgressView: UIView {
    var score: UILabel
    var lives: LivesView
    
    override init(frame: CGRect) {
        score = UILabel()
        score.textColor = UIColor.yellow
        score.textAlignment = .center
        lives = LivesView()
        super.init(frame: frame)
        
        score.translatesAutoresizingMaskIntoConstraints = false
        lives.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(score)
        addSubview(lives)
        
        let views:[String : UIView] = ["score": score, "lives": lives]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[score]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lives]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lives][score]|", options: [], metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: lives, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 0.70, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: score, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 0.25, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LivesView: UIView {
    var life1: UIImageView
    var life2: UIImageView
    var life3: UIImageView
    var life4: UIImageView
    
    override init(frame: CGRect) {
        // set image after initalization to avoid forcing frame size
        life1 = UIImageView()
        life2 = UIImageView()
        life3 = UIImageView()
        life4 = UIImageView()
        
        super.init(frame: frame)
        
        life1.translatesAutoresizingMaskIntoConstraints = false
        life2.translatesAutoresizingMaskIntoConstraints = false
        life3.translatesAutoresizingMaskIntoConstraints = false
        life4.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(life1)
        addSubview(life2)
        addSubview(life3)
        addSubview(life4)
        
        let views:[String : UIView] = ["life1": life1, "life2": life2,"life3": life3, "life4": life4]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[life1][life2][life3][life4]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[life1]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[life2]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[life3]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[life4]|", options: [], metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: life1, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 0.25, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: life2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 0.25, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: life3, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 0.25, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: life4, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 0.25, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: life1, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: life1, attribute: NSLayoutAttribute.height, multiplier: 0.50, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: life2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: life2, attribute: NSLayoutAttribute.height, multiplier: 0.50, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: life3, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: life3, attribute: NSLayoutAttribute.height, multiplier: 0.50, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: life4, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: life4, attribute: NSLayoutAttribute.height, multiplier: 0.50, constant: 0.0))
        
        life1.image = UIImage(named: "images/popcorn.png")
        life2.image = UIImage(named: "images/popcorn.png")
        life3.image = UIImage(named: "images/popcorn.png")
        life4.image = UIImage(named: "images/popcorn.png")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLives(remaining: Int){
        if remaining < 1 {
            life1.image = nil
        }
        if remaining < 2 {
            life2.image = nil
        }
        if remaining < 3 {
            life3.image = nil
        }
        if remaining < 4 {
            life4.image = nil
            life4.setNeedsDisplay()
        }
    }
}

