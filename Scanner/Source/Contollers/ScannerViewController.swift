//
//  ScannerViewController.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/25/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var qrCodeFrameView: UIView?
    private var mainViewController: ViewController?
    private var mainViewModel: TableViewModelType?
    private var realm = try! Realm()
    private var items: Results<VegetableElement>!
    var capturedId: Int?
    
    @IBOutlet private var scannerCodeView: UIView?
    @IBOutlet private var codeLabel: UILabel! {
        didSet {
            codeLabel.textColor = .cyan
            codeLabel.font = codeLabel.font.withSize(20)
            
        }
    }
    
    @IBOutlet private var infoLabel: UILabel! {
        didSet {
            infoLabel.textColor = .cyan
            infoLabel.font = infoLabel.font.withSize(20)
            infoLabel.text = "Press this to save"
        }
    }
    
    @IBOutlet private var captureCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = realm.objects(VegetableElement.self)
        mainViewModel = MainViewModel()
        captureSession = AVCaptureSession()
        initializationDevice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    private func initializationDevice() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metaDataOutput)) {
            captureSession.addOutput(metaDataOutput)
            
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        view.bringSubviewToFront(codeLabel)
        view.bringSubviewToFront(infoLabel)
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.red.cgColor
            qrCodeFrameView.layer.borderWidth = 3
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
        
    }
    
    private func failed() {
        let failedAlertController = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        failedAlertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(failedAlertController, animated: true)
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.isEmpty {
            qrCodeFrameView?.frame = CGRect.zero
            infoLabel.text = "Code is not detected"
            captureCodeButton.isEnabled = false
            infoLabel.textColor = .red
            infoLabel.font = infoLabel.font.withSize(16)
            return
        }
        
        if let metadataObject = metadataObjects.first {
            
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let barCodeObject = previewLayer.transformedMetadataObject(for: readableObject) else { return }
            
            qrCodeFrameView?.frame = barCodeObject.bounds
            let stringValue = readableObject.stringValue
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate.leadingZeroBitCount))
            found(code: stringValue ?? "")
        }
    }
    
    private func found(code: String) {
        codeLabel.text = code
        infoLabel.text = "Press this to save"
        captureCodeButton.isEnabled = true
        infoLabel.textColor = .cyan
        print(code)
    }
    
    @IBAction func didCaptureCode(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
        items.forEach({
            if $0.vegetableID == capturedId {
                let realm = try! Realm()
                let editingItem = $0
                try! realm.write {
                    editingItem.code = codeLabel.text ?? ""
                    realm.add(editingItem)
                }
            }
        })
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
