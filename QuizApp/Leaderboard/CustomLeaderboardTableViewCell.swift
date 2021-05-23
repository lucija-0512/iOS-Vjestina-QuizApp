//
//  CustomLeaderboardTableViewCell.swift
//  QuizApp
//
//  Created by five on 16/05/2021.
//

import UIKit

class CustomLeaderboardTableViewCell: UITableViewCell {

    var player : UILabel!
    var points : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            buildViews()
            addConstraints()
        }

    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        player = UILabel()
        player.font = UIFont.boldSystemFont(ofSize: 20.0)
        player.textColor = .white
        
        points = UILabel()
        points.font = UIFont.boldSystemFont(ofSize: 20.0)
        points.textColor = .white
        
        addSubview(player)
        addSubview(points)
    }
    
    private func addConstraints() {
        player.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        player.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        player.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
        
        points.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        points.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        points.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
    }
    
}
