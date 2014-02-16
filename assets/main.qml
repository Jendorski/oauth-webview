/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.0

Page {
    Container {
        property alias loadingProgress: progressIndicator.value
        id: oauthPage
        layout: DockLayout {
        }
        
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            ScrollView {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                scrollViewProperties {
                    scrollMode: ScrollMode.Vertical
                }
                WebView {
                    id: oauthWebview
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    objectName: "oauthWebView"
                    settings.javaScriptEnabled: true;
                    preferredHeight: Infinity
                    onNavigationRequested: {
                        if (oauthPage.hasOauthToken(request.url)) {
                            request.action = WebNavigationRequestAction.Ignore
                        } else {
                            request.action = WebNavigationRequestAction.Accept
                        }
                    }
                    onLoadProgressChanged: {
                        oauthPage.loadingProgress = loadProgress
                    }
                }
            }
        }
        
        ActivityIndicator {
            visible: false
            objectName: "loader"
            minHeight: 150
            minWidth: 150
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
        }
        
        ProgressIndicator {
            leftPadding: 15
            rightPadding: 15
            bottomPadding: 15
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Bottom
            visible: value > 0 && value < 100
            id: progressIndicator
            fromValue: 0
            toValue: 100
        }
        
        
        function hasOAuthToken(url) {
            return app.parseOAuthToken(url);
        }
    }
}
