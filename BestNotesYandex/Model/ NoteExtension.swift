//
//   NoteExtension.swift
//  BestNotesYandex
//
//  Created by Сергей Прокопьев on 15.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation
import UIKit

extension Note {
    static func parse(json: [String:Any]) -> Note? {
        let title = json["title"] as! String
        let content = json["content"] as! String
        let uid = json["uid"] as! String
        var importance = Importance.medium
        switch json["importance"] as! Int {
        case 2:
            importance = Importance.very
        case 1:
            importance = Importance.nomatter
        default:
            break
        }
        // парсим цвет из [r,g,b,a] в UIColor
        var notesColor = UIColor.white
        switch json["noteColor"] {
        case .some:
            let (r,g,b,a) = json["noteColor"] as! (CGFloat, CGFloat, CGFloat, CGFloat)
            notesColor = UIColor(red: r, green: g, blue: b, alpha: a)
        default:
            break
        }
        
        let selfDestructionDate: Date?
        switch json["selfDistrDate"] {
        case .some(let date):
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            selfDestructionDate = formatter.date(from: date as! String)
        default:
            selfDestructionDate = nil
        }
       
        return Note(title: title, content: content, uid: uid, color: notesColor, importance: importance, selfDestructionDate: selfDestructionDate)
    }
    
    var json: [String:Any] {
        var dict: [String:Any] = ["uid": uid]
        dict["title"] = title
        dict["content"] = content
        switch importance {
        case .very:
            dict["importance"] = 2
        case .nomatter:
            dict["importance"] = 1
        default:
            break
        }
        // UIColor into INT (red,green,blue,alpha)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        if noteColor != UIColor.white {
            noteColor.getRed(&r, green: &g, blue: &b, alpha: &a)
            dict["noteColor"] = (r, g, b, a)
        }
        
        switch selfDestructionDate {
        case .some(let date):
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            dict["selfDistrDate"] = formatter.string(from: date)
        default:
            break
        }
          return dict
  }
}

