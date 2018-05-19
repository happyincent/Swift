//
//  xAPISender-Player.swift
//  EZPlayer
//
//  Created by ddl on 2018/2/13.
//  Copyright © 2018年 yangjun zhu. All rights reserved.
//

class xAPISender_Player {
    
    func send(URL:String, oldState:String = "", newState:String = "", currentTime:Int = 0, Duration:Int = 0) {
        var verbID :String = ""
        var verbName :String = ""
        
        if oldState == "readyToPlay" && newState == "playing" {
            
            verbID = "https://w3id.org/xapi/video/verbs/played"
            verbName = "Start"
            
        } else if oldState == "playing" && newState == "pause" {
            
            verbID = "https://w3id.org/xapi/video/verbs/paused"
            verbName = "Pause"
            
        } else if oldState == "pause" && newState == "playing" {
            
            verbID = "https://w3id.org/xapi/video/verbs/played"
            verbName = "Keep"
            
        } else if oldState == "stopped" && newState == "stopped" {
            
            verbID = "http://activitystrea.ms/schema/1.0/close"
            verbName = "Stop"
            
        } else if newState == "seekingForward" {
            
            verbID = "https://w3id.org/xapi/video/verbs/seeked"
            verbName = newState + "_before"
            
        } else if oldState == "seekingForward" {
            
            verbID = "https://w3id.org/xapi/video/verbs/seeked"
            verbName = oldState + "_after"
            
        } else if newState == "seekingBackward" {
            
            verbID = "https://w3id.org/xapi/video/verbs/seeked"
            verbName = newState + "_before"
            
        } else if oldState == "seekingBackward" {
            
            verbID = "https://w3id.org/xapi/video/verbs/seeked"
            verbName = oldState + "_after"
            
        } else if oldState == "changeRate" {
           
            verbID = "https://w3id.org/xapi/seriousgames/verbs/pressed"
            verbName = oldState
            
        } else {
            return
        }
        
        let sender = xAPISender(), check = sender.send(
            sender.setupStatement(
                ActorName: UserDefaults.standard.string(forKey: "KEY_id") ?? "errorID",
                ActorMbox: "ddl@example.com",
                VerbID: verbID,
                VerbDescription: verbName,
                ActivityID: "http://adlnet.gov/expapi/activities/media",
                ActivityName: "Dr.Go video",
                ActivityDescription: URL,
                ContextExtensions: [
                    "http://id.tincanapi.com/extension/position": currentTime,
                    "http://id.tincanapi.com/extension/ending-position": Duration
                ],
                ResultSuccess: true,
                ResultCompletion: true
            )
        )
        
        print( "xAPI sent", check ? "successfully" : "unsuccessfully" )
    }
    
}
