//
//  xAPISender.swift
//  xAPITest
//
//  Created by ddl on 2017/12/6.
//  Copyright © 2017年 ddl. All rights reserved.
//

class xAPISender {
    
    let tincan = RSTinCanConnector(
        options: [
            "recordStore": [
                [
                    "endpoint": "http:///data/xAPI",
                    "version": "1.0.0",
                    "auth": "Basic " + Data(
                            String(
                                "" +
                                    ":" +
                                ""
                                ).utf8
                        ).base64EncodedString()
                ]
            ]
        ]
    )

    func send(_ statement: TCStatement) -> Bool {
        var if_success: Bool = true
        
        tincan?.send(
            statement,
            withCompletionBlock: {},
            withErrorBlock: {
                (error) in print(error?.localizedDescription ?? "Error")
                if_success = false
            }
        )
        
        return if_success
    }
    
    func setupStatement(
        
        ActorName: String,
        ActorMbox: String,
        VerbID: String,
        VerbDescription: String,
        ActivityID: String,
        ActivityName: String,
        ActivityDescription: String,
        ContextExtensions :Dictionary<String, Any>,
        ResultSuccess: Bool,
        ResultCompletion: Bool
        
        ) -> TCStatement {
        return TCStatement(
            
            id: UUID().uuidString,
            
            withActor: TCAgent(
                name: ActorName,
                withMbox: "mailto:" + ActorMbox,
                withAccount: nil
            ),
            
            withTarget: TCActivity(
                id: ActivityID,
                with: TCActivityDefinition(
                    name: TCLocalizedValues(languageCode: "zh-TW", withValue: ActivityName),
                    withDescription: TCLocalizedValues(languageCode: "zh-TW", withValue: ActivityDescription),
                    withType: nil,
                    withExtensions: nil,
                    withInteractionType: nil,
                    withCorrectResponsesPattern: nil,
                    withChoices: nil,
                    withScale: nil,
                    withTarget: nil,
                    withSteps: nil
                )
            ),
            
            with: TCVerb(
                id: VerbID,
                withVerbDisplay: TCLocalizedValues(languageCode: "zh-TW", withValue: VerbDescription)
            ),
            
            with: TCResult(
                response: nil,
                withScore: nil,
                withSuccess: ResultSuccess as NSNumber,
                withCompletion: ResultCompletion as NSNumber,
                withDuration: nil,
                withExtensions: nil
            ),
            
            with: TCContext(
                registration: nil,
                withInstructor: nil,
                withTeam: nil,
                withContextActivities: nil,
                withExtensions: ContextExtensions
            )
        )
    }
    
}
