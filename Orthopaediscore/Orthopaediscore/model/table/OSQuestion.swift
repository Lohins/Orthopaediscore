//
//  OSQuestion.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/1.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSQuestion: NSObject {
    
    var id: Int = -1
    var content: String = ""
    var choiceList = [OSChoice]()
    
    struct OSChoice {
        var choicecontent: String
        var choiceid: Int
        var choicescore: Int
    }
    
    init(Id: Int , Content: String) {
        self.id = Id
        self.content = Content
    }
    
    func updateChoices(list: [OSChoice]){
        self.choiceList = list
    }
    
    class func parse(dict: Dictionary<String, Any>) -> [OSQuestion]{
        if let data = dict["data"] as? Dictionary<String, Any> , let list = data["content"] as? [Dictionary<String, Any>]{
            
            var QList = [OSQuestion]()
            for questDict in list{
                if let questionID = questDict["questionid"] as? Int, let questionContent = questDict["questioncontent"] as? String, let choiceList = dict["choiceinfo"] as? [Dictionary<String, Any>]{
                    let question = OSQuestion.init(Id: questionID, Content: questionContent)
                    var choices = [OSChoice]()
                    for choiceDict in choiceList{
                        if let choiceID = choiceDict["choiceid"] as? Int, let choiceScore = choiceDict["choicescore"] as? Int, let choiceContent = choiceDict["choicecontent"] as? String{
                            let choice = OSChoice.init(choicecontent: choiceContent, choiceid: choiceID, choicescore: choiceScore)
                            choices.append(choice)
                        }
                    }
                    question.updateChoices(list: choices)
                    QList.append(question)
                }
            }
            return QList
        }
        else{
            return [OSQuestion]()
        }
    }
}
