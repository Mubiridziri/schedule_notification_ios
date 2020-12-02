//
//  Persistable.swift
//  alarmX
//
//  Created by Юрий Потапов on 01.12.2020.
//

import Foundation

protocol Persistable {
    var ud: UserDefaults {get}
    var persistKey : String {get}
    func persist()
    func unpersist()
}

