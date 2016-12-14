//
//  DataModel.swift
//  MystieriousNum
//
//  Created by Kaiyin Zhong on 12/14/16.
//  Copyright © 2016 vu.co.kaiyin. All rights reserved.
//

import Foundation

class DataModel {
    private var numberDict = [Int:[Int]]()
    private var keys: [Int] = []
    private var currenKeyIndex: Int = 0
    init() {
        // A basis for linear combination
        for i in 0..<6 {
            numberDict[0x000001 << i] = [Int]()
        }
        // Classification based on non-zero coefs
        for number in 0..<64 {
            for nShift in 0..<6 {
                let key =  (0x000001 << nShift)
                if key & number > 0 {
                    numberDict[key]?.append(number)
                }
            }
        }
        keys = numberDict.keys.sorted()
    }
    
    private func nextKey() -> Int? {
        if currenKeyIndex >= 6 {
            return nil
        }
        let key = keys[currenKeyIndex]
        currenKeyIndex += 1
        return key
    }

    func nextGroup() -> (Int, [Int])? {
        if let key = nextKey() {
            return (key, numberDict[key]!)
        }
        return nil
    }
    
}
