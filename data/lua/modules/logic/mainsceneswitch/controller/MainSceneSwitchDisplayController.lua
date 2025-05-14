module("modules.logic.mainsceneswitch.controller.MainSceneSwitchDisplayController", package.seeall)

local var_0_0 = class("MainSceneSwitchDisplayController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.clear(arg_5_0)
	if arg_5_0._loaderMap then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._loaderMap) do
			iter_5_1:dispose()
		end

		tabletool.clear(arg_5_0._loaderMap)
	end

	if arg_5_0._weatherCompMap then
		for iter_5_2, iter_5_3 in pairs(arg_5_0._weatherCompMap) do
			for iter_5_4, iter_5_5 in ipairs(iter_5_3) do
				iter_5_5:onSceneClose()
			end
		end

		tabletool.clear(arg_5_0._weatherCompMap)
	end

	if arg_5_0._sceneNameMap then
		for iter_5_6, iter_5_7 in pairs(arg_5_0._sceneNameMap) do
			gohelper.destroy(iter_5_7)
		end

		tabletool.clear(arg_5_0._sceneNameMap)
	end

	arg_5_0._sceneRoot = nil
	arg_5_0._callback = nil
	arg_5_0._callbackTarget = nil
end

function var_0_0.hasSceneRoot(arg_6_0)
	return arg_6_0._sceneRoot ~= nil
end

function var_0_0.removeScene(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0, var_7_1 = arg_7_0:_getSceneConfig(arg_7_1)

	if arg_7_2 then
		local var_7_2 = arg_7_0._sceneNameMap[var_7_1]

		gohelper.destroy(var_7_2)
		gohelper.setActive(var_7_2, false)

		local var_7_3 = arg_7_0._loaderMap[var_7_1]

		if var_7_3 then
			var_7_3:dispose()

			arg_7_0._loaderMap[var_7_1] = nil
		end
	end

	arg_7_0._sceneNameMap[var_7_1] = nil

	local var_7_4 = arg_7_0._weatherCompMap[var_7_1]

	if var_7_4 then
		for iter_7_0, iter_7_1 in ipairs(var_7_4) do
			iter_7_1:onSceneClose()
		end

		arg_7_0._weatherCompMap[var_7_1] = nil
	end
end

function var_0_0.initMaps(arg_8_0)
	arg_8_0._loaderMap = {}
	arg_8_0._sceneNameMap = {}
	arg_8_0._weatherCompMap = {}
end

function var_0_0.setSceneRoot(arg_9_0, arg_9_1)
	arg_9_0._sceneRoot = arg_9_1

	local var_9_0 = arg_9_0._sceneRoot.transform

	for iter_9_0 = var_9_0.childCount - 1, 0, -1 do
		local var_9_1 = var_9_0:GetChild(iter_9_0)

		arg_9_0._sceneNameMap[var_9_1.name] = var_9_1.gameObject
	end
end

function var_0_0.hideScene(arg_10_0)
	arg_10_0._isShowScene = false

	if arg_10_0._weatherCompMap then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._weatherCompMap) do
			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				if iter_10_3.onSceneHide then
					iter_10_3:onSceneHide()
				end
			end
		end
	end
end

function var_0_0.showCurScene(arg_11_0)
	if not arg_11_0._curSceneId then
		return
	end

	arg_11_0:showScene(arg_11_0._curSceneId, arg_11_0._callback, arg_11_0._calbackTarget)
end

local var_0_1 = "MainSceneSwitchDisplayController_showScene"

function var_0_0.showScene(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._curSceneId = arg_12_1
	arg_12_0._isShowScene = true
	arg_12_0._callback = arg_12_2
	arg_12_0._callbackTarget = arg_12_3

	local var_12_0, var_12_1 = arg_12_0:_getSceneConfig(arg_12_1)

	if arg_12_0._sceneNameMap[var_12_1] then
		arg_12_0:_showScene(var_12_1)

		return
	end

	if not arg_12_0._loaderMap[var_12_1] then
		UIBlockHelper.instance:startBlock(var_0_1, 1)

		local var_12_2 = MultiAbLoader.New()

		arg_12_0._loaderMap[var_12_1] = var_12_2
		var_12_2._sceneId = arg_12_1

		var_12_2:addPath(var_12_0)
		var_12_2:startLoad(arg_12_0._loadSceneFinish, arg_12_0)
	end
end

function var_0_0._loadSceneFinish(arg_13_0, arg_13_1)
	UIBlockHelper.instance:endBlock(var_0_1)

	local var_13_0 = arg_13_1._sceneId
	local var_13_1, var_13_2, var_13_3 = arg_13_0:_getSceneConfig(var_13_0)
	local var_13_4 = arg_13_1:getFirstAssetItem()
	local var_13_5 = gohelper.clone(var_13_4:GetResource(var_13_1), arg_13_0._sceneRoot)

	arg_13_0._sceneNameMap[var_13_2] = var_13_5

	transformhelper.setLocalPosXY(var_13_5.transform, 10000, 0)

	local var_13_6 = WeatherYearAnimationComp.New()
	local var_13_7 = WeatherFrameComp.New()
	local var_13_8 = WeatherComp.New()
	local var_13_9 = WeatherSwitchComp.New()
	local var_13_10 = WeatherEggContainerComp.New()
	local var_13_11 = WeatherSceneEffectComp.New()

	arg_13_0._weatherCompMap[var_13_2] = {
		var_13_8,
		var_13_6,
		var_13_7,
		var_13_9,
		var_13_10,
		var_13_11
	}

	var_13_9:onInit(var_13_0, var_13_8)
	var_13_10:onInit(var_13_0)
	var_13_10:initSceneGo(var_13_5)
	var_13_11:onInit(var_13_0)
	var_13_11:initSceneGo(var_13_5)
	var_13_6:onInit()
	var_13_6:initSceneGo(var_13_5)
	var_13_7:onInit(var_13_0)
	var_13_7:initSceneGo(var_13_5)
	var_13_8:addRoleBlendCallback(arg_13_0._onRoleBlendCallback, {
		var_13_7,
		var_13_11
	})
	var_13_8:setSceneResName(var_13_3)
	var_13_8:onInit()
	var_13_8:setSceneId(var_13_0)
	var_13_8:initSceneGo(var_13_5, function()
		arg_13_0:_showScene(var_13_2)
	end, var_13_8)
	var_13_8:addChangeReportCallback(var_13_10.onReportChange, var_13_10, true)
end

function var_0_0._onRoleBlendCallback(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0) do
		iter_15_1:onRoleBlend(arg_15_1, arg_15_2, arg_15_3)
	end
end

function var_0_0.setSwitchCompContinue(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getSwitchComp(arg_16_1)

	if not var_16_0 then
		return
	end

	if arg_16_2 then
		var_16_0:continue()
	else
		var_16_0:pause()
	end
end

function var_0_0.getSwitchComp(arg_17_0, arg_17_1)
	local var_17_0, var_17_1, var_17_2 = arg_17_0:_getSceneConfig(arg_17_1)
	local var_17_3 = arg_17_0._weatherCompMap[var_17_1]

	return var_17_3 and var_17_3[4]
end

function var_0_0._getSceneConfig(arg_18_0, arg_18_1)
	local var_18_0 = lua_scene_switch.configDict[arg_18_1].resName
	local var_18_1 = ResUrl.getSceneRes(var_18_0)
	local var_18_2 = var_18_0 .. "_p(Clone)"

	return var_18_1, var_18_2, var_18_0
end

function var_0_0._showScene(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._sceneNameMap) do
		if iter_19_0 == arg_19_1 then
			transformhelper.setLocalPosXY(iter_19_1.transform, 0, 0)
		end
	end

	local var_19_0

	for iter_19_2, iter_19_3 in pairs(arg_19_0._weatherCompMap) do
		if iter_19_2 == arg_19_1 and arg_19_0._isShowScene then
			var_19_0 = iter_19_3
		else
			for iter_19_4, iter_19_5 in pairs(iter_19_3) do
				if iter_19_5.onSceneHide then
					iter_19_5:onSceneHide()
				end
			end
		end
	end

	if var_19_0 then
		for iter_19_6, iter_19_7 in pairs(var_19_0) do
			if iter_19_7.onSceneShow then
				iter_19_7:onSceneShow()
			end
		end
	end

	local var_19_1 = arg_19_0._callback
	local var_19_2 = arg_19_0._callbackTarget

	if var_19_1 then
		var_19_1(var_19_2)
	end

	arg_19_0._callback = nil
	arg_19_0._callbackTarget = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
