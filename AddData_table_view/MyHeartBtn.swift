//
//  MyHearBtn.swift
//  dynamic_table_view
//
//  Created by Seokhyun Kim on 2022-05-24.
//  Copyright © 2022 Tuentuenna. All rights reserved.
//

import UIKit

class MyHeartBtn: UIButton {
    
    var isActivivated : Bool = false
    
    let activatedImage = UIImage(systemName: "heart.fill")?.withTintColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)).withRenderingMode(.alwaysOriginal)
    let nomalImage = UIImage(systemName: "heart")?.withTintColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).withRenderingMode(.alwaysOriginal)
    
    //스토리 보드로 작성시 호출
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyHeartBtn - awakeFromNib() called")
        configureAction()
    }
    
    func setState(_ newValue: Bool) {
        print("MyHeartBtn - setState() called / newValue: \(newValue)")
        
        //1. 현재 버튼의 상태 변경
        self.isActivivated = newValue
        //2. 변경된 상태에 따른 이미지 변경
        self.setImage(self.isActivivated ? activatedImage : nomalImage, for: .normal)
        
    }
    
    fileprivate func configureAction() {
        self.addTarget(self, action: #selector(onBtnClicked(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func onBtnClicked(_ sender: UIButton) {
        self.isActivivated.toggle()
        //에니메이션 처리 하기
        animate()
    }
    fileprivate func animate() {
        print("MyHeartBtn - animate() called")
        //1.클릭 되었을 때 쪼그라 들기 - 스케일 즉 크기가 잠시 변경 50프로로 1초동안
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard let self = self else { return }
            let newImage = self.isActivivated ? self.activatedImage : self.nomalImage
            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5) //50%로 버튼크기 줄임
            self.setImage(newImage, for: .normal)
        }, completion: { _ in
            //2. 원래 크기로 돌리기 1초동안
            UIView.animate(withDuration: 0.1, animations: {
                //원래 있던 자기 크기로 간다.
                self.transform = CGAffineTransform.identity
            })
        })
    }
}
