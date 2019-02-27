# Example codes for testing Kirigami

## index trouble

There are unexpected changes in `pageStack.currentIndex` that 
would be great to fix. 

To run test:

```
qmlscene -I /usr/local/lib64/qml confusedIndex/App.qml
```

Replace `-I /usr/local/lib64/qml` with the local installation
path of the development Kirigami. 

In the app, changes of pageStack depth and currentIndex are
logged. The app is expected to drop all pages but the first one if
page #0 will become active. In the beginning, placeholder initPage is
replaced by the correct one.

In running application:

* press "Click me" button on page 0
* on page #1, press "Click me: New page" main action
* on page #2, press "Click me: pop page" main action
* on page #1, press "Click me: New page" main action
* test fails with page #2 taking place of page #1 instead of being added

Console log below with expected values inserted as comments

```
> qmlscene -I /usr/local/lib64/qml confusedIndex/App.qml
     1	qt5ct: using qt5ct plugin
     2	Empty filename passed to function
     3	qml: Replacing page. Depth: 1 / currentIndex: 0
     4	qml: currentIndex changed: -1 / depth: 1
     ```
Here, currentIndex should stay 0 if possible. Or -1 should be
dedicated as invalid index (maybe it is already)

```
     5	qml: Depth changed: 0
     6	qml: Depth changed: 1
     7	qml: currentIndex changed: 0 / depth: 1
     8	qml: Page replaced
     9	<Unknown File>:7: TypeError: Cannot read property 'contentX' of null
    10	QGeoTileProviderOsm: Tileserver disabled at  QUrl("http://maps-redirect.qt.io/osm/5.8/satellite")
    11	QGeoTileFetcherOsm: all providers resolved
    12	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:269: TypeError: Cannot read property 'a' of undefined
    13	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:322: TypeError: Cannot read property 'a' of undefined
    14	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:368: TypeError: Cannot read property 'a' of undefined
    15	file:///usr/local/lib64/qml/org/kde/kirigami.2/Page.qml:282: TypeError: Cannot read property 'globalToolBar' of null
    16	qml: Depth changed: 2
    17	qml: currentIndex changed: 1 / depth: 2
    18	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:269: TypeError: Cannot read property 'a' of undefined
    19	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:322: TypeError: Cannot read property 'a' of undefined
    20	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:368: TypeError: Cannot read property 'a' of undefined
    21	file:///usr/local/lib64/qml/org/kde/kirigami.2/Page.qml:282: TypeError: Cannot read property 'globalToolBar' of null
    22	qml: Depth changed: 3
    23	qml: currentIndex changed: 2 / depth: 3
    24	qml: currentIndex changed: 1 / depth: 3
    25	<Unknown File>:7: TypeError: Cannot read property 'contentX' of null
    26	qml: Depth changed: 2
    27	qml: currentIndex changed: 0 / depth: 2
    ```
    
Here, currentIndex should stay as 1; value 0 is unexpected and breaks the logic
leading to application bug.
    
    ```
    28	<Unknown File>:7: TypeError: Cannot read property 'contentX' of null
    29	qml: Depth changed: 1
    30	file:///usr/local/lib64/qml/org/kde/kirigami.2/Page.qml:282: TypeError: Cannot read property 'globalToolBar' of null
    31	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:269: TypeError: Cannot read property 'a' of undefined
    32	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:322: TypeError: Cannot read property 'a' of undefined
    33	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:368: TypeError: Cannot read property 'a' of undefined
    34	file:///usr/local/lib64/qml/org/kde/kirigami.2/Page.qml:364: TypeError: Cannot read property 'currentIndex' of null
    35	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:269: TypeError: Cannot read property 'a' of undefined
    36	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:322: TypeError: Cannot read property 'a' of undefined
    37	file:///usr/local/lib64/qml/org/kde/kirigami.2/private/ActionButton.qml:368: TypeError: Cannot read property 'a' of undefined
    38	file:///usr/local/lib64/qml/org/kde/kirigami.2/Page.qml:282: TypeError: Cannot read property 'globalToolBar' of null
    39	qml: Depth changed: 2
    40	qml: currentIndex changed: 1 / depth: 2
```

