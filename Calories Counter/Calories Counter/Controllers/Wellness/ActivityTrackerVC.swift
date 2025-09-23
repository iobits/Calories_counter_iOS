//
//  ActivityTrackerVC.swift
//  Calories Counter
//
//  Created by Mac Mini on 22/09/2025.
//

import UIKit
class ActivityCell: UITableViewCell{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileIMg: UIView!
    
}

class ActivityTrackerVC: UIViewController {
    
    @IBOutlet weak var scrollViews: UIScrollView!
    @IBOutlet weak var textParentView: UIView!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var activeView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    private let placeholderText = "Write your activity here..."
    private let placeholderColor: UIColor = .lightGray
    private let normalTextColor: UIColor = .black
    
    private let minHeight: CGFloat = 100   // ✅ Minimum height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        setupPlaceholder()
        
        textViewHeight.constant = minHeight
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.showsVerticalScrollIndicator = false
        tblView.isScrollEnabled = false
        tblView.separatorColor = .clear
        
        // ✅ contentSize observer
        tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        tblView.reloadData()
    }

    // ✅ KVO observer
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            tblViewHeight.constant = tblView.contentSize.height
        }
    }

    deinit {
        tblView.removeObserver(self, forKeyPath: "contentSize")
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textParentView.layer.cornerRadius = 15.0
        textParentView.layer.borderWidth = 1.0
        textParentView.layer.borderColor = UIColor.yellow.cgColor
        [activeView].viewsCornerRadius(25.0)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTableViewHeight()
    }
    
    func updateTableViewHeight() {
        tblView.layoutIfNeeded()
        tblViewHeight.constant = tblView.contentSize.height
    }

    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupPlaceholder() {
        textView.text = placeholderText
        textView.textColor = placeholderColor
    }
}

extension ActivityTrackerVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        // ✅ Height update but never less than 100
        textViewHeight.constant = max(minHeight, estimatedSize.height)
        view.layoutIfNeeded()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == placeholderColor {
            textView.text = ""
            textView.textColor = normalTextColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = placeholderColor
        }
    }
}

extension ActivityTrackerVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell") as! ActivityCell
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 15.0
        cell.profileIMg.layer.cornerRadius = 15.0
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalkingVC") as! WalkingVC
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(vc, animated: false)
    }
}
