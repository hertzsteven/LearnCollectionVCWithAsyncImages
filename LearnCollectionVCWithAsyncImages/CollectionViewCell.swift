//
//  CollectionViewCell.swift
//  LearnCollectionVCWithAsyncImages
//
//  Created by Steven Hertz on 5/31/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemTeal
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = "lorum ipson and more"
        label.alpha = 1.0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(titleLabel)
    }

    private func layout() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 1),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 1)
        ])
    }
    
}

extension CollectionViewCell {
    
    func doUpdate(color: UIColor) {
        self.backgroundColor = color
    }
    func doUpdateText(text: String) {
        self.titleLabel.text = text
    }
}



