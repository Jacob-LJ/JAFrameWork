##  JAPlaceholderView 开发点记录

### 1. NSObject+JAPlaceholderViewSwizzling
此分类作用是将类的 Method Swizzlling 的执行方法抽取出来，方便在各种类中指直接调用交换方法

### 2. UITableView+JAPlaceholderView


### UITableView+testLoad 用于测试的类
此类是用于测试多个分类复写+load方法同时swizzle 了 tableview的 reloadData 方法产生的影响test。
多个同样在+load 方法执行 method swizzlling 分类在 build phase 的 complice sources 位置顺序不同会导致+load 方法执行的顺序不同，那就会导致不知道先交换哪一个方法。
1. UITableView+testLoad 在 complice sources 列表最低部，先执行 UITableView+testLoad 的 +load 方法
调用 - TEST_reloadData
调用 - JA_reloadData

2. UITableView+JAPlaceholderView 在 complice sources 列表最低部
调用 - JA_reloadData
调用 - TEST_reloadData

### +load 方法注意点
1. +load 方法执行时机是 被添加到 runtime 时
2. +load 方法调用顺序父类->子类->分类，多个分类之间的调用顺序是，谁在complice sousources 底部先执行谁。

### 分类使用注意点
1. 分类缺陷：名称冲突，即当类别中的方法与原始类方法名称冲突时，类别具有更高的优先级。类别方法将完全取代初始方法从而无法再使用初始方法。
    假设给给UIViewController添加的Category，category 中重写了 UIViewController 的viewDidLoad 方法。在项目中一般都是继承UIViewController，代码都写在子类中的。所以在子类调用super viewDidLoad方法时，就会调用父类的Category方法，父类原方法不走。这样实现了原类（此处原类是继承自 UIViewController 的子类）和 Category 中的方法都被调用的效果，并且可以通过super viewDidLoad方法的位置控制调用时机。简单的方式总结一下就是，Category只会替换当前类方法，对其子类无效。
    
### 综上对 UITableView+JAPlaceholderView 代码功能影响分析
1. 在该分类中在 +load 方法对原类的 reloadData 方法进行 swizzle：
    - 影响：该分类中的+load 方法在文件被加载到 runtime 时候就被执行，即所有 tableview 都会被执行了 reloadData 方法的交换，也就是说以后所有 tableview 执行 reloadData 时候其实调用的都是自定义的方法。
    - 问题：全部都交换方法，影响的范围很大，怎样才可以只指定某个 tabelview 才执行分类方法？
        - 解决办法1：可以将分类的+load 方法功能代码，放到子类化的JAPlaceholderTableView中，让想要 PlaceholderView 的就使用该子类。

















