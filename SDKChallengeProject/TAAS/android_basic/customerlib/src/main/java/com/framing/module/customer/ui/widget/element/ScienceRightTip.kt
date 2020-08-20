package com.framing.module.customer.ui.widget.element

import android.content.Context
import android.os.Build
import android.util.AttributeSet
import android.view.Gravity
import androidx.annotation.RequiresApi

/*
 * Des  
 * Author Young
 * Date 
 */class ScienceRightTip : ScienceContentView {
    constructor(context: Context) : super(context)
    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs)
    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(
        context,
        attrs,
        defStyleAttr
    )

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    constructor(
        context: Context,
        attrs: AttributeSet?,
        defStyleAttr: Int,
        defStyleRes: Int
    ) : super(context, attrs, defStyleAttr, defStyleRes)


    override fun initView() {
        super.initView()
        binding?.titleView?.run {
            this.gravity=Gravity.LEFT
            this.gravity=Gravity.CENTER_VERTICAL
        }
    }
    /*
   * 根据外层执行进度
   * */
    override fun progress(progress:Float){
        binding?.constraintLayout?.progress=progress
        titleLogic(progress)
    }
    /*
    * 处理title内容 贴边居右 居中居中
    * */
    override fun titleLogic(progress:Float){
        if(progress==1f) {
            binding?.titleView?.gravity = Gravity.CENTER
        }else if(progress==0f){
            binding?.titleView?.gravity = Gravity.LEFT
            binding?.titleView?.gravity = Gravity.CENTER_VERTICAL
        }
    }
}