module("modules.logic.scene.main.comp.MainSceneDirector", package.seeall)

local var_0_0 = class("MainSceneDirector", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
	arg_1_0.animSuccess = false
	arg_1_0.switchSuccess = false
end

function var_0_0._onLevelLoaded(arg_2_0)
	arg_2_0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0)

	local var_2_0 = arg_2_0._scene.level:getSceneGo()

	WeatherController.instance:initSceneGo(var_2_0, arg_2_0._onSwitchResLoaded, arg_2_0)
	arg_2_0._scene.yearAnimation:initAnimationCurve(arg_2_0._onAnimationCurveLoaded, arg_2_0)
end

function var_0_0._onAnimationCurveLoaded(arg_3_0)
	arg_3_0.animSuccess = true

	arg_3_0:_check()
end

function var_0_0._onSwitchResLoaded(arg_4_0)
	arg_4_0.switchSuccess = true

	arg_4_0:_check()
end

function var_0_0._check(arg_5_0)
	if arg_5_0.animSuccess and arg_5_0.switchSuccess then
		arg_5_0._scene:onPrepared()
	end
end

function var_0_0.onSceneStart(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_6_0._onLevelLoaded, arg_6_0)
end

function var_0_0.onScenePrepared(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.onSceneClose(arg_8_0)
	arg_8_0.animSuccess = false
	arg_8_0.switchSuccess = false

	MainController.instance:dispatchEvent(MainEvent.OnSceneClose)
	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView
	})
	WeatherController.instance:onSceneClose()
	arg_8_0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_8_0._onLevelLoaded, arg_8_0)
end

return var_0_0
