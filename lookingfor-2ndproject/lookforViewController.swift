//
//  lookforViewController.swift
//  lookingfor-2ndproject
//
//  Created by Leon Iwami on 2016/05/31.
//  Copyright © 2016年 Leon Iwami. All rights reserved.
//

import UIKit
import RealmSwift

class lookforViewController: UIViewController {
    
    @IBOutlet var collectionview: UICollectionView!
    
    
    var num: Int!
    
    var array = []
    
//    let allinformations: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var monoArray : NSMutableArray = [0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        monoArray = allinformations.objectForKey("openinformation") as! NSMutableArray
        let realm = try! Realm()
        let infoArray = realm.objects(information)
        print("11111111111")
        print(infoArray)
        print("22222222222")
        
        let info001: information = infoArray[3]
        
        print(info001)
        print(info001["textmessages"])
//        array = infoArray as NSArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:lineupcell = collectionView.dequeueReusableCellWithReuseIdentifier("photoandvoice", forIndexPath: indexPath) as! lineupcell
        cell.datecell.text = "date"
//        let lineup = monoArray[indexPath.row] as! information
//        let infoArray = realm.objects(information)
        
//        let lineup = infoArray[indexPath.row] as! information
//        cell.imgcell.image = UIImage(data:lineup.images!)
        return cell
    }
    
    // セクションの数（今回は1つだけです）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 表示するセルの数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 //infoArray.count
    }
    
    //size
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 2 - 2
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    //StringをUIImageに変換する
    func nsdatatouiimage(imageNSData:NSData) -> UIImage? {
        let image: UIImage? = UIImage(data: imageNSData)
        return image
        
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
