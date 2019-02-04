//
//  PostsViewController.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class PostsViewController: UIViewController, MVVMView {

    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    var viewModel: PostsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadPosts()
    }
    
    func bindViewModel() {
        self.viewModel.screenName.bind { [weak self] name in
            self?.title = name
        }.disposed(by: disposeBag)
        
        self.viewModel.loading.subscribe(onNext: { isLoading in
            if isLoading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }).disposed(by: disposeBag)
        
        self.tableView.registerCell(type: PostTableViewCell.self)
        viewModel.allPosts.bind(to:
            tableView
                .rx
                .items(cellIdentifier: PostTableViewCell.nibIdentifier,
                               cellType: PostTableViewCell.self)) { (_, post: Post, cell: PostTableViewCell) in
                                
                                cell.setPost(post)
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
               
                self?.viewModel.showPost(at: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
    
    func loadPosts() {
        self.viewModel.loadPosts().subscribe(onError: { [weak self]  error in
            let alertController = UIAlertController(title: L10n.error,
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
            alertController.addAction(
                UIAlertAction.init(title: L10n.retry,
                                   style: .default,
                                   handler: { _ in
                    self?.loadPosts()
            }))
            
            self?.present(alertController, animated: true)
            
        }).disposed(by: disposeBag)
    }
}
