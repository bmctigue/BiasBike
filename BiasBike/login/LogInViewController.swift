////////////////////////////////////////////////////////////////////////////
//
// Copyright 2016 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import UIKit

enum LogInViewControllerReturnCode: Int {
    case LogIn
    case Register
    case Cancel
}

class LogInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!

    var completionHandler: ((_ userName: String?, _ password: String?, _ returnCode: LogInViewControllerReturnCode) -> ())?

    override func viewDidLoad() {
        userNameTextField.addTarget(self, action: #selector(updateUI), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(updateUI), for: .editingChanged)
        updateUI()
    }

    @IBAction func logIn(sender: AnyObject?) {
        guard userInputValid() else {
            return
        }
        self.completionHandler?(self.userNameTextField.text, self.passwordTextField.text, .LogIn)
    }
    
    @IBAction func register(sender: AnyObject?) {
        let storyboard = StoryboardFactory().create(name: "RealmSyncLogin")
        let viewController: RegisterViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        viewController.initialUserName = self.userNameTextField.text
        viewController.completionHandler = { userName, password, returnCode in
            if returnCode == .Register {
                self.completionHandler?(userName, password, .Register)
            }
        }
        self.show(viewController, sender: nil)
    }

    @IBAction func cancel(sender: AnyObject?) {
        self.completionHandler?(nil, nil, .Cancel)
    }

    private dynamic func updateUI() {
        logInButton.isEnabled = userInputValid()
    }

    private func userInputValid() -> Bool {
        guard
            let userName = userNameTextField.text , userName.count > 0,
            let password = passwordTextField.text , password.count > 0
        else {
            return false
        }

        return true
    }

}

extension LogInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.userNameTextField {
            self.passwordTextField.becomeFirstResponder()
        } else if textField == self.passwordTextField {
            logIn(sender: nil)
        }

        return false
    }

}

extension LogInViewController: UINavigationBarDelegate {

    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

}
