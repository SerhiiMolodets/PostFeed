//
//  PostCell.swift
//  PostFeed
//
//  Created by Serhii Molodets on 31.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ResizeView: UIView {
    
    private var isCollapsed = true
    private var expandDidTapHandler: (() -> Void)?
    private let bag = DisposeBag()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let likesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = .infinity
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let previewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private let expandButton: UIButton = {
        let button = UIButton()
        button.setTitle("Expand", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return button
    }()
    
    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(with post: Post) {
        self.behavioralBinding()
        self.setupUI()
        self.titleLabel.text = post.title
        self.previewLabel.text = post.previewText
        self.dateLabel.text = "\(post.timeshamp)"
        self.likesCountLabel.text = "\(post.likesCount)"
        self.isCollapsed = post.isCollapsed ?? false
        self.previewLabel.numberOfLines = self.isCollapsed ? 0 : 2
        self.expandButton.setTitle(self.isCollapsed ? "Collapse" : "Expand", for: .normal)
    }
    
    private func behavioralBinding() {
        expandButton.rx
            .tap
            .subscribe { [weak self]_ in
                guard let self else { return }
                self.isCollapsed.toggle()
                self.previewLabel.numberOfLines = self.isCollapsed ? 0 : 2
                self.previewLabel.layoutIfNeeded()
                self.expandButton.setTitle(self.isCollapsed ? "Collapse" : "Expand", for: .normal)
                self.expandDidTapHandler?()
            }.disposed(by: bag)
    }
    
    private func setupUI() {
        likeImageView.image = UIImage(named: "heart")
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(previewLabel)
        containerStackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(likesStackView)
        likesStackView.addArrangedSubview(likeImageView)
        likesStackView.addArrangedSubview(likesCountLabel)
        containerStackView.addArrangedSubview(expandButton)
        setupConstraints()
 
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            
//            titleLabel.heightAnchor.constraint(equalToConstant: 34).withPriority(.defaultLow)
            //            titleLabel.heightAnchor.constraint(equalToConstant: 34).withPriority(.defaultLow)
 
            
        ])

    }
    
    func onExpandDidTap(_ handler: @escaping () -> Void) {
        self.expandDidTapHandler = handler
    }
    
}

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
