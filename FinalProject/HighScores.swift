//
//  HighScores.swift
//  FinalProject
//
//  Created by Alejandra Pardo on 5/1/18.
//  Copyright © 2018 Alejandra Pardo. All rights reserved.
//

import Foundation
import UIKit

class HighScoresController: UIViewController{
    // have global of the mainteined top 5 scores in sorter ord
    static var top5: [(score: Int, date: String)] = []
    
    var hView: HighScoresView
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let scoreView = HighScoresView()
        hView = scoreView
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // load last saved scores from file
        
        view = hView
        
        
        let  sortedTop5 = HighScoresController.top5.sorted {$0.score > $1.score}
        var index: Int = 1
        for t in sortedTop5 {
            scoreView.setScore(order: index, score: String(t.score) + "      " + String(describing: t.date))
            index += 1
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HighScoresView: UIView {
    var score1: UITextField
    var score2: UITextField
    var score3: UITextField
    var score4: UITextField
    var score5: UITextField
    var returnButton: UIButton
    
    override init(frame: CGRect) {
        score1 = UITextField()
        score2 = UITextField()
        score3 = UITextField()
        score4 = UITextField()
        score5 = UITextField()
        returnButton = UIButton()
        super.init(frame: frame)
        
        let title: UILabel = UILabel()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = NSTextAlignment.center
        title.adjustsFontSizeToFitWidth = true
        let titleString: NSMutableAttributedString = NSMutableAttributedString()
        titleString.append(NSAttributedString(string: "High Scores"))
        titleString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "AmericanTypewriter-CondensedBold", size: title.font.pointSize * 2)! , range:  NSRange(location: 0, length: titleString.length))
        
        titleString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow, range: NSRange(location: 0, length: titleString.length))
        title.attributedText = titleString
        addSubview(title)
        
        
        returnButton.setTitle("Main Menu", for: UIControlState.normal)
        returnButton.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(returnButton)
        
        // by default, only show the scores, no editing
        score1.isUserInteractionEnabled = false
        score2.isUserInteractionEnabled = false
        score3.isUserInteractionEnabled = false
        score4.isUserInteractionEnabled = false
        score5.isUserInteractionEnabled = false
        
        score1.textColor = UIColor.red
        score2.textColor = UIColor.yellow
        score3.textColor = UIColor.red
        score4.textColor = UIColor.yellow
        score5.textColor = UIColor.red
        
        score1.textAlignment = .center
        score2.textAlignment = .center
        score3.textAlignment = .center
        score4.textAlignment = .center
        score5.textAlignment = .center
        
        
        score1.translatesAutoresizingMaskIntoConstraints = false
        score2.translatesAutoresizingMaskIntoConstraints = false
        score3.translatesAutoresizingMaskIntoConstraints = false
        score4.translatesAutoresizingMaskIntoConstraints = false
        score5.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(score1)
        addSubview(score2)
        addSubview(score3)
        addSubview(score4)
        addSubview(score5)
        
        let views:[String : UIView] = ["score1": score1, "score2": score2,"score3": score3, "score4": score4, "score5": score5, "title": title, "return": returnButton]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-[score1][score2][score3][score4][score5]-[return]-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[title]-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[score1]-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[score2]-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[score3]-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[score4]-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[score5]-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[return]-|", options: [], metrics: nil, views: views))
        
        
        addConstraint(NSLayoutConstraint(item: score1, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: score2, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: score2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: score3, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: score3, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: score4, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: score4, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: score5, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: title, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: score1, attribute: NSLayoutAttribute.height, multiplier: 2, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: score1, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: returnButton, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0.0))
    }
    
    func setScores(first: String, second: String, third: String, fourth: String, fifth: String){
        score1.text = first
        score2.text = second
        score3.text = third
        score4.text = fourth
        score5.text = fifth
    }
    
    func setScore(order: Int, score: String){
        if order == 1 {
            score1.text = score
        }
        else if order == 2 {
            score2.text = score
        }
        else if order == 3 {
            score3.text = score
        }
        else if order == 4 {
            score4.text = score
        }
        else if order == 5 {
            score5.text = score
        }
    }
    
    
     func setNewScore(order: Int, score: String) {
        print("new score")
        pushScoreDown(order: order)
        setScore(order: order, score: score)
        setNeedsDisplay()
    }
    
    /* moves score down by one spot begining at given index */
    func pushScoreDown(order: Int){
        if order == 4 {
            setScore(order: 5, score: score4.text ?? " ")
        }
        if(order == 3) {
            pushScoreDown(order: 4)
            setScore(order: 4, score: score3.text ?? " ")
        }
        if(order == 2) {
            pushScoreDown(order: 3)
            setScore(order: 3, score: score2.text ?? " ")
        }
        if(order == 1) {
            pushScoreDown(order: 2)
            setScore(order: 2, score: score1.text ?? " ")
        }
        
    }
    

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
