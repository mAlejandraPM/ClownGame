//
//  Levels.swift
//  FinalProject
//
//  Created by Alejandra Pardo on 4/28/18.
//  Copyright © 2018 Alejandra Pardo. All rights reserved.
//

import Foundation
import UIKit
class Levels {
    static let level1Enemies: [TravelingObject] = [
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: 0, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 9, pY: -200, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: -400, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.2, pY: -800, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: -1000, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 3.3, pY: -1200, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 7.5, pY: -1400, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: -1600, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 2, pY: -1800, vX: 0, vY: 120),
        
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: -2000, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 6, pY: -2200, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: -2400, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.6, pY: -2600, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 4, pY: -2800, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.74, pY: -3000, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 2, pY: -3400, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 11, pY: -3600, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.5, pY: -3800, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 8, pY: -4000, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 3, pY: -4200, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: -4400, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.7, pY: -4600, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 3, pY: -4800, vX: 0, vY: 120)]
    
    static let level2Enemies: [TravelingObject] = [
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: 0, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 9, pY: -100, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: -200, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.2, pY: -300, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.6, pY: -500, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: -600, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 7, pY: -700, vX: 10, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 2, pY: -800, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 11, pY: -900, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: -1000, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 7.5, pY: -1100, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: -1200, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 2, pY: -1300, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: -1400, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 4, pY: -1600, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.74, pY: -1700, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 3, pY: -1800, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.5, pY: -1900, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 8, pY: -2000, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 3.3, pY: -2100, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 11, pY: -2200, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.7, pY: -2300, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 3, pY: -2400, vX: 0, vY: 140)]
    
    
    static let level3Enemies: [TravelingObject] = [
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: 0, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 9, pY: -100, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: -200, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.2, pY: -300, vX: 0, vY: 150),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.6, pY: -500, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: -600, vX: 0, vY: 150),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 7, pY: -700, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 2, pY: -800, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 11, pY: -900, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: -1000, vX: 0, vY: 120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 7.5, pY: -1100, vX: 0, vY: 140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: -1200, vX: 0, vY: 140),
        
        
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: Double(UIScreen.main.bounds.maxY), vX: 0, vY: -140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 9, pY: Double(UIScreen.main.bounds.maxY) + 100, vX: 0, vY: -120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: Double(UIScreen.main.bounds.maxY) + 200, vX: 0, vY: -140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.2, pY: Double(UIScreen.main.bounds.maxY) + 300, vX: 0, vY: -120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.6, pY:  Double(UIScreen.main.bounds.maxY) + 500, vX: 0, vY: -120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: Double(UIScreen.main.bounds.maxY) + 600, vX: 0, vY: -150),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 7, pY: Double(UIScreen.main.bounds.maxY) + 700, vX: 0, vY: -140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 2, pY: Double(UIScreen.main.bounds.maxY) + 800, vX: 0, vY: -120),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 11, pY: Double(UIScreen.main.bounds.maxY) + 900, vX: 0, vY: -140),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: Double(UIScreen.main.bounds.maxY) + 1000, vX: 0, vY: -150),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 7.5, pY: Double(UIScreen.main.bounds.maxY) + 1100, vX: 0, vY: -140),
    ]
    
}

