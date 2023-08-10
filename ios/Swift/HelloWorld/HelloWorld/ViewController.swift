//
//  ViewController.swift
//  HelloWorld
//
//  Created by Dynamsoft on 2023/7/25.
//

import UIKit
import DynamsoftCameraEnhancer

class ViewController: UIViewController, VideoFrameListener {

    var cameraView:CameraView!
    let dce:CameraEnhancer = .init()
    var isClicked = false
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dce.open()
    }

    func setUpCamera() {
        cameraView = .init(frame: view.bounds)
        cameraView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(cameraView, at: 0)
        dce.cameraView = cameraView
        dce.addListener(self)
    }
    
    func onFrameOutPut(_ frame: ImageData) {
        if isClicked {
            isClicked = false
            DispatchQueue.main.async { [self] in
                button.isEnabled = false
                imageView.image = try? frame.toUIImage()
                imageView.isHidden = false
                addBack()
            }
        }
    }
    
    func addBack(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .reply, target: self, action: #selector(touchBarItem))
    }
    
    @objc func touchBarItem(){
        imageView.isHidden = true
        button.isEnabled = true
        self.navigationItem.leftBarButtonItem = nil
    }
    
    @IBAction func touchEvent(_ sender: Any) {
        isClicked = true
    }
    
}

