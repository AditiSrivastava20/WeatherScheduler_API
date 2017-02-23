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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tablecell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as? dataintoTableViewCell
            else{
                
                fatalError()
        }
        //        tablecell.prodname?.text = array[selectedItem][indexPath.row].name
        //        tablecell.proddesc?.text = array[selectedItem][indexPath.row].value
        //        tablecell.prodprice?.text = array[selectedItem][indexPath.row].price
        //        tablecell.prodimage?.kf.setImage(with: array[selectedItem][indexPath.row].pic)
        //
        return tablecell
    }
}
