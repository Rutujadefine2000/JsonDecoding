//
//  ViewController.swift
//  jsonDecodingEncoding
//
//  Created by Brahmastra on 16/11/22.
//  Copyright © 2022 Brahmastra. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
 
    @IBOutlet weak var StudentImg: UIImageView!
    
    @IBOutlet weak var lName: UILabel!
    
    @IBOutlet weak var lRollno: UILabel!
    
    @IBOutlet weak var lclass: UILabel!
    
    @IBOutlet weak var lcity: UILabel!
    
    @IBOutlet weak var lcontact: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    fetchData()
    }
    func fetchData(){
        let url = URL(string: "http://haritibhakti.com/studentdata.json")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else
            {
                print("Error occured whilr Acessing Data")
                return
            }
            print(data)
            var studentObject:StudentData?
            do{
                studentObject = try JSONDecoder().decode(StudentData.self, from: data)
                
                
                
            }
            catch{
                   print("Error while Decoding Json into Swift Structure\(error)")
            }
            guard let sData = studentObject else
            {
                return
            }
            print("received Data \(sData)")
            DispatchQueue.main.async {
                self.lRollno.text = "Rollno : \(studentObject!.rollno)"
                self.lName.text = "Name : \(studentObject!.name)"
                self.lclass.text = "Class : \(studentObject!.sclass)"
                self.lcity.text = "City : \(studentObject!.city)"
                self.lcontact.text = "contact : \(studentObject!.contact)"
                let urlImage = URL(string: studentObject!.simage)
                self.StudentImg.dowloadImage(from:urlImage!)
                }
            })
        task.resume()
    }
    
}
extension UIImageView
{
    func dowloadImage(from url:URL)
    {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data,response,error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode
                == 200, let mimetype = response?.mimeType, mimetype.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
        else
            {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        
        })
        dataTask.resume()
    }
}
