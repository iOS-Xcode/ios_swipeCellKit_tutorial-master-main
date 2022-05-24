//
//  MyTableViewCell.swift
//  dynamic_table_view
//
//  Created by Jeff Jeong on 2020/09/01.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    // 하트 버튼
    @IBOutlet var heartBtn: MyHeartBtn!
    
    // 따봉 버튼
    @IBOutlet var thumbsUpBtn: UIButton!
    
    // 공유 버튼
    @IBOutlet weak var shareBtn: UIButton!
    
    //버튼을 모두 담은 객체
    @IBOutlet var btns: [UIButton]!
    
    // 하트버튼이 클릭 되었을 때
    var heartBtnAction : ((Bool) -> Void)?
    
    // 피드 데이터
    /*
    var feedData: Feed? {
        didSet{
            print("MyTableViewCell - didSet / feedData: \(feedData)")
            
            if let data = feedData {
                // 피드 데이터에 따라 쎌의 UI 변경
//                heartBtn.tintColor = data.isFavorite ? #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) : .systemGray
                thumbsUpBtn.tintColor = data.isThumbsUp ? #colorLiteral(red: 0.1887893739, green: 0.3306484833, blue: 1, alpha: 1) : .systemGray
                contentLabel.text = data.content
            }
        }
    }
    */
    override func awakeFromNib() {
        print("MyTableViewCell - awakeFromNib() called")
        super.awakeFromNib()
        
//        userProfileImg.layer.cornerRadius = userProfileImg.frame.height / 2
//        btns.forEach{ $0.addTarget(self, action: #selector(onBtnClicked(_:)), for: .touchUpInside) }
    }
    
//    func updateUI(with data: Feed) {
//        print("MyTableViewCell - updateUI() called")
//        heartBtn.setState(data.isFavorite)
//        thumbsUpBtn.tintColor = data.isThumbsUp ? #colorLiteral(red: 0.1887893739, green: 0.3306484833, blue: 1, alpha: 1) : .systemGray
//        contentLabel.text = data.content
//    }
    
    @objc fileprivate func onBtnClicked(_ sender: UIButton) {
        print("MyTableViewCell - onBtnClicked() called")
        switch sender {
        case heartBtn:
            print("하트 버튼이 클릭되었다.")
            //클로저에 전달, viewContrller의 cell에서 확인
            heartBtnAction?(heartBtn.isActivivated)
        case thumbsUpBtn:
            print("따봉 버튼이 클릭되었다")
        case shareBtn:
            print("공유하기 버튼이 클릭되었다.")
        default:
            break
        }
    }
}
