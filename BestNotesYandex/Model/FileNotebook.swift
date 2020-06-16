//
//  FileNotebook.swift
//  BestNotesYandex
//
//  Created by Сергей Прокопьев on 15.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation
import UIKit


class FileNotebook {
    private var notes = [String:Note]()
    
    public func add(_ note: Note) {
        guard (notes.index(forKey: note.uid) != nil) else {
            notes[note.uid] = note
            return
        }
    }
    
    public func remove(with uid: String) {
        notes.removeValue(forKey: uid)
    }
    
    public func saveToFile() {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return}
        let fileURL = documentDirectoryUrl.appendingPathComponent("Notes.json")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            try data.write(to: fileURL, options: [])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func loadFromfile() {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return}
        let fileURL = documentDirectoryUrl.appendingPathComponent("Notes.json")
        
        do {
            let data = try Data(contentsOf: fileURL, options: [])
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[String:Any]] else {return}
            notesFromJson(with: json)
        } catch {
            print(error.localizedDescription)
        }
    }
}


extension FileNotebook {
    var json: [String: [String:Any]] {
        var dict = [String: [String:Any]]()
        notes.forEach { dict[$0.key] = $0.value.json }
        return dict
    }
    
    func notesFromJson (with json: [String:[String:Any]]) {
        for key in json.keys {
            guard let notesJSON = json[key] else {return}
            self.add(Note.parse(json: notesJSON)!)
        }
    }
}
