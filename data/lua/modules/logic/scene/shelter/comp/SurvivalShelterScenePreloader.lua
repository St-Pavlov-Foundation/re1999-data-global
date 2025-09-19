module("modules.logic.scene.shelter.comp.SurvivalShelterScenePreloader", package.seeall)

local var_0_0 = class("SurvivalShelterScenePreloader", BaseSceneComp)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._loader = MultiAbLoader.New()

	if not GameResMgr.IsFromEditorDir then
		local var_1_0 = SurvivalConfig.instance:getShelterMapCo()

		arg_1_0._loader:setPathList(tabletool.copy(var_1_0.allBuildingPaths))
		arg_1_0._loader:addPath(arg_1_0:getMapBlockAbPath())
	else
		local var_1_1 = SurvivalConfig.instance:getShelterMapCo()
		local var_1_2 = tabletool.copy(var_1_1.allBlockPaths)

		tabletool.addValues(var_1_2, var_1_1.allBuildingPaths)
		arg_1_0._loader:setPathList(var_1_2)
	end

	arg_1_0._loader:addPath(SurvivalShelterSceneFogComp.FogResPath)

	for iter_1_0, iter_1_1 in pairs(SurvivalShelterScenePathComp.ResPaths) do
		arg_1_0._loader:addPath(iter_1_1)
	end

	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	arg_2_0:dispatchEvent(SurvivalEvent.OnSurvivalPreloadFinish)
end

function var_0_0.getRes(arg_3_0, arg_3_1)
	if not arg_3_0._loader or arg_3_0._loader.isLoading then
		return
	end

	local var_3_0

	if not GameResMgr.IsFromEditorDir and string.find(arg_3_1, "survival/scenes/") then
		var_3_0 = arg_3_0._loader:getAssetItem(arg_3_0:getMapBlockAbPath())
	else
		var_3_0 = arg_3_0._loader:getAssetItem(arg_3_1)
	end

	if not var_3_0 then
		return
	end

	return var_3_0:GetResource(arg_3_1)
end

function var_0_0.getMapBlockAbPath(arg_4_0)
	return "survival/scenes/map07"
end

function var_0_0.onSceneClose(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._loader then
		arg_5_0._loader:dispose()

		arg_5_0._loader = nil
	end
end

return var_0_0
