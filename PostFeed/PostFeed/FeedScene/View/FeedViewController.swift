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
    var displayedData: [Post] = []
    
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
    
    private func setupUI() {
        title = "Posts"
        view.backgroundColor = .systemBackground
        self.tableView.estimatedRowHeight = 233.0
        tableView.delegate = nil
        tableView.rx.setDelegate(self)
            .disposed(by: bag)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    // MARK: - Flow funcs
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
        viewModel?.listData
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { index, element, cell in
                cell.selectionStyle = .none
                self.setupCustomViewIfNeeded(cell: cell, index: index, post: element)
            }
            .disposed(by: bag)
        
        viewModel?.listData
            .bind(onNext: { self.displayedData = $0 })
            .disposed(by: bag)
    }
    
    private func setupCustomViewIfNeeded(cell: UITableViewCell, index: Int, post: Post) {
        if cell.contentView.subviews.contains(where: { $0.tag == 999 }) == false {
             let customView = ResizeView()
            
            customView.tag = 999
            cell.contentView.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                customView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                customView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                customView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
            ])
            
            customView.onExpandDidTap { [weak self] in
                guard let self = self else { return }
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
            
            customView.configure(with: post)
            customView.layoutIfNeeded()
        }
    }
    
}

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}






