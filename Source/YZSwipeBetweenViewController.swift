//
//  Copyright (c) 2016-present Yichi Zhang
//  https://github.com/yichizhang
//  zhang-yi-chi@hotmail.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

import Foundation
import UIKit

class YZSwipeBetweenViewController: UIViewController {
  
  lazy private var container: UIPageViewController = {
    return UIPageViewController(
      transitionStyle: UIPageViewControllerTransitionStyle.scroll,
      navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal,
      options: nil
    )
  }()
  
  @objc var viewControllers: [UIViewController] = [] {
    didSet {
      if viewAppeared {
        set(index: 0, animated: true)
      }
    }
  }
  
  @objc var currentIndex: Int {
    get {
      return containerIndex ?? 0
    }
    set {
      pendingIndex = newValue
      
      if viewAppeared {
        set(index: pendingIndex, animated: true)
      }
    }
  }
  
  private var pendingIndex: Int = 0
  
  private var currentViewController: UIViewController? {
    return container.viewControllers?.first
  }
  
  private var containerIndex: Int? {
    if let currentViewController = currentViewController {
      return viewControllers.index(of: currentViewController)
    }
    return nil
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpView()
  }
  
  private var isFirstAppear = true
  private var viewAppeared = false
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if isFirstAppear {
      set(index: pendingIndex, animated: false)
    }
    
    isFirstAppear = false
    viewAppeared = true
  }
  
  private func setUpView() {
    
    container.dataSource = self
    container.delegate = self
    
    addVC(container)
    container.view.attachEdges()
  }
  
  fileprivate func nextViewController(delta: Int) -> UIViewController? {
    
    if let containerIndex = containerIndex {
      return viewController(at: containerIndex + delta)
    }
    return nil
  }
  
  fileprivate func viewController(at index: Int) -> UIViewController? {
    
    if index > -1 && index < viewControllers.count {
      return viewControllers[index]
    }
    return nil
  }
  
  private func set(index: Int, animated: Bool) {
    
    if let vc = viewController(at: index) {
      let direction: UIPageViewControllerNavigationDirection =
        (index > (containerIndex ?? -1)) ? .forward : .reverse
      container.setViewControllers([vc], direction: direction, animated: animated, completion: nil)
    }
  }
  
  @objc func setCurrentIndex(_ index: Int, animated: Bool) {
    
    if viewAppeared {
      set(index: index, animated: animated)
    }
    else {
      currentIndex = index
    }
  }
  
}

extension YZSwipeBetweenViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    return self.nextViewController(delta: -1)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    return self.nextViewController(delta: 1)
  }
  
}

extension YZSwipeBetweenViewController: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
  }
  
}

private extension UIView {
  
  func attachEdges() {
    let contentView = superview!
    
    topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
    leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0)
    bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
    rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0)
  }
}

private extension UIViewController {
  
  func addVC(_ vc: UIViewController, to contentView: UIView? = nil) {
    vc.willMove(toParentViewController: self)
    
    self.addChildViewController(vc)
    (contentView ?? view).addSubview(vc.view)
    
    vc.didMove(toParentViewController: self)
  }
  
  func removeFromParentVC() {
    self.willMove(toParentViewController: nil)
    
    self.view.removeFromSuperview()
    self.removeFromParentViewController()
    
    self.didMove(toParentViewController: nil)
  }
}
