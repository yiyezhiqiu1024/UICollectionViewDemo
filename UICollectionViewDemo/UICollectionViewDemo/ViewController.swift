//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by Anthony on 17/2/21.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //==========================================================================================================
    // MARK: - 自定义属性
    //==========================================================================================================

    /// cell的标识符
    let cellIdentifier = "Cell"
    
    //==========================================================================================================
    // MARK: - 懒加载
    //==========================================================================================================

    /// 存放Cell模型数据的数组
    lazy var itemsList: [CellItem] = {
        () -> [CellItem]
        in
        return CellItem.itemList()
        
    }()
    
    //==========================================================================================================
    // MARK: - 系统初始化方法
    //==========================================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 导航条右边按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一页", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.nextPageClick))
        
        // 布局
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.itemSize = CGSize(width: 60, height: 90)
        layout.minimumLineSpacing = 10.0 // 上下间隔
        layout.minimumInteritemSpacing = 5.0 // 左右间隔
        layout.headerReferenceSize = CGSize(width: 20, height: 20)
        layout.footerReferenceSize = CGSize(width: 20, height: 20)
        
        // collectionView
        let collection = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.whiteColor()
        collection.dataSource = self
        collection.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        // 注册Cell
        let nib = UINib(nibName: "\(CustomCell.self)", bundle: nil)
        collection.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
        
        
        view.addSubview(collection)
        
    }

    
    //==========================================================================================================
    // MARK: - 处理监听事件
    //==========================================================================================================

    /**
     监听导航条右边按钮点击
     */
    func nextPageClick() {
        
        self.navigationController?.pushViewController(NextPageViewController(), animated: true)
    }
    
    /**
     开始下载
     */
    func download(button: UIButton) {
        print(#function)
    }

}

//==========================================================================================================
// MARK: - UICollectionViewDataSource
//==========================================================================================================

extension ViewController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
        return itemsList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        // 从缓存池中获取cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomCell
        
        // 获取模型
        let items = self.itemsList[indexPath.item]
        
        cell.image = items.image
        cell.text = items.name
        cell.downloadButton.addTarget(self, action: #selector(ViewController.download(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    
}