module("modules.logic.scene.newbie.comp.NewbieSceneLevelComp", package.seeall)

local var_0_0 = class("NewbieSceneLevelComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.animSuccess = false
	arg_2_0.switchSuccess = false

	arg_2_0:_loadMainScene(arg_2_2, function()
		arg_2_0._scene:onPrepared()
	end)
end

function var_0_0._loadMainScene(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._callback = arg_4_2
	arg_4_0._callbackTarget = arg_4_3

	if arg_4_0._resPath then
		arg_4_0:doCallback()

		return
	end

	arg_4_0._levelId = arg_4_1
	arg_4_0._resPath = ResUrl.getSceneLevelUrl(arg_4_0._levelId)

	loadAbAsset(arg_4_0._resPath, false, arg_4_0._onLoadCallback, arg_4_0)
end

function var_0_0._onLoadCallback(arg_5_0, arg_5_1)
	if arg_5_1.IsLoadSuccess then
		local var_5_0 = arg_5_0._assetItem

		arg_5_0._assetItem = arg_5_1

		arg_5_0._assetItem:Retain()

		if var_5_0 then
			var_5_0:Release()
		end

		local var_5_1 = GameSceneMgr.instance:getScene(SceneType.Main):getSceneContainerGO()

		arg_5_0._instGO = gohelper.clone(arg_5_0._assetItem:GetResource(arg_5_0._resPath), var_5_1)

		WeatherController.instance:initSceneGo(arg_5_0._instGO, arg_5_0._onSwitchResLoaded, arg_5_0)
		arg_5_0._scene.yearAnimation:initAnimationCurve(arg_5_0._onAnimationCurveLoaded, arg_5_0)
		arg_5_0:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, arg_5_0._levelId)
	end
end

function var_0_0._onAnimationCurveLoaded(arg_6_0)
	arg_6_0.animSuccess = true

	arg_6_0:_check()
end

function var_0_0._onSwitchResLoaded(arg_7_0)
	arg_7_0.switchSuccess = true

	arg_7_0:_check()
end

function var_0_0._check(arg_8_0)
	if arg_8_0.animSuccess and arg_8_0.switchSuccess then
		arg_8_0:doCallback()
	end
end

function var_0_0.doCallback(arg_9_0)
	if arg_9_0._callback then
		arg_9_0._callback(arg_9_0._callbackTarget)

		arg_9_0._callback = nil
		arg_9_0._callbackTarget = nil
	end
end

function var_0_0.onSceneClose(arg_10_0)
	if arg_10_0._assetItem then
		if arg_10_0._instGO then
			gohelper.destroy(arg_10_0._instGO)
		end

		arg_10_0._assetItem:Release()

		arg_10_0._assetItem = nil
	end

	arg_10_0._resPath = nil
	arg_10_0.animSuccess = false
	arg_10_0.switchSuccess = false

	WeatherController.instance:onSceneClose()
end

function var_0_0._onLevelLoaded(arg_11_0, arg_11_1)
	return
end

function var_0_0.getSceneGo(arg_12_0)
	return arg_12_0._instGO
end

return var_0_0
