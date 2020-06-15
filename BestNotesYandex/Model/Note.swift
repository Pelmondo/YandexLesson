//
//  Notes.swift
//  BestNotesYandex
//
//  Created by Сергей Прокопьев on 15.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation
import UIKit

struct Note {
    let uid: String
    let title: String
    let content: String
    let noteColor: UIColor
    let importance: Importance
    let selfDestructionDate: Date?
    
    init(title: String, content: String, uid: String = UUID().uuidString, color: UIColor = UIColor.white, importance: Importance, selfDestructionDate: Date?) {
        self.noteColor = color
        self.uid = uid
        self.title = title
        self.content = content
        self.importance = importance
        self.selfDestructionDate = selfDestructionDate
    }

}

enum Importance {
    case very
    case medium
    case nomatter
}
