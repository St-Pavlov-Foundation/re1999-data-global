module("modules.logic.mainsceneswitch.view.MainSceneSwitchNewView", package.seeall)

local var_0_0 = class("MainSceneSwitchNewView", MainSceneSwitchView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_2_0._toSwitchTab, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_3_0._toSwitchTab, arg_3_0)
end

function var_0_0._toSwitchTab(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 1 and arg_4_0.viewContainer:getClassify() == MainSwitchClassifyEnum.Classify.Scene then
		if arg_4_2 == MainEnum.SwitchType.Scene then
			arg_4_0:onTabSwitchOpen()
		else
			arg_4_0:onTabSwitchClose()
		end
	end
end

function var_0_0.onOpen(arg_5_0)
	var_0_0.super.onOpen(arg_5_0)
	arg_5_0:_updateSceneInfo()
	arg_5_0._rootAnimator:Play("open", 0, 0)
end

function var_0_0.onTabSwitchOpen(arg_6_0)
	MainHeroView.resetPostProcessBlur()

	if arg_6_0._rootAnimator then
		arg_6_0._rootAnimator:Play("open", 0, 0)
	end
end

function var_0_0.onTabSwitchClose(arg_7_0)
	return
end

return var_0_0
