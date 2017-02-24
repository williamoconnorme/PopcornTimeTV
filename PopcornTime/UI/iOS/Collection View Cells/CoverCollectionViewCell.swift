

import UIKit

class CoverCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet var watchedIndicator: UIImageView!
    
    var watched = false {
        didSet {
            watchedIndicator?.isHidden = !watched
        }
    }
    
    #if os(iOS)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        [highlightView, imageView].forEach {
            $0?.layer.cornerRadius = self.bounds.width * 0.02
            $0?.layer.masksToBounds = true
        }
    }
    #endif
}
