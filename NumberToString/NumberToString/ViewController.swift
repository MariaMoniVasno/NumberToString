//
//  ViewController.swift
//  NumberToString
//
//  Created by developer on 20/08/20.
//  Copyright © 2020 doodleblue. All rights reserved.
//

import UIKit
//Print the any number as human readable format,Input range 0 to 9999999
class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var inputTxtFld : UITextField!
    @IBOutlet var outputLbl: UILabel!
    @IBOutlet var calculateBtn: UIButton!
    @IBOutlet var heightConstraints: NSLayoutConstraint!

    //Initializing the array of strings
    var onesArray = ["","One ","Two ","Three ","Four ","Five ","Six ","Seven ","Eight ","Nine ","Ten ","Eleven ","Twelve ","Thirteen ","Fourteen ","Fifteen ","Sixteen ","Seventeen ","Eighteen ","Nineteen "]
    var tensArray = ["","","Twenty ","Thirty ","Forty ","Fifty ","Sixty ","Seventy ","Eighty ","Ninety "]
    //Initializing the input values
    var inputNum = Int()
    var inputStr = ""
    var tensDigit = ""
    var hundStr = ""
    var thousandStr = ""
    var lakhStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NumberFormatter"
        //inputTxtFld properties
        inputTxtFld.textColor = .black
        inputTxtFld.font = UIFont(name: "Helvetica", size: 16)
        inputTxtFld.keyboardType = .numberPad
        //outputLbl properties
        outputLbl.textAlignment = .center
        outputLbl.font = UIFont(name: "Helvetica", size: 16)
        outputLbl.numberOfLines = 0
        outputLbl.lineBreakMode = .byWordWrapping
        outputLbl.layer.borderColor = UIColor.darkGray.cgColor
        outputLbl.layer.borderWidth = 2
        //calculateBtn properties
        calculateBtn.backgroundColor = .systemBlue
        calculateBtn.setTitle("Convert", for: UIControl.State())
        calculateBtn.setTitleColor(.white, for: UIControl.State())
        calculateBtn.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        calculateBtn.layer.cornerRadius = 15
        calculateBtn.layer.borderWidth = 1
        calculateBtn.layer.borderColor = UIColor.white.cgColor
    }
    @IBAction func calculateBtnAction(_ sender: Any) {
        inputTxtFld.resignFirstResponder()
        inputStr = inputTxtFld.text!
        if (inputTxtFld.text == "")
        {
            heightConstraints.constant = 30
            let alert = UIAlertController(title: "Alert", message: "Please enter a number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
        inputNum = Int(inputStr)!//Convert Int to String
        if inputNum == 0{
        outputLbl.text = "Zero"
        heightConstraints.constant = 30
        }else{
        numberToString()
        }
        }
        
    }
    // MARK: String Conversion Function
    func numberToString(){
        var inputLeng = inputStr.count // Check the input length
        if inputLeng == 7 || inputLeng == 6{
            tensToStr()
            thousandToString()
            hundredToString()
            lakhToString()
            if hundStr != "" && thousandStr != "" {
            outputLbl.text = "\(lakhStr)Lakh \(thousandStr)Thousand \(hundStr)Hundred \(tensDigit)"
            }else if hundStr == "" && thousandStr != "" {
            outputLbl.text = "\(lakhStr)Lakh \(thousandStr)Thousand \(tensDigit)"
            }else if hundStr != "" && thousandStr == "" {
            outputLbl.text = ( "\(lakhStr)Lakh \(hundStr)Hundred \(tensDigit)")
            }else{
            outputLbl.text = ("\(lakhStr)Lakh \(tensDigit)")
        }}else if inputLeng == 4 || inputLeng == 5{
            tensToStr()
            hundredToString()
            thousandToString()
            if hundStr != ""{
            outputLbl.text = ("\(thousandStr)Thousand \(hundStr)Hundred \(tensDigit)")
            }else{
            outputLbl.text = ("\(thousandStr)Thousand \(tensDigit)")
        }}else if inputLeng == 3{
            tensToStr()
            hundredToString()
            outputLbl.text = ( "\(hundStr)Hundred \(tensDigit)")
        }else if inputLeng == 2 || inputLeng == 1{
            tensToStr()
            outputLbl.text = ( "\(tensDigit)")
        }else{
            //Above 99 lakhs
            outputLbl.text = ("Input out of range")
        }
        
        var messageHeight = rectForText(outputLbl.text!, font: outputLbl.font, maxSize: CGSize(width: 250, height: 2000)).height
        if messageHeight > 35
        {
            messageHeight = 35
            let alertHeight = messageHeight + 30
            heightConstraints.constant = alertHeight
            
        }else{
            messageHeight = 35
            let alertHeight = messageHeight
            heightConstraints.constant = alertHeight
        }
    }
    func tensToStr() {
        var lastTwoDigits = Int((inputStr.suffix(2)))
        if lastTwoDigits! <= 19 {
            tensDigit = onesArray[lastTwoDigits!]
        }else if lastTwoDigits! >= 20{
            tensDigit = tensArray[Int((lastTwoDigits! / 10))] + onesArray[Int((lastTwoDigits! % 10))]
        }
    }
    func hundredToString()
    {
        var firstPosition = Int(inputStr.suffix(3))
        var index = (firstPosition! / 100) % 10
        hundStr = onesArray[index]
    }
    func thousandToString()
    {
        var firstPosition = Int((inputStr.suffix(5)))
        var index = (firstPosition! / 1000) % 100
        if index <= 19{
            thousandStr = onesArray[index]
        }else{
            thousandStr = tensArray[Int(index / 10)] + onesArray[Int(index % 10)]
        }
    }
    func lakhToString(){
        var firstPosition = Int((inputStr))
        var index = (firstPosition! / 100000) % 100
        if index <= 19{
            lakhStr = onesArray[index]
        }else{
            lakhStr = tensArray[Int((index / 10))] + onesArray[Int((index % 10))]
        }
    }
   func rectForText(_ text: String, font: UIFont, maxSize: CGSize) -> CGSize
    {
        //This is a method to calculate the height
        let attrString = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font:font])
        let rect = attrString.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let size = CGSize(width: rect.size.width, height: rect.size.height)
        return size
    }
    //MARK: TextField delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        outputLbl.text = ""
        heightConstraints.constant = 30
        let newLength = (textField.text?.count)! + string.count - range.length
        if textField == inputTxtFld
        {
            if newLength <= 7
            {
                let Regex = "[0-9^]*"
                let TestResult = NSPredicate.init(format:"SELF MATCHES %@",Regex)
                return TestResult.evaluate(with: string)
            }
            else
            {
                return false
            }
        }
            
        else
        {
            return false
        }
    }
    
}

