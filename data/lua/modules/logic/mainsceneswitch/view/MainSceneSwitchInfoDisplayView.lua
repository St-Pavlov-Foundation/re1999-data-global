module("modules.logic.mainsceneswitch.view.MainSceneSwitchInfoDisplayView", package.seeall)

local var_0_0 = class("MainSceneSwitchInfoDisplayView", BaseView)

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

	arg_4_0._rawImage = gohelper.onceAddComponent(gohelper.findChild(arg_4_0.viewGO, "RawImage"), gohelper.Type_RawImage)

	gohelper.setActive(arg_4_0._rawImage, false)
	MainSceneSwitchCameraController.instance:clear()
	arg_4_0:_clearPage()
	arg_4_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowPreviewSceneInfo, arg_4_0._onShowSceneInfo, arg_4_0)
end

function var_0_0._onShowSceneInfo(arg_5_0, arg_5_1)
	arg_5_0:_hideMainScene()

	arg_5_0._sceneId = arg_5_1

	MainSceneSwitchCameraController.instance:showScene(arg_5_1, arg_5_0._showSceneFinished, arg_5_0)
end

function var_0_0.adjustRt(arg_6_0, arg_6_1)
	arg_6_0.texture = arg_6_1

	arg_6_0:SetNativeSize()

	local var_6_0 = arg_6_1.width
	local var_6_1 = ViewMgr.instance:getUIRoot().transform
	local var_6_2 = recthelper.getWidth(var_6_1) / var_6_0

	transformhelper.setLocalScale(arg_6_0.transform, var_6_2, var_6_2, 1)
end

function var_0_0._showSceneFinished(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._rawImage, true)
	var_0_0.adjustRt(arg_7_0._rawImage, arg_7_1)

	arg_7_0._weatherSwitchControlComp = arg_7_0._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._weatherRoot, WeatherSwitchControlComp)

	arg_7_0._weatherSwitchControlComp:updateScene(arg_7_0._sceneId, MainSceneSwitchCameraDisplayController.instance)
end

function var_0_0._clearPage(arg_8_0)
	gohelper.setActive(arg_8_0._simageFullBG1, false)
	gohelper.setActive(arg_8_0._simageFullBG2, false)
end

function var_0_0._hideMainScene(arg_9_0)
	arg_9_0._isPreview = arg_9_0.viewParam and arg_9_0.viewParam.isPreview

	if arg_9_0._isPreview then
		MainSceneSwitchDisplayController.instance:hideScene()
	end
end

function var_0_0.onClose(arg_10_0)
	MainSceneSwitchCameraController.instance:clear()

	if arg_10_0._isPreview then
		MainSceneSwitchDisplayController.instance:showCurScene()
	end
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0:_clearPage()
end

return var_0_0
