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
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: 0, vX: 0, vY: 500),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 9, pY: -100, vX: 0, vY: 500),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: -300, vX: 0, vY: 500),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: -650, vX: 0, vY: 500),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: -900, vX: 0, vY: 500)]
    
    static let level2Enemies: [TravelingObject] = [
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: 0, vX: 0, vY: 500),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 9, pY: Double(UIScreen.main.bounds.maxY), vX: 0, vY: -500),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: Double(UIScreen.main.bounds.maxY), vX: 0, vY: -500),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: -650, vX: 0, vY: 500),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: Double(UIScreen.main.bounds.maxY), vX: 0, vY: -500)]
    
    
    static let level3Enemies: [TravelingObject] = [
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: 0, vX: 0, vY: 100),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 9, pY: -100, vX: 0, vY: 100),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: -300, vX: 0, vY: 100),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: -650, vX: 0, vY: 100),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: -900, vX: 0, vY: 100)]
    
}

