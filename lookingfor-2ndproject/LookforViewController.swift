//
//  lookforViewController.swift
//  lookingfor-2ndproject
//
//  Created by Leon Iwami on 2016/05/31.
//  Copyright © 2016年 Leon Iwami. All rights reserved.
//

import UIKit
import SwiftFilePath
import RealmSwift
import AVFoundation

var audioPlayer: AVAudioPlayer?

class LookforViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionview: UICollectionView!
    var infoarray: [Information] = []
    var imagearray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.registerNib(UINib(nibName: "ShowCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryAmbient)
        try! audioSession.setActive(true)
    }
    
    override func viewWillAppear(animated: Bool) {

        collectionview.delegate = self
        collectionview.dataSource = self
        print("viewWillAppear 終わり")
        self.loadImages()

    }
    
    func loadImages() {
        let realm = try! Realm()
        let informations = realm.objects(Information)
        informations.map { $0 }.forEach { self.infoarray.append($0) }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // Backgroundで実行
            
            dispatch_async(dispatch_get_main_queue(), {
                // Main Threadで実行する
                for info in self.infoarray {
                    let imagePath = Path.documentsDir.content(info.images).asString
                    let changeimage = UIImage(contentsOfFile: imagePath)!
                    self.imagearray.append(UIImage(CGImage: changeimage.CGImage!, scale: 1.0, orientation: .Right))
                }
                self.collectionview.reloadData()
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ShowCollectionCell
        
        cell.imageView.image = imagearray[indexPath.row]
        //let angle:CGFloat = CGFloat((90.0 * M_PI) / 180.0)
        //cell.imageView.transform = CGAffineTransformMakeRotation(angle)
        cell.titileLabel.text = infoarray[indexPath.row].textmessages

        return cell
    }
    
    // セクションの数（今回は1つだけです）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 表示するセルの数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagearray.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        let recordPath = Path.documentsDir.content(infoarray[indexPath.row].recordmessages).asString
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(string: recordPath)!)
            audioPlayer!.play()
        } catch {
            print("再生時にerror出たよ(´・ω・｀)")
        }
        
    }
    
}
