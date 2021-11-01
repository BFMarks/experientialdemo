//
//  ViewController.swift
//  IMVU_Dummy
//
//  Created by Bryan Marks on 9/29/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import IterableSDK


class ViewController: UIViewController {
    
    
    func getMostRecentNotification(){
        

//        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
        let email = "bryan%2bimvu1@iterable.com"
        
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Api-Key": "ee9b636fb02f4d9092285e343f936904"
        ]
        
        
        let e_email = email.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
//        if let escapedString = email!.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            let urlForMessages = "https://api.iterable.com/api/inApp/getMessages?email=bryan%2Bimvu6%40iterable.com&count=1&platform=iOS&SDKVersion=None&packageName=None"
            AF.request(urlForMessages, method: .get, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in

                switch response.result {
                case .success(_):
                    if let data = response.data {
                        let success = data
                        let result = JSON(success)["inAppMessages"].arrayValue
                        
                        print("Iterable testMEssage")
                        print(result)

                        let content = result.contains(0)
                        if !content {
                            for items in result {

                                
                                let flag = items["content"]["payload"]
                                print("flag")
                                print(flag["head"])
                                if (flag["head"] == "girl_head"){
                                    let imageName = "girl_head"
                                    let image = UIImage(named: imageName)
                                    let imageView = UIImageView(image: image!)
                                    
                                    imageView.frame = CGRect(x: 60, y: 20, width: 200, height: 200)
                                    self.view.addSubview(imageView)
                                    
                                } else {
                                    let imageName = "girl_head"
                                    let image = UIImage(named: imageName)
                                    let imageView = UIImageView(image: image!)
                                    
                                    imageView.frame = CGRect(x: 60, y: 20, width: 200, height: 200)
                                    self.view.addSubview(imageView)
                                }
                                
                                if (flag["tile"] == "green_tiles"){
                                    let screenSize: CGRect = UIScreen.main.bounds
                                    let myView = UIView(frame: CGRect(x: 0, y: 500, width: screenSize.width , height: 200))
                                    myView.backgroundColor = .green
                                    
                                    
//                                    EVENT TILE CLICK
//                                    IterableAPI.track(event: "click_tile")
                                    IterableAPI.track(event: "click_tile", dataFields: ["color":flag["tile"]])
                                    
                                    
                                    
                                    
                                    self.view.addSubview(myView)
                                    
                                } else {
                                    
                                    let screenSize: CGRect = UIScreen.main.bounds
                                    let myView = UIView(frame: CGRect(x: 0, y: 500, width: screenSize.width , height: 200))
                                    myView.backgroundColor = .blue
                                    self.view.addSubview(myView)

                                }

                            }
                        }
                    }
                    break

                case .failure(_):
//                    print("Iterable testMEssage")
                    print(response.result)
                    break
                }
            }
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getMostRecentNotification()
        
        

        let viewController = IterableInboxNavigationViewController()
        present(viewController, animated: true)
        

    }


}

