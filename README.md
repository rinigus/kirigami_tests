# Example codes for testing Kirigami

## columnsView test 1

Bug with horizontal dragging of the map is visible if you 
run 

```
qmlscene -I /usr/local/lib64/qml maponroot/App.qml
```

Replace `-I /usr/local/lib64/qml` with the local installation
path of the development Kirigami. 

You can drag map up/down, but if you *start* the dragging action in
horizontal direction, the map will be staying still. 

In earlier Kirigami versions, all worked as expected.


## columnsView test 2

Run `mapandpage/App.qml` with `qmlscene` again. At start, Buttons page
is active. Select the map and try to select Buttons page again. The
selection will make Buttons active for a short period and will become
inactive again.

