//
//  ViewController.swift
//  scheduletask
//
//  Created by Sierra 4 on 23/02/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController {

   
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var maindate: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    var change: Instructor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
   
    func fetchData() {
        
        let param:[String:Any] = ["access_token" : "ymaANbhfJT4ARby5IbK2u0hUJQ9T7dk8" , "page_no": "1" ,"page_size" : "7" ,"date_selected" :"2017-02-23"]
        
        ApiHandler.fetchData(urlStr: "instructor-home", parameters: param) {
            (jsonData) in
            // print(jsonData)
            let userModel = Mapper<Instructor>().map(JSONObject: jsonData)
            
            self.change = Mapper<Instructor>().map(JSONObject: jsonData)
            
            print(self.change.idata?[0].date ?? "")
            self.maindate.text = self.change.idata?[0].date ?? ""
            
            self.lbl1.text = self.change.idata?[0].day ?? ""
            self.lbl2.text = self.change.idata?[1].day ?? ""
            self.lbl3.text = self.change.idata?[2].day ?? ""
            self.lbl4.text = self.change.idata?[3].day ?? ""
            self.lbl5.text = self.change.idata?[4].day ?? ""
            self.lbl6.text = self.change.idata?[5].day ?? ""
            self.lbl7.text = self.change.idata?[6].day ?? ""
           
            print(userModel?.msg ?? "")
            print((jsonData))
            
            // print(userModel?.profile?.username ?? "")
            // print(userModel?.profile?.phone ?? "")
           
            
            
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController : UICollectionViewDataSource , UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt IndexPath: IndexPath)  -> UICollectionViewCell
    {
        let collectioncell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for : IndexPath) as! dataintoCollectionViewCell
        //cell.labeldisplay.text = scrolldetails[IndexPath.row]
        
        return collectioncell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
//        selectedItem = indexPath.item
//        producttableView.reloadData()
        
    }
}

