//
//  CamVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 22/09/2025.
//

import UIKit
import AVFoundation

class CamVC: UIViewController {
    
    @IBOutlet weak var camView: UIView!
    @IBOutlet weak var camLottieView: UIView!
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var photoOutput: AVCapturePhotoOutput!
    var movieOutput: AVCaptureMovieFileOutput!
    var currentDevice: AVCaptureDevice?
    var isTorchOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        LottieManager.playAnimation(on: camLottieView, lottieName: Lotties_Constant.shared.photoCam)
    }
    
    //MARK: - BUTTON ACTIONS
    @IBAction func allBtnActions(_ sender: UIButton) {
        if sender.tag == 0 {
            print("close")
            dismiss(animated: true, completion: nil)
        } else if sender.tag == 1 {
            print("flash")
            toggleTorch()
        } else if sender.tag == 2 {
            print("galary")
            openGallery()
        } else if sender.tag == 3 {
            print("cam")
            
            // Disable interaction for 3 seconds
            sender.isUserInteractionEnabled = false
            
            // Capture photo
            capturePhoto()
            
            // Re-enable after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                sender.isUserInteractionEnabled = true
            }
            
        } else if sender.tag == 4 {
            print("snap tips")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BeforMovingVC") as! BeforMovingVC
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(vc, animated: false)
            
        }
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = isTorchOn ? .on : .off
        settings.isHighResolutionPhotoEnabled = true // ✅ High quality capture
        
        if #available(iOS 13.0, *) {
            settings.photoQualityPrioritization = .quality // ✅ Better JPEG clarity
        }
        
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func toggleTorch() {
        guard let device = currentDevice, device.hasTorch else {
            print("Torch not available")
            return
        }
        
        do {
            try device.lockForConfiguration()
            
            if isTorchOn {
                device.torchMode = .off
                isTorchOn = false
                print("Flash OFF")
            } else {
                try device.setTorchModeOn(level: 1.0)
                isTorchOn = true
                print("Flash ON")
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Torch could not be used: \(error.localizedDescription)")
        }
    }
    
    func setupCamera() {
        captureSession.sessionPreset = .photo // ✅ High-quality preset
        
        // Check if rear camera is available
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Rear camera not available")
            showToast(message: "Rear camera is not available.")
            return
        }
        
        currentDevice = device
        
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            print("Failed to create input for the camera")
            return
        }
        
        photoOutput = AVCapturePhotoOutput()
        photoOutput.isHighResolutionCaptureEnabled = true // ✅ Important for clear image
        
        if captureSession.canAddInput(input) && captureSession.canAddOutput(photoOutput) {
            captureSession.addInput(input)
            captureSession.addOutput(photoOutput)
        } else {
            print("Cannot add input/output to the session")
            return
        }
        
        // Prioritize image quality
        if #available(iOS 13.0, *) {
            photoOutput.maxPhotoQualityPrioritization = .quality
        }
        
        movieOutput = AVCaptureMovieFileOutput()
        if captureSession.canAddOutput(movieOutput) {
            captureSession.addOutput(movieOutput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        
        DispatchQueue.main.async {
            self.camView.layer.addSublayer(self.previewLayer)
            self.previewLayer.frame = self.camView.bounds
        }
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
        
        if device.hasTorch {
            print("Torch is available on this device")
        } else {
            print("Torch is NOT available on this device")
        }
    }
    
    func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false // Disable editing
        present(imagePicker, animated: true, completion: nil)
    }
}


extension CamVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            print("Failed to convert photo to image")
            return
        }
        
        print("📸 Photo Captured Successfully")
        sentimgToNextVC(img: image)  // ✅ Ab captured image bhi next VC me jayegi
    }
}


extension CamVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            print("Image Selected")
            sentimgToNextVC(img: selectedImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func sentimgToNextVC(img: UIImage){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CrpingVc") as! CrpingVc
        vc.modalPresentationStyle = .fullScreen
        vc.getImg = img
        present(vc, animated: false)
    }
}
