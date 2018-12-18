import UIKit
import PlaygroundSupport
class MyView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        
        UIColor.red.setStroke()  //红色边界
        path.stroke()
        
        UIColor.blue.setFill()  //黄色填充
        path.fill()
    }
    
}


class myController: UIViewController {
    var oval:MyView!
    override func loadView() {
        view.backgroundColor = UIColor.yellow
        view = UIView(frame: CGRect(x:0,y:0,width:400,height:800))
        oval = MyView(frame: CGRect(x:100,y:100,width:200,height:150))
        oval?.backgroundColor = UIColor.clear
        self.view.addSubview(oval!)
        
        
    }
    
}
