//
//  lineupcell.swift
//  lookingfor-2ndproject
//
//  Created by Leon Iwami on 2016/05/31.
//  Copyright © 2016年 Leon Iwami. All rights reserved.
//

import UIKit

class lineupcell: UICollectionViewCell {
    
        @IBOutlet var imgcell:UIImageView!
        @IBOutlet var datecell:UILabel!
        
        override init(frame: CGRect){
            super.init(frame: frame)
        }
        required init(coder aDecoder: NSCoder){
            super.init(coder: aDecoder)!
        }
}

