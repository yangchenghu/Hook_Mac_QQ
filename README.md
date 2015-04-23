##2015-04-23 更新

1. 添加了一个关闭dock栏显示未读消息数的功能，而且可以随时打开关闭该功能。

   打开该功能，只需要去`~/Library/Containers/com.tencent.qq/Data/`目录下创建一个`qqshowunrad`的文件就可以显示，如果不想让那个数字打扰，就删掉这个文件就好了。

---


 1. compile this project
 2. copy `QQPlugin.dylib` to path
 3. use `DYLD_INSERT_LIBRARIES=/path/QQPlugin.dylib /Applications/QQ.app/Contents/MacOS/QQ &`  in Terminal to start your Mac QQ Client

 PS: test in Mac QQ Client v2.4.1