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
	arg_4_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowSceneInfo, arg_4_0._onShowSceneInfo, arg_4_0)
	arg_4_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, arg_4_0._onStartSwitchScene, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0._onCloseView, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_4_0._onOpenView, arg_4_0)
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.MainSceneSkinMaterialTipView then
		MainSceneSwitchDisplayController.instance:setSwitchCompContinue(arg_5_0._curShowSceneId, true)
	end
end

function var_0_0._onOpenView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.MainSceneSkinMaterialTipView then
		MainSceneSwitchDisplayController.instance:setSwitchCompContinue(arg_6_0._curShowSceneId, false)
	end
end

function var_0_0._onShowScene(arg_7_0, arg_7_1)
	MainSceneSwitchDisplayController.instance:showScene(arg_7_1, function()
		WeatherController.instance:FakeShowScene(false)

		arg_7_0._weatherSwitchControlComp = arg_7_0._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._weatherRoot, WeatherSwitchControlComp)

		arg_7_0._weatherSwitchControlComp:updateScene(arg_7_1, MainSceneSwitchDisplayController.instance)
	end)
end

function var_0_0._initSceneRoot(arg_9_0)
	local var_9_0 = GameSceneMgr.instance:getCurScene()
	local var_9_1 = var_9_0 and var_9_0:getSceneContainerGO()
	local var_9_2 = arg_9_0:_getSceneRoot(var_9_1)

	MainSceneSwitchDisplayController.instance:setSceneRoot(var_9_2)
end

function var_0_0._getSceneRoot(arg_10_0, arg_10_1)
	local var_10_0 = "mainSceneSkinRoot"
	local var_10_1 = arg_10_1.transform
	local var_10_2 = var_10_1.childCount

	for iter_10_0 = 1, var_10_2 do
		local var_10_3 = var_10_1:GetChild(iter_10_0 - 1)

		if var_10_3.name == var_10_0 then
			return var_10_3.gameObject
		end
	end

	return (gohelper.create3d(arg_10_1, var_10_0))
end

function var_0_0._onStartSwitchScene(arg_11_0)
	MainSceneSwitchDisplayController.instance:hideScene()
end

function var_0_0._onShowSceneInfo(arg_12_0, arg_12_1)
	arg_12_0._curShowSceneId = arg_12_1
	arg_12_0._curSceneId = MainSceneSwitchModel.instance:getCurSceneId()

	arg_12_0:_onShowScene(arg_12_1)
end

function var_0_0._clearPage(arg_13_0)
	gohelper.setActive(arg_13_0._simageFullBG1, false)
	gohelper.setActive(arg_13_0._simageFullBG2, false)
end

function var_0_0.onTabSwitchOpen(arg_14_0)
	gohelper.setActive(arg_14_0._weatherRoot, true)
	arg_14_0:_changeToPrevScene()
end

function var_0_0._changeToPrevScene(arg_15_0)
	WeatherController.instance:onSceneHide(true)

	if arg_15_0._prevShowSceneId then
		local var_15_0 = arg_15_0._prevShowSceneId

		arg_15_0._prevShowSceneId = nil

		arg_15_0:_onShowScene(var_15_0)
	end
end

function var_0_0._changeToMainScene(arg_16_0)
	arg_16_0._prevShowSceneId = arg_16_0._curShowSceneId

	MainSceneSwitchDisplayController.instance:hideScene()
	WeatherController.instance:onSceneShow()
end

function var_0_0.onTabSwitchClose(arg_17_0)
	gohelper.setActive(arg_17_0._weatherRoot, false)
	arg_17_0:_changeToMainScene()
end

function var_0_0.onClose(arg_18_0)
	arg_18_0:removeEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowSceneInfo, arg_18_0._onShowSceneInfo, arg_18_0)
	arg_18_0:removeEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, arg_18_0._onStartSwitchScene, arg_18_0)
	arg_18_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_18_0._onCloseView, arg_18_0)
	arg_18_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_18_0._onOpenView, arg_18_0)
	MainSceneSwitchDisplayController.instance:clear()
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0:_clearPage()
end

return var_0_0
