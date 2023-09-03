//
//  DetailViewController.swift
//  PostFeed
//
//  Created by Serhii Molodets on 03.09.2023.
//

import UIKit
import SDWebImage

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: ViewModelProtocol?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .left
        return label
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
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Flow funcs
    
    private func setupUI() {
        title = "Post"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        postImageView.sd_setImage(with: URL(string: viewModel?.detailData?.postImage ?? ""))
        titleLabel.text = viewModel?.detailData?.title
        postLabel.text = viewModel?.detailData?.text
//        contentView.layoutIfNeeded()
        likeImageView.image = UIImage(named: "heart")
        likesCountLabel.text = "\(viewModel?.detailData?.likesCount ?? 0)"
        dateLabel.text = "\(viewModel?.detailData?.timeshamp.daysAgo() ?? 0) days ago"
        

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(postLabel)
        contentView.addSubview(bottomStackView)

        scrollView.addSubview(contentView)
        
        likesStackView.addArrangedSubview(likeImageView)
        likesStackView.addArrangedSubview(likesCountLabel)
        bottomStackView.addArrangedSubview(likesStackView)
        bottomStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
                 // Constrain the scrollView to the view edges
                 scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                 scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                 scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                 
                 // Constrain the contentView to the scrollView edges
                 contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                 contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                 contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                 contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                 contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                 contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),// Match width to scrollView
                 
                 // Add constraints for your subviews within the contentView
                 postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                 postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                 postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                 postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: 1),
                 
                 titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
                 titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  16),
                 titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                 
                 postLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                 postLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  16),
                 postLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                 
                 bottomStackView.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: 16),
                 bottomStackView.leadingAnchor.constraint(equalTo: postLabel.leadingAnchor),
                 bottomStackView.trailingAnchor.constraint(equalTo: postLabel.trailingAnchor),
                 bottomStackView.heightAnchor.constraint(equalToConstant: 22)
             ])

    }
    
}
