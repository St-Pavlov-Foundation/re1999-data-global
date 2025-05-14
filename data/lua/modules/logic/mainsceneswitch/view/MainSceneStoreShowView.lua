module("modules.logic.mainsceneswitch.view.MainSceneStoreShowView", package.seeall)

local var_0_0 = class("MainSceneStoreShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_close")
	arg_1_0._goweatherRoot = gohelper.findChild(arg_1_0.viewGO, "left/#go_weatherRoot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goweatherRoot, false)

	arg_5_0._rawImage = gohelper.onceAddComponent(gohelper.findChild(arg_5_0.viewGO, "RawImage"), gohelper.Type_RawImage)

	gohelper.setActive(arg_5_0._rawImage, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._sceneId = arg_7_0.viewParam.sceneId

	MainSceneSwitchCameraController.instance:showScene(arg_7_0._sceneId, arg_7_0._showSceneFinished, arg_7_0)
end

function var_0_0._showSceneFinished(arg_8_0, arg_8_1)
	if not arg_8_0._rawImage then
		return
	end

	gohelper.setActive(arg_8_0._rawImage, true)
	MainSceneSwitchInfoDisplayView.adjustRt(arg_8_0._rawImage, arg_8_1)

	arg_8_0._weatherSwitchControlComp = arg_8_0._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._goweatherRoot, WeatherSwitchControlComp)

	arg_8_0._weatherSwitchControlComp:updateScene(arg_8_0._sceneId, MainSceneSwitchCameraDisplayController.instance)
end

function var_0_0.onClose(arg_9_0)
	if arg_9_0.viewParam.callback then
		arg_9_0.viewParam.callback(arg_9_0.viewParam.callbackObj, arg_9_0.viewParam)

		arg_9_0.viewParam.callback = nil
	end
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
