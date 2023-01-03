//
//  ViewController.swift
//
//

import UIKit

class ViewController: UIViewController,DCEFrameListener{
    
    var photoButton:UIButton! = UIButton()
    var imageView:UIImageView!
    var isview:Bool = false
    
    
    var dce:DynamsoftCameraEnhancer! = nil
    var dceView:DCECameraView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationDCE()
        configurationUI()
    }
    
    func configurationDCE() {
        dceView = DCECameraView.init(frame: self.view.bounds)
        self.view.addSubview(dceView)
        dce = DynamsoftCameraEnhancer.init(view: dceView)
        dce.open()
        dce.addListener(self)
    }
    
    func configurationUI() {
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        let safeAreaBottomHeight:CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 34 : 0
        photoButton = UIButton(frame: CGRect(x:w / 2 - 60, y: h - 170 - safeAreaBottomHeight, width: 120, height: 120))
        photoButton.adjustsImageWhenDisabled = false
        photoButton.setImage(UIImage(named: "icon_capture"), for: .normal)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        photoButton.addTarget(self, action: #selector(takePictures), for: .touchUpInside)
        DispatchQueue.main.async {
            self.view.addSubview(self.photoButton)
        }
    }
    
    @objc func takePictures() {
        isview  = true
    }
    
    func frameOutPutCallback(_ frame: DCEFrame, timeStamp: TimeInterval) {
        if isview {
            isview = false
            DispatchQueue.main.async {
                self.photoButton?.isEnabled = false
                var image:UIImage!
                image = frame.toUIImage()
                image = UIImage.init(cgImage: image.cgImage!, scale: 1.0, orientation: UIImageOrientation.right)
                self.imageView.image = image
                self.view.addSubview(self.imageView)
                self.addBack()
            }
        }
    }
    
    func addBack(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .reply, target: self, action: #selector(backToHome))
    }
    
    @objc func backToHome(){
        self.imageView.removeFromSuperview()
        self.photoButton?.isEnabled = true
        self.navigationItem.leftBarButtonItem = nil
    }

}

