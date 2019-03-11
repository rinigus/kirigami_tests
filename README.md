# Example codes for testing Kirigami

## title shows up on mobile

To run test:

```
QT_QUICK_CONTROLS_MOBILE=1 qmlscene -I /usr/local/lib64/qml preventStealing/App.qml
```

You will see a title of the page that has `globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None`
defined. Works correctly without mobile mode.

Looks like https://bugs.kde.org/show_bug.cgi?id=404481 resurfaced.
