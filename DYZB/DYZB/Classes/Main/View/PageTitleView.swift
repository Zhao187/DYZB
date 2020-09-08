//
//  PageTitleView.swift
//  DYZB
//
//  Created by 赵宏图 on 2020/9/4.
//  Copyright © 2020 赵宏图. All rights reserved.
//

import UIKit

//MARK: 定义协议
protocol PageTitleViewDelegate:class {
    func pageTitleView(titleView:PageTitleView,selectedIndex index:Int)
}

//MARK: 定义常量
private let KScrollLineH:CGFloat = 2
private let KNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let KSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

//MARK: 定义PageTitleView的类
class PageTitleView: UIView {
    
    private var titles: [String]
    
    private lazy var titleLabels:[UILabel] = [UILabel]()
    
    private var curIndex = 0
    
    weak var delegate : PageTitleViewDelegate?
    
    //MARK - 懒加载属性
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    
    //1.自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not been implemented")
    }
}

//MARK: - 设置UI界面
extension PageTitleView
{
    private func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabels()
        
        //设置分割线和滚动滑块
        setupBottonLineAndScrollLine()
        
    }
    
    private func setupTitleLabels(){
        
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        let labelH:CGFloat = frame.height - KScrollLineH
        let labelY:CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.tag = index
            label.text = title
            label.textColor = UIColor.init(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16.0)
            
            //设置label的frame
            let labelX:CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            
            //4.label添加scrollview中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.label添加手势
            label.isUserInteractionEnabled = true
            let tagGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tagGes:)))
            label.addGestureRecognizer(tagGes)
        }
    }
    
    private func setupBottonLineAndScrollLine()
    {
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        let lineH:CGFloat = 0.5
        
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(bottomLine)
        
        //添加scrollLine
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.init(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2)
        addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KScrollLineH,
                                  width: firstLabel.frame.width, height: KScrollLineH)
    }
}

//MARK: - 监听label的点击
extension PageTitleView
{
    @objc private func titleLabelClick(tagGes:UITapGestureRecognizer)
    {
        
        //1.获取当前label下标志
        guard let curLabel = tagGes.view as? UILabel else {return}
        
        // 如果相同操作不处理
        if curLabel.tag == curIndex {return}
        
        //2.获取之前的label
        let oldLabel = titleLabels[curIndex]
        
        //3.切换文字颜色
        curLabel.textColor =  UIColor.init(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2)
        oldLabel.textColor = UIColor.init(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
        
        //4.保存新的index
        curIndex = curLabel.tag
        
        //5.滚动条位置
        let scrollLineX = CGFloat(curLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(titleView: self, selectedIndex: curIndex)
    }
}

//MARK: - 对外暴露方法
extension PageTitleView
{
    func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //处理滑块逻辑
        let moveTotalX=targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3。文字颜色渐变
        //3.1取出变化范围
        let colorDelat = (KSelectColor.0 - KNormalColor.0,KSelectColor.1 - KNormalColor.1,KSelectColor.2-KNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: KSelectColor.0 - colorDelat.0 * progress, g: KSelectColor.1 - colorDelat.1 * progress, b: KSelectColor.2 - colorDelat.2 * progress)
        
        targetLabel.textColor = UIColor(r: KNormalColor.0 + colorDelat.0 * progress, g: KNormalColor.1 + colorDelat.1 * progress, b: KNormalColor.2 + colorDelat.2 * progress)
        
        //4. 记录最新的index
        curIndex = targetIndex
        
    }
}
