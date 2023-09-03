//
//  ViewController.swift
//  PostFeed
//
//  Created by Serhii Molodets on 30.08.2023.
//

import UIKit
import RxSwift

class FeedViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: ViewModelProtocol?
    var bag = DisposeBag()
    
    // MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindDataToTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Flow funcs
    private func setupUI() {
        title = "Posts"
        view.backgroundColor = .systemBackground
        self.tableView.estimatedRowHeight = 233
        tableView.delegate = nil
        tableView.rx.setDelegate(self)
            .disposed(by: bag)
        tableView.register(ResizeViewCell.self, forCellReuseIdentifier: ResizeViewCell.identifier)


        let dateSorting = UIAction(title: "Date") { [weak self] (action) in
            var updatedData = self?.viewModel?.listData.value ?? []
            updatedData.sort { $0.timeshamp > $1.timeshamp }
            self?.viewModel?.listData.accept(updatedData)
        }
        
        let likesSorting = UIAction(title: "Likes") { [weak self] (action) in
            var updatedData = self?.viewModel?.listData.value ?? []
            updatedData.sort { $0.likesCount > $1.likesCount }
            self?.viewModel?.listData.accept(updatedData)
        }
        let menu = UIMenu(title: "Sort by", options: .displayInline, children: [dateSorting , likesSorting])
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "sort"), menu: menu)
        navigationItem.rightBarButtonItem = barButtonItem
        
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    private func bindDataToTableView() {
        guard let viewModel else { return }
        viewModel.listData
            .bind(to: tableView.rx.items(cellIdentifier: ResizeViewCell.identifier, cellType: ResizeViewCell.self)) { index, element, cell in
                cell.selectionStyle = .none
                cell.configure(with: element)
                cell.layoutIfNeeded()
                cell.onExpandDidTap {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
            }
            .disposed(by: bag)
        tableView.rx.modelSelected(Post.self)
            .map { $0.postId }
            .bind(to: viewModel.openDetail)
            .disposed(by: bag)
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}






