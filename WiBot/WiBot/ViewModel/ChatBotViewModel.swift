//
//  ChatBotViewModel.swift
//  WiBot
//
//  Created by Ian Carvalho on 09/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa

typealias TableViewModel = SectionModel<String, Message>

class ChatBotViewModel {
    let dataSource: RxTableViewSectionedReloadDataSource<TableViewModel>
    let data = BehaviorRelay<[Message]>(value: [])
    let dataDidChange: Observable<[TableViewModel]>
    
    init() {
        dataSource = RxTableViewSectionedReloadDataSource<TableViewModel>(configureCell: { dataSource, tableView, indexPath, item in
            var cellIdentifier = "cell"
            switch item.type {
            case let .TextMessage(text):
                cellIdentifier = TextCell.cellIdentifier
                if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TextCell {
                    cell.textLabel?.text = text
                    cell.owner = item.owner
                    return cell
                }
            case let .ImgMessage(img):
                cellIdentifier = ImageCell.cellIdentifier
                if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ImageCell {
                    cell.imageView?.image = img
                    cell.owner = item.owner
                    return cell
                }
            }
            return UITableViewCell()
        })
        
        dataDidChange = data.asObservable().flatMap{ objects -> Observable<[TableViewModel]> in
                print(objects)
                return Observable.just([SectionModel(model: "", items: objects)])
        }
    }
    
    func userDidText(text: String) {
        newTextMessage(text: text, owner: .User)
        self.createBotMessage(text: text)
    }
    
    func userDidSubmitImage(img: UIImage?) {
        if let img = img {
            newImgMessage(img: img, owner: .User)
            createImgMessage()
        }
    }
    
    func createBotMessage(text: String) {
        let botMessage = "I am a very intelligent chat bot.\n I can understand you said \"\(text)\"\nRight?"
        newTextMessage(text: botMessage, owner: .Bot)
    }
    
    func createImgMessage() {
        let emojis = ["❤️", "💩", "😆", "😏"]
        if let img = emojis.randomItem()?.image() {
            newImgMessage(img: img, owner: .Bot)
        }
    }
    
    func newTextMessage(text: String, owner: MessageOwner) {
        newMessage(type: .TextMessage(text: text), owner: owner)
    }
    
    func newImgMessage(img: UIImage, owner: MessageOwner) {
        newMessage(type: .ImgMessage(img: img), owner: owner)
    }
    
    func newMessage(type: MessageType, owner: MessageOwner) {
        let message = Message(type: type, owner: owner)
        addMessage(message: message)
    }
    
    func addMessage(message: Message) {
        data.accept(data.value + [message])
    }
    
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
