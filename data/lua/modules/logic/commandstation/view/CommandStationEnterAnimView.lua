module("modules.logic.commandstation.view.CommandStationEnterAnimView", package.seeall)

local var_0_0 = class("CommandStationEnterAnimView", BaseView)

function var_0_0.onInitView(arg_1_0)
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
	arg_4_0._simagezhuanpan = gohelper.findChildSingleImage(arg_4_0.viewGO, "#image_zhuanpan")

	local var_4_0 = WeatherController.instance:getCurLightMode() or WeatherEnum.LightModeDuring

	arg_4_0._simagezhuanpan:LoadImage(string.format("singlebg/commandstation/enteranim/commandstation_enterzhuanpan_type%s.png", var_4_0))
	arg_4_0:_initCamera()
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0._OnOpenView, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_4_0._openPostProcess, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0._openPostProcess, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0._openPostProcess, arg_4_0, LuaEventSystem.Low)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_open)
end

function var_0_0._initCamera(arg_5_0)
	if arg_5_0._cameraPlayer then
		return
	end

	local var_5_0 = CameraMgr.instance:getCameraRootAnimator()
	local var_5_1 = arg_5_0.viewContainer:getSetting().otherRes[1]

	var_5_0.runtimeAnimatorController = arg_5_0.viewContainer._abLoader:getAssetItem(var_5_1):GetResource()
	var_5_0.enabled = true

	var_5_0:Play("in", 0, 0)
end

function var_0_0._OnOpenView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.CommandStationEnterView then
		gohelper.setAsLastSibling(arg_6_0.viewGO)
		arg_6_0:closeThis()

		local var_6_0 = ViewMgr.instance:getContainer(ViewName.MainView)

		if var_6_0 then
			var_6_0:setVisibleInternal(false)
		end
	end
end

function var_0_0.onOpen(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._openPostProcess, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0._openPostProcess, arg_7_0, 0)
end

function var_0_0._openPostProcess(arg_8_0)
	PostProcessingMgr.instance:setUIActive(true)
end

function var_0_0.onOpenFinish(arg_9_0)
	CommandStationController.instance:openCommandStationEnterView()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onCloseFinish(arg_11_0)
	CameraMgr.instance:getCameraRootAnimator().runtimeAnimatorController = nil

	TaskDispatcher.cancelTask(arg_11_0._openPostProcess, arg_11_0)
	PostProcessingMgr.instance:setUnitPPValue("radialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("RadialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("rgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("splitPercent", 0)
	PostProcessingMgr.instance:setUnitPPValue("SplitPercent", 0)

	local var_11_0 = Vector2(0.5, 0.5)

	PostProcessingMgr.instance:setUnitPPValue("rgbSplitCenter", var_11_0)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitCenter", var_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
