//
//  CircularTimerView.swift
//  Calories Counter
//
//  Created by Mac Mini on 18/09/2025.
//


import UIKit

class CircularTimerView: UIView {
    
    private let backgroundLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let timeLabel = UILabel()
    
    private var timer: Timer?
    private var totalSeconds: Int = 60
    private var elapsedSeconds: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        // Background circle
        backgroundLayer.strokeColor = UIColor.systemGreen.withAlphaComponent(0.3).cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = 20
        layer.addSublayer(backgroundLayer)
        
        // Progress circle
        progressLayer.strokeColor = UIColor.systemGreen.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 20
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
        
        // Time label
        timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 22, weight: .medium)
        timeLabel.textAlignment = .center
        timeLabel.text = "00:00:00"
        addSubview(timeLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        timeLabel.frame = bounds
        
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - 10
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + CGFloat.pi * 2
        let path = UIBezierPath(arcCenter: centerPoint, radius: radius,
                                startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        backgroundLayer.path = path.cgPath
        backgroundLayer.frame = bounds
        progressLayer.path = path.cgPath
        progressLayer.frame = bounds
    }
    
    // MARK: - Public Functions
    
    func startTimer(totalSeconds: Int) {
        self.totalSeconds = totalSeconds
        self.elapsedSeconds = 0
        self.progressLayer.strokeEnd = 0
        updateLabel()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateTimer() {
        guard elapsedSeconds < totalSeconds else {
            stopTimer()
            return
        }
        elapsedSeconds += 1
        let progress = CGFloat(elapsedSeconds) / CGFloat(totalSeconds)
        progressLayer.strokeEnd = progress
        updateLabel()
    }
    
    private func updateLabel() {
        let hrs = elapsedSeconds / 3600
        let mins = (elapsedSeconds % 3600) / 60
        let secs = elapsedSeconds % 60
        timeLabel.text = String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
}
