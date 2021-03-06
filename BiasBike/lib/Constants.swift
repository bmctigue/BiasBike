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

import Foundation

struct Constants {
//    static let syncHost = localIPAddress
    static let syncHost = "biasbike.us1a.cloud.realm.io"

    static let syncRealmPath = "biasbike"
    static let defaultListName = "BiasBike"
    static let defaultListID = "80EB1620-165B-4600-A1B1-D97032FDD121"

    static let syncServerURL = NSURL(string: "realms://\(syncHost)/\(syncRealmPath)")
    static let syncAuthURL = NSURL(string: "https://\(syncHost)")!

    static let appID = Bundle.main.bundleIdentifier!
}
