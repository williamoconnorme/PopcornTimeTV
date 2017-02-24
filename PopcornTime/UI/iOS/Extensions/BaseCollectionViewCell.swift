

import Foundation


class BaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
        
    #if os(iOS)
    
    @IBOutlet var highlightView: UIView?
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                highlightView?.isHidden = false
                highlightView?.alpha = 1.0
            } else {
                UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: { [unowned self] in
                    self.highlightView?.alpha = 0.0
                    }, completion: { _ in
                        self.highlightView?.isHidden = true
                })
            }
        }
    }
    
    #elseif os(tvOS)
    
    @IBOutlet var imageLabelSpacingConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.alpha = 0
        titleLabel.layer.zPosition = 10
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        titleLabel.layer.shadowRadius = 2
        titleLabel.layer.shadowOpacity = 0.6
    }
    
    var hidesTitleLabelWhenUnfocused: Bool = true {
        didSet {
            titleLabel.alpha = hidesTitleLabelWhenUnfocused ? 0 : 1
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if hidesTitleLabelWhenUnfocused {
            coordinator.addCoordinatedAnimations({
                self.titleLabel.alpha = self.isFocused ? 1 : 0
            })
        } else {
            imageLabelSpacingConstraint?.constant = isFocused ? 43 : 5
            coordinator.addCoordinatedAnimations({
                self.layoutIfNeeded()
            })
        }
    }
    
    #endif
}