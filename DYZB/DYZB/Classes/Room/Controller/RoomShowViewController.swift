//
//  RoomShowController.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/8.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

class RoomShowViewController: UIViewController {
    
    var maskImageView : UIImageView?
      var anchor: AnchorModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}

extension RoomShowViewController{
    fileprivate func setupUI() {
        let imageView = UIImageView()
        imageView.frame = self.view.bounds
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = imageView.bounds
        imageView.addSubview(effectView)
        guard let icon_URL = URL(string: (anchor?.vertical_src)!) else { return }
        imageView.kf.setImage(with: icon_URL)
        self.maskImageView = imageView
        view.addSubview(maskImageView!)
    }
}
