//
//  ViewController.swift
//  Fnit-Calculator
//
//  Created by NOWALL on 2016/11/06.
//  Copyright © 2016年 NOWALL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var harfResultLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var leftOperand:String? = ""
    var rightOperand:String? = ""
    var centerOperator:String = ""
    var is_end:Bool = false
    
    /* 演算子が押されたときの処理 */
    @IBAction func tappedOperator(_ sender: UIButton) {
        
        // 左辺の値がまだ確定していなかったら、
        if leftOperand! == "" {
            // 左辺の値を確定し、
            leftOperand = resultLabel.text!
            // 次の値を受け付ける
            rightOperand = ""

            resultLabel.text = ""
        }
        // すでに確定している場合で、operatorもsetしてあったら
        else if (centerOperator != "") {
            /*
            print("do calc")
            // ラベルに表示されている値を右辺として変数に代入
            rightOperand = resultLabel.text

            // 計算させる関数
            calculate()
            
            // calculate()を実行した結果がresultLabelに表示されるので、それをさらにleftOperandに登録して,後に演算子を登録
            leftOperand = resultLabel.text
            
            // 数値の受付
            resultLabel.text = ""
            */
        }
        
        // pushされた演算子を変数に格納
        if let ope: String = sender.currentTitle {
            centerOperator = ope
        }
        
        is_end = false
        refresh()
    }

    /* 数字が押されたときの処理 */
    @IBAction func tappedNum(_ sender: UIButton) {
        
        if is_end == true {
            resultLabel.text = ""
            harfResultLabel.text = ""
        }
        
        // 押された値がしっかり取得できていれば、それを表示させる
        if let num: String = sender.currentTitle {
            // 0がもともと表示されてる場合は、それを消す
            if (resultLabel.text == "0") {
                resultLabel.text = ""
            }
            // labelに押された値を表示
            resultLabel.text = resultLabel.text! + num
        }
        
        is_end = false
        refresh()
    }
    
    // ドットが押されたときの処理
    @IBAction func tappedDot(_ sender: UIButton) {
        
        if !hasDot(origString: resultLabel.text!) {
            resultLabel.text = resultLabel.text! + "."
            
            is_end = false
            refresh()
        }
    }

    // =が押されたときの処理
    @IBAction func tappedEqual(_ sender: UIButton) {
        if is_end == false {
            // ラベルに表示されている値を右辺として変数に代入
            rightOperand = resultLabel.text
            // 途中経過を表示
            harfResultLabel.text = leftOperand! + " " + centerOperator + " " +  rightOperand!
            // 計算させる関数
            calculate()
            // 計算の終了
            is_end = true
        }
        refresh()
    }
    
    // クリアボタンが押されたときの処理
    @IBAction func tappedClear(_ sender: UIButton) {
        leftOperand = ""
        rightOperand = ""
        centerOperator = ""
        resultLabel.text = "0"
        harfResultLabel.text = "0"
        
        refresh()
        is_end = false
    }
    
    
    /* delete buttonが押されたときの処理 */
    @IBAction func tappedDel(_ sender: UIButton) {
        let targetNum:String = resultLabel.text!
        let index = targetNum.index(targetNum.endIndex, offsetBy: -1)
        
        // 1文字削除する
        resultLabel.text = targetNum.substring(to: index)
        
        if resultLabel.text == "" {
            resultLabel.text = "0"
        }
        
        is_end = false
        refresh()
    }
    
    func calculate() {
        
        if(leftOperand! != "" && centerOperator != "" && rightOperand! != "") {
            // calc!
            
            var result:Double = 0.0
            let left:Double = atof(leftOperand) as Double
            let right:Double = atof(rightOperand) as Double
            
            switch centerOperator {
                case "+":
                    result = left + right
                    break
                case "-":
                    result = left - right
                    break
                case "*":
                    result = left * right
                    break
                case "/":
                    result = left / right
                default: break
            }
            
            resultLabel.text = String(result)
            leftOperand = ""
            rightOperand = ""
            centerOperator = ""
        }
    }
    
    func refresh() {
        harfResultLabel.text = leftOperand! + " " + centerOperator + " " +  rightOperand!
    }
    
    func hasDot(origString:String)->Bool{
        
        for i in origString.characters.indices[origString.startIndex..<origString.endIndex] {
            if (origString[i] == ".") {
                return true
            }
        }
        
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

