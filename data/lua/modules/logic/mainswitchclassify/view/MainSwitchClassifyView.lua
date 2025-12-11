module("modules.logic.mainswitchclassify.view.MainSwitchClassifyView", package.seeall)

local var_0_0 = class("MainSwitchClassifyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg2 = gohelper.findChild(arg_1_0.viewGO, "#go_bg2")
	arg_1_0._gobg1 = gohelper.findChild(arg_1_0.viewGO, "#go_bg1")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "left/#go_left")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_2_0._toSwitchTab, arg_2_0)
	arg_2_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, arg_2_0._onSwitchUIVisible, arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, arg_2_0._onSwitchUIVisible, arg_2_0)
	arg_2_0:addEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, arg_2_0._onSwitchUIVisible, arg_2_0)
	arg_2_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ForceShowSceneTab, arg_2_0._onForceShowSceneTab, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0.refreshReddot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_3_0._toSwitchTab, arg_3_0)
	arg_3_0:removeEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, arg_3_0._onSwitchUIVisible, arg_3_0)
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, arg_3_0._onSwitchUIVisible, arg_3_0)
	arg_3_0:removeEventCb(ClickUISwitchController.instance, ClickUISwitchEvent.SwitchVisible, arg_3_0._onSwitchUIVisible, arg_3_0)
	arg_3_0:removeEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ForceShowSceneTab, arg_3_0._onForceShowSceneTab, arg_3_0)
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0.refreshReddot, arg_3_0)
end

function var_0_0._onForceShowSceneTab(arg_4_0)
	arg_4_0.viewContainer:switchClassifyTab(MainSwitchClassifyEnum.Classify.Scene)
end

function var_0_0._toSwitchTab(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == arg_5_0._tabContainerId then
		arg_5_0._tabId = arg_5_2
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._rootAnimator = arg_6_0.viewGO:GetComponent("Animator")
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0._onSwitchUIVisible(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goleft, arg_8_1)
	arg_8_0._rootAnimator:Play(arg_8_1 and "open" or "close", 0, 0)
end

function var_0_0.onOpen(arg_9_0)
	MainSwitchClassifyListModel.instance:initMoList()

	arg_9_0._tabContainerId = 3
	arg_9_0._tabId = arg_9_0.viewParam.defaultTabIds[1]
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:_clearScene()
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.onTabSwitchOpen(arg_12_0)
	MainHeroView.resetPostProcessBlur()
	arg_12_0._rootAnimator:Play("open", 0, 0)
end

function var_0_0.onTabSwitchClose(arg_13_0, arg_13_1)
	arg_13_0:_clearScene()
end

function var_0_0._clearScene(arg_14_0)
	WeatherController.instance:FakeShowScene(true)
	MainHeroView.setPostProcessBlur()
end

function var_0_0.refreshReddot(arg_15_0)
	MainSwitchClassifyListModel.instance:onModelUpdate()
end

return var_0_0
