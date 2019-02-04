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
   
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var comentsCountLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: PostDetailsViewModel!
    
    func bindViewModel() {
        
        self.viewModel.screenName.bind { [weak self] name in
            self?.title = name
            }.disposed(by: disposeBag)
        
        self.viewModel.postDetails.subscribe { [weak self] event in
            guard let post = event.element else { return }
            self?.bodyLabel.attributedText = self?.atributedText(withTitle: L10n.body,
                                                                      content: post.body)
            self?.postTitleLabel.attributedText = self?.atributedText(withTitle: L10n.title,
                                                                         content: post.title)
        }.disposed(by: disposeBag)
        
        self.viewModel.commentsCount.subscribe { [weak self] event in
            guard let commentCount = event.element else { return }
            self?.comentsCountLabel.attributedText = self?.atributedText(withTitle: L10n.comments,
                                                                   content: "(\(commentCount))")
        }.disposed(by: disposeBag)
        
        self.viewModel.author.subscribe { [weak self] event in
            guard let author = event.element else { return }
            self?.authorLabel.attributedText = self?.atributedText(withTitle: L10n.author,
                                                                   content: author.name)
            }.disposed(by: disposeBag)
    }
    
    private func atributedText(withTitle title: String, content: String ) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(title): ",
                                                       attributes: [NSAttributedString.Key.font:
                                                        UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)])
        
        attributedText.append(NSAttributedString(string: "\(content)",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.labelFontSize)]))
        return attributedText
    }
    
}
