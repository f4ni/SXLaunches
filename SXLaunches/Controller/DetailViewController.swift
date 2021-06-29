//
//  DetailViewController.swift
//  SXLaunches
//
//  Created by fârûqî on 28.06.2021.
//

import Kingfisher
import SnapKit

class DetailViewController: UIViewController {
    
    var launch: Launch!{
        didSet{
            if let urlStr = launch.links?.missionPatch, let url = URL(string: urlStr) {
                self.iv.kf.setImage(with: url)
            }
            nameLabel.text = launch.missionName ?? ""
            detailLabel.text = launch.details ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    let iv: UIImageView = {
        let v = UIImageView()
        
        return v
    }()
    
    let nameLabel: UILabel = {
        let v = UILabel()
        
        return v
    }()
    
    let detailLabel: UILabel = {
        let tf = UILabel()
        tf.numberOfLines = 10
        return tf
    }()
    
    func setupViews() {
        view.addSubview(iv)
        view.addSubview(nameLabel)
        view.addSubview(detailLabel)
        
        iv.snp.makeConstraints { mk in
            mk.leading.top.equalToSuperview().offset(20)
            mk.height.width.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { mk in
            mk.top.trailing.equalToSuperview().offset(20)
            mk.leading.equalTo(iv.snp_trailing).offset(20)
        }
        
        detailLabel.snp.makeConstraints { mk in
            mk.top.equalTo(iv.snp_bottom).offset(30)
            mk.leftMargin.rightMargin.equalToSuperview().offset(16)
        }
        
    }
}
