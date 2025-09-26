//
//  CrpingVc.swift
//  Rock_ID
//
//  Created by Mac Mini on 22/04/2025.
//

import UIKit
import Lottie
import TOCropViewController

class CrpingVc: UIViewController {

    @IBOutlet weak var manualView: UIView!
    @IBOutlet weak var autoCropView: UIView!
    @IBOutlet weak var fetchImgView: UIImageView!
    @IBOutlet weak var loadingParentView: UIView!
    @IBOutlet weak var loadingSubView: UIView!
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var nativeAdPlaceholder: UIView!
    @IBOutlet weak var skeltonView: UIView!
    @IBOutlet weak var bannerAdViewHeight: NSLayoutConstraint!
    
    var iscomingFromLaunch = true
    
    var getImg : UIImage?
    var customCropImg: UIImage?
    var resultTextSt: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let img = getImg{
            fetchImgView.image = img
        }
        
        makeViewsClickable([manualView, autoCropView])
        LottieManager.playAnimation(on: loadingView, lottieName: Lotties_Constant.shared.wait)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        HelperFun.shared.viewsConerRadius(for: [manualView, autoCropView], radius: 25, borderColor: UIColor(hex: "#008080"), borderWidth: 1.0)
        HelperFun.shared.viewsConerRadius(for: [loadingSubView, fetchImgView], radius: 10, borderColor: UIColor(hex: "#008080"), borderWidth: 1.0)
        HelperFun.shared.adsCornerradius(for: [nativeAdPlaceholder, skeltonView], radius: 10.0)
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Reusable Function
    func makeViewsClickable(_ views: [UIView]) {
        for (index, view) in views.enumerated() {
            view.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap(_:)))
            tapGesture.view?.tag = index // Optional: you can also use this to identify the view
            view.addGestureRecognizer(tapGesture)
        }
    }
    // MARK: - Tap Handler
    @objc func handleViewTap(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        
        // You can identify the view here using tag or just check the instance
        switch tappedView {
        case manualView:
            print("manual")
            if let image = getImg {
                openCropper(with: image)
            }
        case autoCropView:
            print("auto")
            
            if let image = getImg {
                let preprocessedImage = HelperFun.shared.preprocessImage(image)
                print("fetched image: - ", preprocessedImage)
                self.customCropImg = preprocessedImage
                if let img = customCropImg{
                    generateResponse(with: img)
                }
            }
            
        default:
            break
        }
    }
    
}


//MARK: - MANUAL CROPER
extension CrpingVc: TOCropViewControllerDelegate{
    // Open the cropper with the selected image
    func openCropper(with image: UIImage) {
        let cropViewController = TOCropViewController(image: image)
        cropViewController.delegate = self
        present(cropViewController, animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true, completion: nil)
        
        // Save the cropped image and upload it
        self.customCropImg = image
        
        if let img = customCropImg{
            generateResponse(with: img)
        }
        autoCropView.isUserInteractionEnabled = false
    }
    

    
}

// MARK: - AI Data Parsing & Navigation
extension CrpingVc {
    
    func generateResponse(with image: UIImage?) {
        //view.showLoading()
        loadingParentView.isHidden = false
        
        // Cancel previous task and start new content generation
        AI_MODEL().task = Task {
            do {
                guard let image = image else {
                    throw NSError(domain: "Invalid Image", code: -1, userInfo: nil)
                }
                
                // Cancel check
                if Task.isCancelled { return }
                
                let result = try await AI_MODEL().model.generateContent(AI_MODEL().prefix, image)
                
                // Cancel check after response
                if Task.isCancelled { return }
                
                // UI updates and response handling
                await MainActor.run {
                    //self.view.hideLoading()
                    self.loadingParentView.isHidden = true
                    guard let text = result.text else {
                        print("No text found in result.")
                        return
                    }
                    
                    self.resultTextSt = text
                    self.parseText(text)
                   
                }
                
            } catch {
                await MainActor.run {
                    //self.view.hideLoading()
                    self.loadingParentView.isHidden = true
                    DispatchQueue.main.async {
                        self.noResulFoundVcNav()
                    }
                    
                    print("Error generating response: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - Parse AI Response Text
//    private func parseText(_ text: String) {
//        
//        let cleanedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
//        print("parsed Data:- ", cleanedText)
//        
//        if cleanedText == "Unidentified object" {
//            noResulFoundVcNav()
//            return
//        }
//        
//        if cleanedText.lowercased().contains("Unidentified object") {
//            noResulFoundVcNav()
//            return
//        }
//        if cleanedText.contains("Unidentified object"){
//            noResulFoundVcNav()
//            return
//        }
//
//        
//        parsedData.removeAll()
//        
//        let lines = cleanedText.components(separatedBy: "\n")
//        for line in lines {
//            if line.hasPrefix("-"), let range = line.range(of: ":") {
//                let keyString = line[line.index(after: line.startIndex)..<range.lowerBound].trimmingCharacters(in: .whitespaces)
//                let value = line[range.upperBound...].trimmingCharacters(in: .whitespaces)
//                
//                if let key = Int(keyString) {
//                    parsedData[key] = value
//                    print("Parsed [\(key)] = \(value)")
//                }
//            }
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//            self.navigateToResultVC()
//        })
//
//        
//       
//    }

    // 2. Parse text line by line
    private func parseText(_ text: String) {
        let cleanedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        print("parsed Data:- ", cleanedText)
        
        if cleanedText.lowercased().contains("unidentified object") {
            noResulFoundVcNav()
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigateToResultVC(cleaData: cleanedText)
        }
    }
    
    
    // MARK: - Navigate to ScanResultVC
    private func navigateToResultVC(cleaData: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultVC
        vc?.modalPresentationStyle = .fullScreen
        vc?.selectedImg = getImg
        vc?.finalStringData = cleaData
        present(vc!, animated: false)
        
    }
    
    // MARK: - Navigate to ScanResultVC
    private func noResulFoundVcNav() {
        print("no data found")
//        let vc = storyboard?.instantiateViewController(withIdentifier: "NoResultVC") as? NoResultVC
//        vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        vc?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        present(vc!, animated: false)
        
    }
    
}

