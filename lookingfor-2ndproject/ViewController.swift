//import UIKit
//
//class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    
//    @IBOutlet var cameraView : UIImageView!
//    @IBOutlet var takepicture : UIButton!
//    @IBOutlet var savepicture : UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    // カメラの撮影開始
//    @IBAction func cameraStart(sender : AnyObject) {
//        
//        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.Camera
//        // カメラが利用可能かチェック
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
//            // インスタンスの作成
//            let cameraPicker = UIImagePickerController()
//            cameraPicker.sourceType = sourceType
//            cameraPicker.delegate = self
//            self.presentViewController(cameraPicker, animated: true, completion: nil)
//            
//        }
//    }
//    
//    //　撮影が完了時した時に呼ばれる
//    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            cameraView.contentMode = .ScaleAspectFit
//            cameraView.image = pickedImage
//            
//        }
//        
//        //閉じる処理
//        imagePicker.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    // 撮影がキャンセルされた時に呼ばれる
//    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        picker.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    
//    // 写真を保存
//    @IBAction func savePic(sender : AnyObject) {
//        let image:UIImage! = cameraView.image
//        
//        if image != nil {
//            UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
//        }
//    }
//    
//    // 書き込み完了結果の受け取り
//    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
//        print("1")
//        if error != nil {
//            print(error.code)
//            label.text = "Save Failed !"
//        }
//        else{
//            label.text = "Save Succeeded"
//        }
//    }
//    
//    // アルバムを表示
//    @IBAction func showAlbum(sender : AnyObject) {
//        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
//            // インスタンスの作成
//            let cameraPicker = UIImagePickerController()
//            cameraPicker.sourceType = sourceType
//            cameraPicker.delegate = self
//            self.presentViewController(cameraPicker, animated: true, completion: nil)
//            label.text = "Tap the [Start] to save a picture"
//        }
//        else{
//            label.text = "error"
//        }
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}