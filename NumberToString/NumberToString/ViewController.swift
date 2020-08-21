//
//  ViewController.swift
//  NumberToString
//
//  Created by developer on 20/08/20.
//  Copyright © 2020 doodleblue. All rights reserved.
//

import UIKit
//Print the any number as human readable format,Input range -9999999 to 9999999
class ViewController: UIViewController {
    
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
    var negativeStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        inputStr = "\(inputNum)"//Convert Int to String
        if inputStr.contains("-"){
        inputStr = inputStr.filter({ $0 != "-" })//Filter the minus
        negativeStr = "Minus "
        }
        if inputNum == 0{
            print("Input - \(inputNum), Output - Zero")
        }else{
        numberToString()
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
                print( "Input - \(inputNum), Output - \(negativeStr)\(lakhStr)Lakh \(thousandStr)Thousand \(hundStr)Hundred \(tensDigit)")
            }else if hundStr == "" && thousandStr != "" {
                print("Input - \(inputNum), Output - \(negativeStr)\(lakhStr)Lakh \(thousandStr)Thousand \(tensDigit)")
            }else if hundStr != "" && thousandStr == "" {
                print( "Input - \(inputNum), Output - \(negativeStr)\(lakhStr)Lakh \(hundStr)Hundred \(tensDigit)")
            }else{
                print("Input - \(inputNum), Output - \(negativeStr)\(lakhStr)Lakh \(tensDigit)")
        }}else if inputLeng == 4 || inputLeng == 5{
            tensToStr()
            hundredToString()
            thousandToString()
            if hundStr != ""{
                print( "Input - \(inputNum), Output - \(negativeStr)\(thousandStr)Thousand \(hundStr)Hundred \(tensDigit)")
            }else{
                print("Input - \(inputNum), Output - \(negativeStr)\(thousandStr)Thousand \(tensDigit)")
        }}else if inputLeng == 3{
            tensToStr()
            hundredToString()
            print( "Input - \(inputNum), Output - \(negativeStr)\(hundStr)Hundred \(tensDigit)")
        }else if inputLeng == 2 || inputLeng == 1{
            tensToStr()
            print( "Input - \(inputNum), Output - \(negativeStr)\(tensDigit)")
        }else{
            //Above 99 lakhs
            print("Input out of range")
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
}

