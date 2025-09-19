//
//  BottomCardView.swift
//  Calories Counter
//
//  Created by Mac Mini on 18/09/2025.
//


import UIKit

class BottomCardView: UIView {
    
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let primaryButton = UIButton(type: .system)
    private let secondaryButton = UIButton(type: .system)
    
    private var primaryActionHandler: (() -> Void)?
    private var secondaryActionHandler: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.4) // backdrop
        
        // container
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        // image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        
        // title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        // subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        // primary button
        primaryButton.backgroundColor = .black
        primaryButton.setTitleColor(.white, for: .normal)
        primaryButton.layer.cornerRadius = 25
        primaryButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        // secondary button
        secondaryButton.backgroundColor = UIColor.systemGray6
        secondaryButton.setTitleColor(.black, for: .normal)
        secondaryButton.layer.cornerRadius = 25
        secondaryButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // stack
        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, subtitleLabel, primaryButton, secondaryButton])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    // MARK: - Public API
    func configure(image: UIImage?, title: String, subtitle: String,
                   primaryText: String, secondaryText: String?,
                   primaryAction: @escaping () -> Void,
                   secondaryAction: (() -> Void)? = nil) {
        
        imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
        primaryButton.setTitle(primaryText, for: .normal)
        secondaryButton.setTitle(secondaryText, for: .normal)
        
        self.primaryActionHandler = primaryAction
        self.secondaryActionHandler = secondaryAction
        
        primaryButton.addTarget(self, action: #selector(primaryTapped), for: .touchUpInside)
        
        if secondaryAction != nil {
            secondaryButton.isHidden = false
            secondaryButton.addTarget(self, action: #selector(secondaryTapped), for: .touchUpInside)
        } else {
            secondaryButton.isHidden = true
        }
    }
    
    @objc private func primaryTapped() {
        primaryActionHandler?()
    }
    @objc private func secondaryTapped() {
        secondaryActionHandler?()
    }
    
    // Show / Hide animation
    func present(in parent: UIView) {
        frame = parent.bounds
        alpha = 0
        parent.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
