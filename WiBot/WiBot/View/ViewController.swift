//
//  ViewController.swift
//  WiBot
//
//  Created by Ian Carvalho on 08/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import PhotosUI


class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .clear
        }
    }
    
    let disposeBag = DisposeBag()
    let viewModel = ChatBotViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [unowned self] keyboardVisibleHeight in
                self.bottomConstraint.constant = -keyboardVisibleHeight
            })
            .disposed(by: disposeBag)
        
            
        viewModel.dataDidChange
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        let textFieldEmpty = textView.rx.text.orEmpty.map({$0.isEmpty})
        
        textFieldEmpty
            .asObservable()
            .subscribe(onNext: { [unowned self] empty in
                if empty {
                    self.button.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
                    self.button.setTitle(nil, for: .normal)
                } else {
                    self.button.setImage(nil, for: .normal)
                    self.button.setTitle("Send", for: .normal)
                }
        })
        .disposed(by: disposeBag)

        button.rx.tap.filter(if: textFieldEmpty)
            .subscribe(onNext: { [unowned self] _ in
                self.askImage()
            })
            .disposed(by: disposeBag)
        
        button.rx.tap.filter(if: textFieldEmpty.map { !$0 } )
            .subscribe(onNext: { [unowned self] _ in
                self.sendText()
            })
            .disposed(by: disposeBag)
    }
    
    func sendText() {
        viewModel.userDidText(text: textView.text)
        textView.text = nil
        textView.resignFirstResponder()
    }
    
    func sendImage(img: UIImage?) {
        viewModel.userDidSubmitImage(img: img)
    }
    
    func askImage() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = false
        vc.delegate = self
        present(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        sendImage(img: img)
        picker.dismiss(animated: true, completion: nil)
    }
}
