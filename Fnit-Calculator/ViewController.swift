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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /* 演算子が押されたときの処理 */
    @IBAction func tappedOperator(_ sender: UIButton) {
        
        // 左辺の値がまだ確定していなかったら、
        if leftOperand! == "" {
            // 左辺の値を確定し、
            leftOperand = resultLabel.text!
            // 次の値を受け付ける
            resultLabel.text = ""
        }
        
        //calculate()
        
        // pushされた演算子を変数に格納
        if let ope: String = sender.currentTitle {
            centerOperator = ope
            
            harfResultLabel.text = leftOperand! + " " + centerOperator + " " +  rightOperand!
        }
    }
    
    /* 数字が押されたときの処理 */
    @IBAction func tappedNum(_ sender: UIButton) {
        
        // 押された値がしっかり取得できていれば、それを表示させる
        if let num: String = sender.currentTitle {
            // 0がもともと表示されてる場合は、それを消す
            if (resultLabel.text == "0") {
                resultLabel.text = ""
            }
            // labelに押された値を表示
            resultLabel.text = resultLabel.text! + num
            
            // 途中結果を表示させる
            harfResultLabel.text = leftOperand! + " " + centerOperator + " " +  rightOperand!
        }
    }
    
    // ドットが押されたときの処理
    @IBAction func tappedDot(_ sender: UIButton) {
        
        resultLabel.text = resultLabel.text! + "."
    }
    
    // =が押されたときの処理
    @IBAction func tappedEqual(_ sender: UIButton) {
        
        // ラベルに表示されている値を右辺として変数に代入
        rightOperand = resultLabel.text
        // 途中経過を表示
        harfResultLabel.text = leftOperand! + " " + centerOperator + " " +  rightOperand!
        // 計算させる関数
        calculate()
    }
    
    // クリアボタンが押されたときの処理
    @IBAction func tappedClear(_ sender: UIButton) {
        leftOperand = ""
        rightOperand = ""
        centerOperator = ""
        resultLabel.text = "0"
    }
    
    func calculate() {
        
        print (leftOperand)
        print (rightOperand)
        print (centerOperator)
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

