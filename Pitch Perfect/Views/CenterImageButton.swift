//
//  CenterImageButton.swift
//  Pitch Perfect
//
//  Created by Hamada on 15/10/2018.
//  Copyright © 2018 Scarab-dev. All rights reserved.
//

import UIKit

// MARK: - CenterImageButton

class CenterImageButton: UIButton {

    // update button image to be in center and without any stretch
    
    override func draw(_ rect: CGRect) {
        self.contentMode = .center
        self.imageView?.contentMode = .scaleAspectFit
    }
    

}
