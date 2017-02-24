//
//  dataintoCollectionViewCell.swift
//  scheduletask
//
//  Created by Sierra 4 on 23/02/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit

class dataintoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableview: UITableView!
    
    var datafill: [Details]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableview.dataSource = self
        tableview.delegate = self
        /*view.lay.selfer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1        // Initialization code*/
    }
    
    
}
extension dataintoCollectionViewCell : UITableViewDelegate ,UITableViewDataSource
{
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (datafill?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tablecell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as? dataintoTableViewCell
        tablecell?.maintime?.text = (datafill?[indexPath.row].start_time)!
        tablecell?.time?.text = datafill?[indexPath.row].time_duration
        tablecell?.home?.text = "Home"
        tablecell?.address?.text = datafill?[indexPath.row].day_location
        
        for subject in (datafill?[indexPath.row].subjects)!
        {
        tablecell?.subject?.text = subject.subject_name ?? ""
        }
        tablecell?.number?.text = String(describing: datafill?[indexPath.row].enrolled ?? 0)
        tablecell?.quantity?.text = datafill?[indexPath.row].age_group
        tablecell?.money?.text = (datafill?[indexPath.row].charge_student)!
       
        tablecell?.view.layer.shadowColor = UIColor.lightGray.cgColor
        tablecell?.view.layer.shadowOpacity = 1
        tablecell?.view.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        tablecell?.view.layer.shadowRadius = 2
        
    
        return tablecell!
    }
}
