module("modules.logic.effect.view.EffectStatView", package.seeall)

local var_0_0 = class("EffectStatView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnOpen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnOpen")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClose")
	arg_1_0._contentViewGO = gohelper.findChild(arg_1_0.viewGO, "view")

	gohelper.setActive(arg_1_0._btnOpen.gameObject, true)
	gohelper.setActive(arg_1_0._btnClose.gameObject, false)
	gohelper.setActive(arg_1_0._contentViewGO.gameObject, false)
	EffectStatModel.instance:setCameraRootActive()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnOpen:AddClickListener(arg_2_0._onClickOpen, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnOpen:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_3_0._onFrame, arg_3_0)
end

function var_0_0._onClickOpen(arg_4_0)
	gohelper.setActive(arg_4_0._btnOpen.gameObject, false)
	gohelper.setActive(arg_4_0._btnClose.gameObject, true)
	gohelper.setActive(arg_4_0._contentViewGO.gameObject, true)
	TaskDispatcher.runRepeat(arg_4_0._onFrame, arg_4_0, 0.01)
end

function var_0_0._onClickClose(arg_5_0)
	gohelper.setActive(arg_5_0._btnOpen.gameObject, true)
	gohelper.setActive(arg_5_0._btnClose.gameObject, false)
	gohelper.setActive(arg_5_0._contentViewGO.gameObject, false)
	TaskDispatcher.cancelTask(arg_5_0._onFrame, arg_5_0)
end

function var_0_0._onFrame(arg_6_0)
	EffectStatModel.instance:statistic()
end

return var_0_0
