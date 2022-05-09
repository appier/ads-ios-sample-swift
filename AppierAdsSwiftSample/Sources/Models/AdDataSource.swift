import Foundation
import UIKit

class AdDataSource {
    let header: AdDataSource.Header
    let cells: [AdDataSource.Cell]
    
    init(header: AdDataSource.Header, cells: [AdDataSource.Cell]) {
        self.header = header
        self.cells = cells
    }
}

extension AdDataSource {
    class Header {
        let title: String
        let image: UIImage
        
        init(title: String, image: UIImage) {
            self.title = title
            self.image = image
        }
    }
    
    class Cell {
        let title: String
        let ctrCls: UIViewController.Type
        
        init(title: String, ctrCls: UIViewController.Type) {
            self.title = title
            self.ctrCls = ctrCls
        }
    }
}
