module("modules.logic.mainsceneswitch.view.MainSceneSwitchDisplayView", package.seeall)

local var_0_0 = class("MainSceneSwitchDisplayView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg1 = gohelper.findChild(arg_1_0.viewGO, "#go_bg1")
	arg_1_0._gobg2 = gohelper.findChild(arg_1_0.viewGO, "#go_bg2")
	arg_1_0._simageFullBG1 = gohelper.findChildSingleImage(arg_1_0._gobg1, "img")
	arg_1_0._simageFullBG2 = gohelper.findChildSingleImage(arg_1_0._gobg2, "img")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._weatherRoot = gohelper.findChild(arg_4_0.viewGO, "left/#go_weatherRoot")

	gohelper.setActive(arg_4_0._weatherRoot, false)
	MainSceneSwitchDisplayController.instance:initMaps()
	arg_4_0:_initSceneRoot()
	arg_4_0:_clearPage()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowSceneInfo, arg_5_0._onShowSceneInfo, arg_5_0)
	arg_5_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, arg_5_0._onStartSwitchScene, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_5_0._onCloseView, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_5_0._onOpenView, arg_5_0)
end

function var_0_0._onCloseView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.MainSceneSkinMaterialTipView then
		MainSceneSwitchDisplayController.instance:setSwitchCompContinue(arg_6_0._curShowSceneId, true)
	end
end

function var_0_0._onOpenView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.MainSceneSkinMaterialTipView then
		MainSceneSwitchDisplayController.instance:setSwitchCompContinue(arg_7_0._curShowSceneId, false)
	end
end

function var_0_0._onShowScene(arg_8_0, arg_8_1)
	MainSceneSwitchDisplayController.instance:showScene(arg_8_1, function()
		WeatherController.instance:FakeShowScene(false)

		arg_8_0._weatherSwitchControlComp = arg_8_0._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._weatherRoot, WeatherSwitchControlComp)

		arg_8_0._weatherSwitchControlComp:updateScene(arg_8_1, MainSceneSwitchDisplayController.instance)
	end)
end

function var_0_0._initSceneRoot(arg_10_0)
	local var_10_0 = GameSceneMgr.instance:getCurScene()
	local var_10_1 = var_10_0 and var_10_0:getSceneContainerGO()
	local var_10_2 = arg_10_0:_getSceneRoot(var_10_1)

	MainSceneSwitchDisplayController.instance:setSceneRoot(var_10_2)
end

function var_0_0._getSceneRoot(arg_11_0, arg_11_1)
	local var_11_0 = "mainSceneSkinRoot"
	local var_11_1 = arg_11_1.transform
	local var_11_2 = var_11_1.childCount

	for iter_11_0 = 1, var_11_2 do
		local var_11_3 = var_11_1:GetChild(iter_11_0 - 1)

		if var_11_3.name == var_11_0 then
			return var_11_3.gameObject
		end
	end

	return (gohelper.create3d(arg_11_1, var_11_0))
end

function var_0_0._onStartSwitchScene(arg_12_0)
	MainSceneSwitchDisplayController.instance:hideScene()
end

function var_0_0._onShowSceneInfo(arg_13_0, arg_13_1)
	arg_13_0._curShowSceneId = arg_13_1
	arg_13_0._curSceneId = MainSceneSwitchModel.instance:getCurSceneId()

	arg_13_0:_onShowScene(arg_13_1)
end

function var_0_0._clearPage(arg_14_0)
	gohelper.setActive(arg_14_0._simageFullBG1, false)
	gohelper.setActive(arg_14_0._simageFullBG2, false)
end

function var_0_0.onTabSwitchOpen(arg_15_0)
	arg_15_0._isShowView = true

	arg_15_0:showTab()
end

function var_0_0.showTab(arg_16_0)
	gohelper.setActive(arg_16_0._weatherRoot, true)
	arg_16_0:_changeToPrevScene()
end

function var_0_0._changeToPrevScene(arg_17_0)
	WeatherController.instance:onSceneHide(true)

	if arg_17_0._prevShowSceneId then
		local var_17_0 = arg_17_0._prevShowSceneId

		arg_17_0._prevShowSceneId = nil

		arg_17_0:_onShowScene(var_17_0)
	end
end

function var_0_0._changeToMainScene(arg_18_0)
	arg_18_0._prevShowSceneId = arg_18_0._curShowSceneId

	MainSceneSwitchDisplayController.instance:hideScene()
	WeatherController.instance:onSceneShow()
end

function var_0_0.onTabSwitchClose(arg_19_0)
	arg_19_0._isShowView = false

	arg_19_0:hideTab()
end

function var_0_0.hideTab(arg_20_0)
	gohelper.setActive(arg_20_0._weatherRoot, false)
	arg_20_0:_changeToMainScene()
end

function var_0_0.isShowView(arg_21_0)
	return arg_21_0._isShowView
end

function var_0_0.onClose(arg_22_0)
	arg_22_0:removeEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowSceneInfo, arg_22_0._onShowSceneInfo, arg_22_0)
	arg_22_0:removeEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, arg_22_0._onStartSwitchScene, arg_22_0)
	arg_22_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_22_0._onCloseView, arg_22_0)
	arg_22_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_22_0._onOpenView, arg_22_0)
	MainSceneSwitchDisplayController.instance:clear()
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0:_clearPage()
end

return var_0_0
