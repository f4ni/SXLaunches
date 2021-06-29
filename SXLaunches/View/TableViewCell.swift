//
//  TableViewCell.swift
//  SXLaunches
//
//  Created by fârûqî on 29.06.2021.
//

import Kingfisher

class TableViewCell: UITableViewCell {
    
    var launch: Launch!{
        didSet{
            textLabel?.text = launch.missionName
            detailTextLabel?.text = launch.launchYear
            if let url = launch.links?.missionPatch{
                imageView?.kf.setImage(with: URL(string: url), placeholder: nil, options: nil, completionHandler: { result in
                    self.setNeedsLayout()
               
                })
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
