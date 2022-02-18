//
//  CounterService.swift
//  CounterService
//
//  Created by Patryk Piwowarczyk on 17/09/2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation
import SwiftUI

class CounterService: ObservableObject {

@Published var counterTime: Int = 0


func startCounting(){
    
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
        
        
        if UserDefaults.standard.string(forKey: "timeInBg") != nil {
            self.counterTime = Int(UserDefaults.standard.double(forKey: "timeInBg")) + self.counterTime
            UserDefaults.standard.removeObject(forKey: "timeInBg")
        }
        self.counterTime += 1
        
    }
    
}

}
