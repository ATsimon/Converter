//
//  ViewController.swift
//  Converter
//
//  Created by Simon Anthony on 30/01/2015.
//  Copyright (c) 2015 Simon Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var binDisplay: UILabel!
    @IBOutlet weak var decDisplay: UILabel!
    @IBOutlet weak var hexDisplay: UILabel!
    @IBOutlet weak var asciiDisplay: UILabel!
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var buttonE: UIButton!
    @IBOutlet weak var buttonF: UIButton!
    
    var brain = ConverterBrain()
    var inputMode = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectInputDisplay(0)
        setModeButtonsEnabled(0)
        println(brain.substringByLength("1110101010111000", spacing: 8))
    }
    
    @IBAction func enterDigit(sender: UIButton) {
        let displayStack = brain.appendDigit(sender.currentTitle!)
        var displayOutput = String()
        
        if displayStack.isEmpty {
            displayOutput = "Invalid value"
        } else {
            displayOutput = "\(displayStack)"
        }
        
        switch inputMode {
        case 0:
            binDisplay.text = displayOutput
        case 1:
            decDisplay.text = displayOutput
        case 2:
            hexDisplay.text = displayOutput
        case 3:
            asciiDisplay.text = displayOutput
        default:
            break
        }
    }
    
    @IBAction func convert() {
        let result = brain.convertValue()
        binDisplay.text = result.0
        decDisplay.text = result.1
        hexDisplay.text = result.2
        asciiDisplay.text = result.3
    }

    @IBAction func setMode(sender: UIButton) {
        var newMode = Int()
        switch sender.currentTitle! {
        case "Bin":
            newMode = 0
        case "Dec":
            newMode = 1
        case "Hex":
            newMode = 2
        case "ASCII":
            newMode = 3
        default:
            break
        }
        
        brain.setMode(newMode)
        inputMode = newMode
        selectInputDisplay(newMode)
        
        setModeButtonsEnabled(newMode)
        
        binDisplay.text = "0"
        decDisplay.text = "0"
        hexDisplay.text = "0"
        asciiDisplay.text = "0"
    }
    
    func selectInputDisplay(input: Int) {
        binDisplay.textColor = UIColor.blackColor()
        decDisplay.textColor = UIColor.blackColor()
        hexDisplay.textColor = UIColor.blackColor()
        asciiDisplay.textColor = UIColor.blackColor()

        switch input {
        case 0:
            binDisplay.textColor = UIColor.orangeColor()
        case 1:
            decDisplay.textColor = UIColor.orangeColor()
        case 2:
            hexDisplay.textColor = UIColor.orangeColor()
        case 3:
            asciiDisplay.textColor = UIColor.orangeColor()
        default:
            break
        }
    }
    
    func setModeButtonsEnabled(mode: Int) {
        switch mode {
        case 0:
            button0.enabled = true
            button1.enabled = true
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
            buttonA.enabled = false
            buttonB.enabled = false
            buttonC.enabled = false
            buttonD.enabled = false
            buttonE.enabled = false
            buttonF.enabled = false
        case 1:
            button0.enabled = true
            button1.enabled = true
            button2.enabled = true
            button3.enabled = true
            button4.enabled = true
            button5.enabled = true
            button6.enabled = true
            button7.enabled = true
            button8.enabled = true
            button9.enabled = true
            buttonA.enabled = false
            buttonB.enabled = false
            buttonC.enabled = false
            buttonD.enabled = false
            buttonE.enabled = false
            buttonF.enabled = false
        case 2:
            button0.enabled = true
            button1.enabled = true
            button2.enabled = true
            button3.enabled = true
            button4.enabled = true
            button5.enabled = true
            button6.enabled = true
            button7.enabled = true
            button8.enabled = true
            button9.enabled = true
            buttonA.enabled = true
            buttonB.enabled = true
            buttonC.enabled = true
            buttonD.enabled = true
            buttonE.enabled = true
            buttonF.enabled = true
        case 3:
            button0.enabled = false
            button1.enabled = false
            button2.enabled = false
            button3.enabled = false
            button4.enabled = false
            button5.enabled = false
            button6.enabled = false
            button7.enabled = false
            button8.enabled = false
            button9.enabled = false
            buttonA.enabled = false
            buttonB.enabled = false
            buttonC.enabled = false
            buttonD.enabled = false
            buttonE.enabled = false
            buttonF.enabled = false
        default:
            break
        }
    }
}