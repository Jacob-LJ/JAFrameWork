## MainTabBar 内的子控制器命名使用不带前缀JA 命名
1、因为tabBar下的功能是全项目的大功能模块，大模块的命名就如文件夹命名一样，不需要带前缀

如下是一个Main文件夹下的结构， App 有四个功能能（推荐、发现、充值、会员），如下是命名规则：
.
├── MainTabBarController.h
├── MainTabBarController.m
├── Deposit
│   ├── DepositController.h
│   ├── DepositController.m
│   ├── Networking
│   ├── Controller
│   ├── Model
│   └── View
├── Discovery
│   ├── DiscoveryController.h
│   ├── DiscoveryController.m
│   ├── Networking
│   ├── Controller
│   ├── Model
│   └── View
├── Member
│   ├── MemberController.h
│   ├── MemberController.m
│   ├── Networking
│   │   ├── MemberNetwork.h
│   │   └── MemberNetwork.m
│   ├── Controller
│   ├── Model
│   └── View
└── Recommend
        ├── RecommendController.h
        ├── RecommendController.m
        ├── Networking
        ├── Controller
        ├── Model
        └── View
        
1、直接按功能名区分出四大功能文件夹
2、单个功能文件下按：主入口 VC（DepositController） + Controller + Model + View + Networking 等文件夹区分
3、Controller 是放子功能的VC 的，此时内部 VC 命名则为：上一层功能名缩写为前缀+当前功能名+Controller，如：
├── Deposit
│   ├── DepositController.h
│   ├── DepositController.m
│   ├── Networking
│   ├── Controller
│   │   └── UserComment
│   │         ├── UCOrderDisplay.h
│   │         └── UCOrderDisplay.m
│   ├── Model
│   └── View


