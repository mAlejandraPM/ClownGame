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
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: 0, vX: 0, vY: 1000),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 9, pY: -10, vX: 0, vY: 1000),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.8, pY: -100, vX: 0, vY: 1000),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 5, pY: -150, vX: 0, vY: 1000),
        TravelingObject(pX:Double(UIScreen.main.bounds.maxX) / 1.4, pY: -200, vX: 0, vY: 1000)]
    
}

