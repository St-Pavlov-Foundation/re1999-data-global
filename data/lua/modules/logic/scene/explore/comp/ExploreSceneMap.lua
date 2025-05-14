module("modules.logic.scene.explore.comp.ExploreSceneMap", package.seeall)

local var_0_0 = class("ExploreSceneMap", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.onSceneStart(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)
end

function var_0_0._onLevelLoaded(arg_4_0, arg_4_1, arg_4_2)
	ExploreController.instance:registerCallback(ExploreEvent.InitMapDone, arg_4_0.initMapDone, arg_4_0)

	arg_4_0._comps = {}

	for iter_4_0, iter_4_1 in pairs(ExploreEnum.MapCompType) do
		local var_4_0 = "ExploreMap"

		if iter_4_0 ~= "Map" then
			var_4_0 = var_4_0 .. iter_4_0
		end

		arg_4_0._comps[iter_4_1] = _G[var_4_0].New()

		ExploreController.instance:registerMapComp(iter_4_1, arg_4_0._comps[iter_4_1])
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0._comps) do
		if iter_4_3.loadMap then
			iter_4_3:loadMap()
		end
	end
end

function var_0_0.initMapDone(arg_5_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.InitMapDone, arg_5_0.initMapDone, arg_5_0)
	arg_5_0:dispatchEvent(ExploreEvent.InitMapDone)
end

function var_0_0.onSceneClose(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_6_0._onLevelLoaded, arg_6_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.InitMapDone, arg_6_0.initMapDone, arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0._comps) do
		if iter_6_1.unloadMap then
			iter_6_1:unloadMap()
		end
	end

	ExploreStepController.instance:clear()

	for iter_6_2 in pairs(arg_6_0._comps) do
		ExploreController.instance:unRegisterMapComp(iter_6_2)
	end

	arg_6_0._comps = {}
end

return var_0_0
