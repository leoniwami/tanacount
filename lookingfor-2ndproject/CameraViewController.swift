import UIKit
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var cameraView : UIImageView!
    @IBOutlet var takepicture : UIButton!
    @IBOutlet var savepicture : UIButton!
    
    // file操作をするときに役立つNSFileManager
    // 録音したファイルをDocmentsディレクトリに保存しています。
    // 他にもtmpディレクトリやLibrary/Cachesディレクトリなんかがあるので、
    // 興味あればググってください
    let fileManager = NSFileManager()
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let fileName = "sample.caf"
    var monoURL: NSURL!
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var textforthing: UITextField!
    
    struct information {
        var images: UIImage?
        var textmessages: String?
        var recordmessages: NSURL?
    }
    
//    var mono: information!
//    var momo = information()
    var monoArray = [information]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAudioRecorder()
    }
    
    // カメラの撮影開始
    @IBAction func cameraStart(sender : AnyObject) {
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.Camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.presentViewController(cameraPicker, animated: true, completion: nil)
        }
    }
    
    //　撮影が完了した時に呼ばれる
    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cameraView.contentMode = .ScaleAspectFit
            cameraView.image = pickedImage
            
        }
        
        //閉じる処理
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // 写真を保存
    @IBAction func savePic(sender : AnyObject) {
        var mono1 = information()
        let image: UIImage? = cameraView.image
        print(image)
        
        if image != nil {
            // iphoneのアルバムに保存
            UIImageWriteToSavedPhotosAlbum(image!, self, #selector(CameraViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
            
            //
            mono1.images = cameraView.image!
        }
    
        mono1.textmessages = textforthing.text
        mono1.recordmessages = monoURL
        
        monoArray.append(mono1)
        print(monoArray)
    }
    
    // 書き込み完了結果の受け取り
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        print("書き込み完了結果の受け取り")
        
    }
    
    // アルバムを表示
    @IBAction func showAlbum(sender : AnyObject) {
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.presentViewController(cameraPicker, animated: true, completion: nil)
        }
    }
    
    // 録音ボタンを押した時の挙動
    @IBAction func pushRecordButton(sender: AnyObject) {
        audioRecorder?.record()
    }
    
    @IBAction func pushPauseButton(sender: AnyObject) {
        audioRecorder?.pause()
    }
    
    @IBAction func pushStopButton(sender: AnyObject) {
        audioRecorder?.stop()
    }
    
    // 再生ボタンを押した時の挙動
    @IBAction func pushPlayButton(sender: AnyObject) {
        self.play()
    }
    
    // 録音するために必要な設定を行う
    // viewDidLoad時に行う
    func setupAudioRecorder() {
        // 再生と録音機能をアクティブにする
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! session.setActive(true)
        let recordSetting : [String : AnyObject] = [
            AVEncoderAudioQualityKey : AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey : 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        do {
            try audioRecorder = AVAudioRecorder(URL: self.documentFilePath(), settings: recordSetting)
        } catch {
            print("初期設定でerror出たよ(-_-;)")
        }
    }
    // 再生
    func play() {
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: self.documentFilePath())
        } catch {
            print("再生時にerror出たよ(´・ω・｀)")
        }
        audioPlayer?.play()
        
    }
    // 録音するファイルのパスを取得(録音時、再生時に参照)
    // swift2からstringByAppendingPathComponentが使えなくなったので少し面倒
    func documentFilePath()-> NSURL {
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        let dirURL = urls[0]
        monoURL = dirURL
        return dirURL.URLByAppendingPathComponent(fileName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
