# Example codes for testing Kirigami

## preventStealing ignored

To run test:

```
qmlscene -I /usr/local/lib64/qml preventStealing/App.qml
```

Try to press a mouse left button and drag cursor up and down while
keeping mouse button down. This will update coordinates, shown in the
middle, as expected. If you try to move the mouse left and right,
coordinates update will stop very soon.
