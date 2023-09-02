//
//  PostCell.swift
//  PostFeed
//
//  Created by Serhii Molodets on 31.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol IdentifiableCell {}

extension IdentifiableCell {
    static var identifier: String { String(describing: Self.self) }
}
final class ResizeViewCell: UITableViewCell, IdentifiableCell {
    
    private var isExpanded = false
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
        stack.distribution = .equalSpacing
        //        stack.spacing = .infinity
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let previewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
        self.setupUI()
        self.titleLabel.text = post.title
        self.previewLabel.text = post.previewText
        self.dateLabel.text = "\(daysAgo(from: post.timeshamp)) days ago"
        self.likesCountLabel.text = "\(post.likesCount)"
        self.previewLabel.numberOfLines = self.isExpanded ? 0 : 2
        self.expandButton.setTitle(self.isExpanded ? "Collapse" : "Expand", for: .normal)
        self.expandButton.isHidden = previewLabel.text?.count ?? 0 < 100
    }
    
    private func daysAgo(from timestamp: TimeInterval) -> Int {
        let date = Date(timeIntervalSince1970: timestamp)
        let currentDate = Date()
        let timeDifference = currentDate.timeIntervalSince(date)
        let daysAgo = Int(timeDifference / (60 * 60 * 24))
        return daysAgo
    }
    
    private func setupUI() {
        expandButton.addTarget(self, action: #selector(expandDidTap), for: .touchUpInside)
        likeImageView.image = UIImage(named: "heart")
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(previewLabel)
        containerStackView.addArrangedSubview(bottomStackView)
        likesStackView.addArrangedSubview(likeImageView)
        likesStackView.addArrangedSubview(likesCountLabel)
        bottomStackView.addArrangedSubview(likesStackView)
        bottomStackView.addArrangedSubview(dateLabel)
        containerStackView.addArrangedSubview(expandButton)
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).withPriority(.defaultHigh),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
    }
    
    func onExpandDidTap(_ handler: @escaping () -> Void) {
        self.expandDidTapHandler = handler
    }
    

    
    @objc
    func expandDidTap() {
        self.isExpanded.toggle()
        self.previewLabel.numberOfLines = self.isExpanded ? 0 : 2
        self.previewLabel.layoutIfNeeded()
        self.expandButton.setTitle(self.isExpanded ? "Collapse" : "Expand", for: .normal)
        self.expandDidTapHandler?()
    }
}

