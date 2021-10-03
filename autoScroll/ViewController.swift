//
//  ViewController.swift
//  autoScroll
//
//  Created by IwasakIYuta on 2021/09/27.
//

import UIKit

class ViewController: UIViewController {
    
     struct Photo {
         var imageName: String
     }
     //"gear","magnifyingglass","clock"
     var photoList = [
         Photo(imageName: "gear"),
         Photo(imageName: "magnifyingglass"),
         Photo(imageName: "clock")
     ]
     
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        // メニュー単位のスクロールを可能にする
       
        // 水平方向のスクロールインジケータを非表示にする
       // scrollView.showsHorizontalScrollIndicator = false
       
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
   
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
         pageControl.numberOfPages = 3
         // pageControlのドットの色
         pageControl.pageIndicatorTintColor = UIColor.lightGray
         // pageControlの現在のページのドットの色
         pageControl.backgroundColor = .green
         pageControl.currentPageIndicatorTintColor = UIColor.black
        return pageControl
    }()
    private var button: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .orange
        button.titleLabel?.text = "戻る"
        button.setTitle("戻る", for: UIControl.State.normal)
        button.tintColor = .white
        return button
    }()
     
     private var offsetX: CGFloat = 0
     private var timer: Timer!
     
     override func viewDidLoad() {
         super.viewDidLoad()
      let frameGuide = scrollView.frameLayoutGuide
  
//
         
         // scrollViewの画面表示サイズを指定
//         scrollView = UIScrollView(frame: CGRect(x: 0, y: 200, width: view.frame.size.width, height: view.frame.size.height ))
         // scrollViewのサイズを指定（幅は1メニューに表示するViewの幅×ページ数）
        
         // scrollViewのデリゲートになる
         scrollView.delegate = self
         scrollView.backgroundColor = .green
         
         view.addSubview(scrollView)
        
         //pageControl.frame = CGRect(x: 0, y: 370, width: view.frame.size.width, height: 30)
       
        // pageControl.translatesAutoresizingMaskIntoConstraints = false
         
         view.addSubview(pageControl)
        
        frameGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
       frameGuide.topAnchor.constraint(equalTo:  pageControl.bottomAnchor, constant: -5).isActive = true
      frameGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         frameGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -150).isActive = true

         
         
//         scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//       scrollView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: -10).isActive = true
////
//         scrollView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor).isActive = true
//         scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
//////         scrollView.topAnchor.constraint(equalTo: pageControl.bottomAnchor,constant: -600).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -150).isActive = true
////
         // scrollView上にUIImageViewを配置
         setUpImageView()
         
         // pageControlの表示位置とサイズの設定
         // pageControlのページ数を設定
         pageControl.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 0),size: .init(width: view.frame.size.width, height: 20))
         pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         view.addSubview(button)
         
         button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         button.anchor(top: scrollView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 5, left:30 , bottom: 100, right: 30))
         //pageControl.heightAnchor.constraint(equalTo: view.heightAnchor,constant: -1).isActive = true
         // pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
         // タイマーを作成
         self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.scrollPage), userInfo: nil, repeats: true)
     }
     
     // タイマーを破棄
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         if let workingTimer = self.timer {
             workingTimer.invalidate()
         }
     }
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
       scrollView.isPagingEnabled = true
        //scrollView.isScrollEnabled = true
        //scrollView.isScrollEnabled = true
        //scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.contentSize = CGSize(width: view.frame.size.width * 3, height: view.frame.size.height / 2)

    }

     // UIImageViewを生成
     func createImageView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, image: Photo) -> UIImageView {
         let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
         let image = UIImage(systemName:  image.imageName)
         imageView.image = image
         return imageView
     }
     
     // photoListの要素分UIImageViewをscrollViewに並べる
     func setUpImageView() {
         for i in 0 ..< self.photoList.count {
             let photoItem = self.photoList[i]
             let imageView = createImageView(x: 0, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height , image: photoItem)
             imageView.frame = CGRect(origin: CGPoint(x: self.scrollView.frame.size.width * 3, y: 0), size: CGSize(width: self.scrollView.frame.size.width - 100, height: view.frame.size.height / 2 - 50))
             
            imageView.translatesAutoresizingMaskIntoConstraints = false
             imageView.backgroundColor = .gray
             
             scrollView.addSubview(imageView)
//             let contentGuide = scrollView.contentLayoutGuide
             imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor,constant: view.frame.size.width * CGFloat(i)).isActive = true
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true

//             contentGuide.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
//              contentGuide.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
//              contentGuide.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
//              contentGuide.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
//             contentGuide.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true

             imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,constant:  -20).isActive = true
             imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor,constant: -20).isActive = true
//
//             imageView.topAnchor.constraint(equalTo:scrollView.topAnchor,constant: -50).isActive = true
//             imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -150).isActive = true
         }
     }

    
    
    
    
    
    
    
    //
//     // offsetXの値を更新することページを移動
     @objc func scrollPage() {
         // 画面の幅分offsetXを移動
         self.offsetX += self.view.frame.size.width
         // 3ページ目まで移動したら1ページ目まで戻る
         if self.offsetX < self.view.frame.size.width * 3 {
             UIView.animate(withDuration: 0.3) {
                 self.scrollView.contentOffset.x = self.offsetX
             }
         } else {
             UIView.animate(withDuration: 0.3) {
                 self.offsetX = 0
                 self.scrollView.contentOffset.x = self.offsetX
             }
         }
     }
 }

 extension ViewController: UIScrollViewDelegate {
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         // scrollViewのページ移動に合わせてpageControlの表示も移動
         self.pageControl.currentPage = Int(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)
         // offsetXの値を更新
         self.offsetX = self.scrollView.contentOffset.x
     }


}

