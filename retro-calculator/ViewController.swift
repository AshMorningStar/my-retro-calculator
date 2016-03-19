//
//  ViewController.swift
//  retro-calculator
//
//  Created by Mohamad Asyraaf on 17/3/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation : String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
       // case Equal = "="
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl:UILabel!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation : Operation = Operation.Empty
    var result = ""
    
    var soundBtn:AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
            try soundBtn = AVAudioPlayer(contentsOfURL: soundURL)
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }


    @IBAction func buttonPressed(btnNo :UIButton!){
        playSound()
        
        runningNumber += "\(btnNo.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
   
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject){
        clearOutput()
    }
    
    func clearOutput(){
        playSound()
        rightValStr = ""
        leftValStr = ""
        runningNumber = ""
        currentOperation = Operation.Empty
        outputLbl.text = ""
        
    
    }
    func processOperation(op: Operation){
        playSound()
        
        
        if currentOperation != Operation.Empty{
            
            if runningNumber != ""{
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!) "
                    
                }else if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!) "
                    
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!) "
                    
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!) "
                    
                }
                
                leftValStr = result
                outputLbl.text = result

            }

            
            currentOperation = op
        }else{
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    
    func playSound(){
        if soundBtn.playing {
            soundBtn.stop()
        }
        soundBtn.play()
    }
 }

