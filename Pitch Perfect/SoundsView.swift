//
//  SoundsView.swift
//  Pitch Perfect
//
//  Created by Hamada on 15/10/2018.
//  Copyright © 2018 Scarab-dev. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - SoundsView

class SoundsView: UIViewController {
    
    // MARK: - IBOutlets buttons with updated UIButton -> CenterImageButton
    
    @IBOutlet weak var snailButton: CenterImageButton!
    @IBOutlet weak var chipmunkButton: CenterImageButton!
    @IBOutlet weak var rabbitButton: CenterImageButton!
    @IBOutlet weak var vaderButton: CenterImageButton!
    @IBOutlet weak var echoButton: CenterImageButton!
    @IBOutlet weak var reverbButton: CenterImageButton!
    @IBOutlet weak var stopButton: CenterImageButton!
    
    // MARK: - Variables
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // set button types
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
    }
    
    // MARK: - IBActions
    
    @IBAction func playSound(_ sender: UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow: playSound(rate: 0.5)
        case .fast: playSound(rate: 1.5)
        case .chipmunk: playSound(pitch: 1000)
        case .vader: playSound(pitch: -1000)
        case .echo: playSound(echo: true)
        case .reverb: playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopSound(_ sender: UIButton){
        stopAudio()
    }

}
