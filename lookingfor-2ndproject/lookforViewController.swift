//
//  lookforViewController.swift
//  lookingfor-2ndproject
//
//  Created by Leon Iwami on 2016/05/31.
//  Copyright © 2016年 Leon Iwami. All rights reserved.
//

import UIKit

class lookforViewController: UIViewController {
    
    @IBOutlet var collectionview: UICollectionView!
    
    let allinformations: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var monoArray : NSMutableArray = [0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        monoArray = allinformations.objectForKey("openinformation") as! NSMutableArray
        print("-----------")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:lineupcell = collectionView.dequeueReusableCellWithReuseIdentifier("photoandvoice", forIndexPath: indexPath) as! lineupcell
        cell.datecell.text = "date"
        let lineup = monoArray[indexPath.row] as! information
        cell.imgcell.image = lineup.images
        return cell
    }
    
    // セクションの数（今回は1つだけです）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 表示するセルの数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monoArray.count
    }
    
    //size
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 2 - 2
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
