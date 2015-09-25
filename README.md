##动画引擎
###包含时间函数 和 动画类
###以后还要丰富时间函数，以及更好的面向对象

###链式支持
```
        [sender hq_addAnimation:HQAnimationInstance.damp(3).accelerate(3).durationV(1.5).fromPoint(sender.center).toPoint(CGPointMake(150, sender.center.y == 450 ? 150 : 450)) forKey:nil];
```

###简单的调用
```
    HQPopAnimation *pop = [HQPopAnimation pop];
    [sender.layer addAnimation:pop forKey:nil];
```
