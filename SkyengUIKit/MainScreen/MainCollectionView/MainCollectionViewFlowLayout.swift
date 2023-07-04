//
//  MainCollectionViewFlowLayout.swift
//  SkyengUIKit
//
//  Created by Mac on 29.06.2023.
//

import UIKit

struct ContextCellConstrants {
    static let featureHeight: CGFloat = 280
    static let standardHeight: CGFloat = 100
}

class MainCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    //MARK: Private properties
    
   private let dragOffset: CGFloat = ContextCellConstrants.featureHeight - ContextCellConstrants.standardHeight
    
   private var cacheAttributes = [UICollectionViewLayoutAttributes]()
    
   private var numberOfItems: Int {
        collectionView?.numberOfItems(inSection: 0) ?? 0
    }
   private var featuredItemIndex: Int {
        max(0, Int((collectionView?.contentOffset.y ?? CGFloat(1)) / dragOffset))
    }
   private var persentegeOffset: CGFloat {
        (collectionView?.contentOffset.y ?? 0) / dragOffset - CGFloat(featuredItemIndex)
    }
   private var height: CGFloat {
        collectionView?.bounds.height ?? 100
    }
   private var widht: CGFloat {
        collectionView?.bounds.width ?? 100
    }
    
    //MARK: - Constraction
    
    override init() {
        super.init()
        scrollDirection = .vertical
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Extension

extension MainCollectionViewFlowLayout {
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: widht,
               height: CGFloat(numberOfItems) * dragOffset + height - dragOffset
        )
    }
    
    override func prepare() {
        cacheAttributes.removeAll()
        
        var frame: CGRect = .zero
        var y: CGFloat = 0
        
        for index in 0..<numberOfItems {
            let path = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: path)
            
            var height = ContextCellConstrants.standardHeight
            
            if path.item == featuredItemIndex {
                y = (collectionView?.contentOffset.y ?? 100) - ContextCellConstrants.standardHeight * persentegeOffset
                height = ContextCellConstrants.featureHeight
            } else if path.item == (featuredItemIndex + 1) {
                height = ContextCellConstrants.standardHeight + max(0, dragOffset * persentegeOffset)
                let maxY = y + ContextCellConstrants.standardHeight
                y = maxY - height
            }
            frame = CGRect(x: 0, y: y, width: widht, height: height)
            attributes.frame = frame
            attributes.zIndex = index
            cacheAttributes.append(attributes)
            y = frame.maxY
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var resultAttributes = [UICollectionViewLayoutAttributes]()
        
        return cacheAttributes.compactMap({
            if $0.frame.intersects(rect) {
                return $0
            }
            return nil
        })
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        let index = round(proposedContentOffset.y / dragOffset)
        let y = index * dragOffset
        return CGPoint(x: 0, y: y)
    }
}


