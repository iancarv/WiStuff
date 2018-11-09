//
//  MediaCell.swift
//  WiFinder
//
//  Created by Ian Carvalho on 08/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MediaCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel?
    
    @IBOutlet weak var titleLabel: UILabel?
    
    let disposeBag = DisposeBag()
    
    
    func configure(model: MediaItem) {
        configureProperties(model: model)
        configureTapImage()
    }
    
    private func configureProperties(model: MediaItem) {
        let pictureURL = URL(string: model.artworkUrl)!
        imageView?.sd_cancelCurrentImageLoad()
        imageView?.contentMode = .scaleAspectFit
        imageView?.sd_setImage(with: pictureURL, placeholderImage: #imageLiteral(resourceName: "Placeholder"))
        titleLabel?.text = model.name
        descriptionLabel?.text = model.description
    }
    
    private func configureTapImage() {
        let tapGesture = UITapGestureRecognizer()
        imageView?.addGestureRecognizer(tapGesture)
        imageView?.isUserInteractionEnabled = true
        tapGesture.rx.event.bind(onNext: { [unowned self] recognizer in
            if let imageView = self.imageView {
                let origin:CGPoint = imageView.center
                let target:CGPoint = CGPoint(x: imageView.center.x, y: imageView.center.y-10)
                let bounce = CABasicAnimation(keyPath: "position.y")
                bounce.duration = 0.2
                bounce.fromValue = origin.y
                bounce.toValue = target.y
                bounce.repeatCount = 2
                bounce.autoreverses = true
                imageView.layer.add(bounce, forKey: "position")
            }
        }).disposed(by: disposeBag)
    }
}
