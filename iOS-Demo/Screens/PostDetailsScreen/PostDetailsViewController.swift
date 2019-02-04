//
//  PostDetailsViewController.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostDetailsViewController: UIViewController, MVVMView {
   
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var comentsCountLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    var viewModel: PostDetailsViewModel!
    
    func bindViewModel() {
        
        self.viewModel.screenName.bind { [weak self] name in
            self?.title = name
            }.disposed(by: disposeBag)
        
        self.viewModel.post.subscribe { [weak self] event in
            guard let post = event.element else { return }
            self?.postTitleLabel.text = post.title
            self?.bodyLabel.text = post.body
        }.disposed(by: disposeBag)
        
        self.viewModel.commentsCount.subscribe { [weak self] event in
            guard let commentCount = event.element else { return }
            self?.comentsCountLabel.text = "\(commentCount)"
        }.disposed(by: disposeBag)
        
        self.viewModel.author.subscribe { [weak self] event in
            guard let author = event.element else { return }
            self?.authorLabel.text = author.name
            }.disposed(by: disposeBag)
    }
}
