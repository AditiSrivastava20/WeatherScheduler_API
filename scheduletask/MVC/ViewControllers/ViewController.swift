//
//  ViewController.swift
//  scheduletask
//
//  Created by Sierra 4 on 23/02/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import SVProgressHUD

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
    
    
        
    
        var change : Instructor?
        var userModel : Instructor?
        
        var datedtomorrow = Date()
        var scrolledlastdate : String?
        var fulldate : String?
        var monthanddate : String?
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            
            //Alamofire.request("http://34.195.206.185/api/login")
            SVProgressHUD.show()
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            super.viewDidLoad()
            
            let yearMonthDateFormat = DateFormatter()
            yearMonthDateFormat.dateFormat = "yyyy-MM-dd"
            fulldate = yearMonthDateFormat.string(from: Date())
            
            let monthDateFormat = DateFormatter()
            monthDateFormat.dateFormat = "MMM-dd"
            monthanddate = monthDateFormat.string(from: Date())
            
            let todayDate = Date()
            
            let tomorrowDateFormat = DateFormatter()
            tomorrowDateFormat.dateFormat = "yyyy-MM-dd"
            datedtomorrow = tomorrowDateFormat.calendar.date(byAdding: .day, value: 6,to: todayDate)!
            scrolledlastdate = tomorrowDateFormat.string(from: datedtomorrow)
            
            maindate.text = "Today, " + monthanddate!
            
            Alamofire.request("http://34.195.206.185/api/instructor-home")
            
            
            fetchData()
        }
        
        
        func getDayOfWeekInShortString(today:String)->String?
        {
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let todayDate = formatter.date(from: today)
            {
                let Calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
                let Components = Calendar.components(.weekday, from: todayDate)
                let weekDay = Components.weekday
                switch (weekDay!)
                {
                case 1:
                    return "Sun"
                case 2:
                    return "Mon"
                case 3:
                    return "Tue"
                case 4:
                    return "Wed"
                case 5:
                    return "Thu"
                case 6:
                    return "Fri"
                case 7:
                    return "Sat"
                default:
                    return "Nil"
                }
            }
            return nil
        }
        
   func boldLabel(Daylabel:UILabel)
    {
        var labelarray = [lbl1, lbl2, lbl3, lbl4, lbl5, lbl6, lbl7]
        for index in 0..<labelarray.count{
            if(Daylabel == labelarray[index])
            {
                Daylabel.font = UIFont.systemFont(ofSize: 18, weight: 4)
            }
            else
            {
                labelarray[index]?.font=UIFont.systemFont(ofSize:14, weight:0)
            }
        }
    }
    
        func fetchData()
        {
            let param:[String:Any] = ["access_token" : "ymaANbhfJT4ARby5IbK2u0hUJQ9T7dk8" , "page_no": "1" ,"page_size" : "7" ,"date_selected" :"2017-02-24"]
            
            ApiHandler.fetchData(urlStr: "instructor-home", parameters: param)
            {
                (jsonData) in
                // print(jsonData)
                self.userModel = Mapper<Instructor>().map(JSONObject: jsonData)
                self.change = Mapper<Instructor>().map(JSONObject: jsonData)
                
                self.lbl1.text = self.getDayOfWeekInShortString(today:(self.userModel?.idata?[0].date1!)!)
                self.lbl2.text = self.getDayOfWeekInShortString(today:(self.userModel?.idata?[1].date1!)!)
                self.lbl3.text = self.getDayOfWeekInShortString(today:(self.userModel?.idata?[2].date1!)!)
                self.lbl4.text = self.getDayOfWeekInShortString(today:(self.userModel?.idata?[3].date1!)!)
                self.lbl5.text = self.getDayOfWeekInShortString(today:(self.userModel?.idata?[4].date1!)!)
                self.lbl6.text = self.getDayOfWeekInShortString(today:(self.userModel?.idata?[5].date1!)!)
                self.lbl7.text = self.getDayOfWeekInShortString(today:(self.userModel?.idata?[6].date1!)!)
                
                
               
                self.collectionview.reloadData()
            }
        }
    }

    extension ViewController : UICollectionViewDataSource  , UICollectionViewDelegate , UIScrollViewDelegate, UICollectionViewDelegateFlowLayout
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
            return userModel?.idata?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
        {
            return 0.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
        {
            return 0.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            let Widthofcell = self.collectionview.frame.width
            let Heightofcell = self.collectionview.frame.height
            return CGSize(width: Widthofcell, height: Heightofcell)
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
        {
            var visibleRect = CGRect()
            visibleRect.origin = collectionview.contentOffset
            visibleRect.size = collectionview.bounds.size
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            let visibleIndexPath : IndexPath = collectionview.indexPathForItem(at: visiblePoint)!
            let lastElement = (userModel?.idata?.count)! - 1
            if visibleIndexPath.row == lastElement
            {
                Alamofire.request("http://34.195.206.185/api/instructor-home")
                let param: [String:Any] = ["access_token": "ymaANbhfJT4ARby5IbK2u0hUJQ9T7dk8", "page_no": "1", "page_size": "7","last_date": scrolledlastdate ?? "", "date_selected": fulldate!]
                ApiHandler.fetchData(urlStr: "instructor-home", parameters: param)
                {
                    (jsonData) in
                    let userModelAppendMore = Mapper<Instructor>().map(JSONObject: jsonData)
                    for index in 0..<7
                    {
                        self.userModel?.idata?.append((userModelAppendMore?.idata?[index])!)
                    }
                    self.collectionview.reloadData()
                }
            }
        }
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
        {
            if(indexPath.item % 7 == 0){
                self.boldLabel(Daylabel: lbl1)
                           }
            else if(indexPath.item % 7 == 1){
                 self.boldLabel(Daylabel: lbl2)
            }
            else if(indexPath.item % 7 == 2){
                
                self.boldLabel(Daylabel: lbl3)
            }
            else if(indexPath.item % 7 == 3){
                
                self.boldLabel(Daylabel: lbl4)
            }
            else if(indexPath.item % 7 == 4){
                
               self.boldLabel(Daylabel: lbl5)
            }
            else if(indexPath.item % 7 == 5){
                 self.boldLabel(Daylabel: lbl6)
            }
            else if(indexPath.item % 7 == 6){
                 self.boldLabel(Daylabel: lbl7)
            }
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            let collectioncell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! dataintoCollectionViewCell
            collectioncell.datafill = (userModel?.idata?[indexPath.row].details)!
            SVProgressHUD.dismiss()
            return collectioncell
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
        }
}
