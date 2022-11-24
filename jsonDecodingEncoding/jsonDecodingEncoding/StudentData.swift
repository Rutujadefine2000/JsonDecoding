//
//  StudentData.swift
//  jsonDecodingEncoding
//
//  Created by Brahmastra on 16/11/22.
//  Copyright © 2022 Brahmastra. All rights reserved.
//

import Foundation
struct StudentData:Codable
{
    let rollno:Int
    let name:String
    let city:String
    let sclass:String
    let contact:String
    let simage:String
}
