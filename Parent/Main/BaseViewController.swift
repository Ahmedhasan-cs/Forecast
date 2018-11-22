
import UIKit
import MRProgress

class BaseViewController: UIViewController {
    var alert :UIAlertController!
    var parentVC:BaseViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        self.hideLoader()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showAlertWithText(txt:String?){
        if(txt == nil){
            return 
        }
        let alertController = UIAlertController(title: "", message:txt, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func showLoader(){
        //let window = UIApplication.shared.keyWindow
        MRProgressOverlayView.dismissAllOverlays(for: self.view, animated: true)

        var mainV:UIView?
        if(self.parentVC != nil){
            mainV = self.parentVC?.view
        }else{
            mainV = self.view

        }
       MRProgressOverlayView.showOverlayAdded(to: mainV, title: "", mode: MRProgressOverlayViewMode.indeterminateSmall, animated: true)
        
    }
    
    func hideLoader(){
      //  let window = UIApplication.shared.keyWindow
        var mainV:UIView?
        if(self.parentVC != nil){
            mainV = self.parentVC?.view
        }else{
            mainV = self.view
            
        }
        MRProgressOverlayView.dismissAllOverlays(for: mainV, animated: true)

    }
    
    
    
    func showToast(txt:String){
       // KSToastView.ks_showToast(txt)
    }
   
}
