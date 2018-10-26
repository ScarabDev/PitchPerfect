//
//  RecordView.swift
//  Pitch Perfect
//
//  Created by Hamada on 15/10/2018.
//  Copyright © 2018 Scarab-dev. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - RecordView

class RecordView: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: - Variables
    
    var audioRecorder: AVAudioRecorder!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopBtn.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        print("viewWillAppear called")
        
    }
    
    func configureRecordState(_ recordState: Bool){
        switch(recordState) {
        case true:
            recordBtn.isEnabled = false
            stopBtn.isEnabled = true
            recordLabel.text = "Recording in progress"
        case false:
            recordBtn.isEnabled = true
            stopBtn.isEnabled = false
            recordLabel.text = "Tab to record..."
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func startRecord(_ sender: Any) {
        
        configureRecordState(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecord(_ sender: Any) {
        
        configureRecordState(false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - Audio Recorder Delegate
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecord", sender: audioRecorder.url)
        }else{
            print("Recording Fail")
        }
    }
    
    // MARK: - prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == STOP_RECORD_IDENTIFIER {
            let stopRecord = segue.destination as! SoundsView
            let recordedAudioURL = sender as! URL
            
            stopRecord.recordedAudioURL = recordedAudioURL
        }
    }
    
}

