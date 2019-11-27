//
//  ScannerViewController.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/25/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView: UIView?
    
    @IBOutlet var scannerCodeView: UIView?
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var captureCodeButton: UIButton!
    
    
    private var mainViewModel: TableViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewModel = MainViewModel()
        view.backgroundColor = .black
        captureSession = AVCaptureSession()
        initializationDevice()
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
        
        view.bringSubviewToFront(infoLabel)
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.red.cgColor
            qrCodeFrameView.layer.borderWidth = 3
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
        
    }
    
    func failed() {
        let failedAlertController = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        failedAlertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(failedAlertController, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.isEmpty {
            qrCodeFrameView?.frame = CGRect.zero
            infoLabel.text = "Code is not detected"
            infoLabel.textColor = .white
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
    
    func found(code: String) {
        infoLabel.text = code
        print(code)
    }
    
    @IBAction func didCaptureCode(_ sender: UIButton) {
        print("hgfhgvkhbjhb")
        
        
        infoLabel.textColor = .green
        infoLabel.font = infoLabel.font.withSize(20)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
