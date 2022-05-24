//
//  ViewController.swift
//  dynamic_table_view
//
//  Created by Jeff Jeong on 2020/09/01.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import UIKit

let MY_TABLE_VIEW_CELL_ID = "myTableViewCell"

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var prependButton: UIBarButtonItem!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var appendButton: UIBarButtonItem!
    
    @IBAction func barButtonAction(_ sender: UIBarButtonItem) {
        print(#function, #line)
        switch sender {
        case prependButton:
            print("앞에추가")
            self.prependData()
        case resetButton:
            print("리셋")
            self.resetData()
        case appendButton:
            print("뒤에추가")
            self.appendData()
        default: break
        }
    }
    
    var appendingCount: Int = 0
    var prependingCount: Int = 0
    var prependingArray = ["1 앞에 추가","2 앞에 추가","3 앞에 추가","4 앞에 추가","5 앞에 추가"]
    var addingArray = ["1 뒤에 추가","2 뒤에 추가","3 뒤에 추가","4 뒤에 추가","5 뒤에 추가"]
    var tempArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController - viewDidLoad() called")
        
        // 쎌 리소스 파일 가져오기
        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
        
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: MY_TABLE_VIEW_CELL_ID)
        
        self.myTableView.rowHeight = UITableView.automaticDimension
        
        self.myTableView.estimatedRowHeight = 120
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
    }

}

//MARK: - 테이블뷰 관련 메서드
extension ViewController {
    fileprivate func prependData() {
        print(#fileID, #function, #line)
        
        prependingCount = prependingCount + 1
        let tempPrependingArray = prependingArray.map{ $0.appending(String(prependingCount)) }
        self.tempArray.insert(contentsOf: tempPrependingArray, at: 0)
        //self.myTableView.reloadData()
        self.myTableView.reloadDataAndKeepOffset()
    }
    fileprivate func appendData() {
        print(#fileID, #function, #line)
        appendingCount = appendingCount + 1

        let tempAddingArray = addingArray.map{ $0.appending(String(appendingCount)) }

        self.tempArray += tempAddingArray
        self.myTableView.reloadData()

    }
    fileprivate func resetData() {
        print(#fileID, #function, #line)
        appendingCount = 0
        prependingCount = 0
        tempArray = []
        self.myTableView.reloadData()
    }
}
extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tempArray.count
    }

    // 쎌에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = myTableView.dequeueReusableCell(withIdentifier: MY_TABLE_VIEW_CELL_ID, for: indexPath) as! MyTableViewCell
        cell.contentLabel.text = tempArray[indexPath.row]

        return cell
    }

}
//테이블뷰 으로 옵셋 유지하는 메서드 만들기
//뒤에 추가 후 앞의 추가할 때 앞의 추가화면의 마지막 셀이 보이 도록 한다.
extension UITableView {
    //Offset 떨어짐
    func reloadDataAndKeepOffset() {
        //스코롤링 멈추기
        setContentOffset(contentOffset, animated: false)
        
        //데이타 추가전 컨텐츠 사이즈
        let beforeContentSize = contentSize
        reloadData()
        //랜더링 다시
        layoutIfNeeded()
        //데이터 추가후 컨텐츠 사이즈
        let afterContentSize = contentSize
        //데이타가 변경되고 리로드 되고 나서 컨텐트 옵셋 계산 및 설정
        let calculateNewOffset = CGPoint(
            x: contentOffset.x + (afterContentSize.width - beforeContentSize.width),
            y: contentOffset.y + (afterContentSize.height - beforeContentSize.height)
        )
        //변경된 옵셋 설정
        setContentOffset(calculateNewOffset, animated: false)
        
    }
}
