module("modules.logic.scene.survival.comp.SurvivalScenePreloader", package.seeall)

local var_0_0 = class("SurvivalScenePreloader", BaseSceneComp)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._loader = MultiAbLoader.New()

	if not GameResMgr.IsFromEditorDir then
		arg_1_0._loader:addPath(arg_1_0:getMapBlockAbPath())
	else
		local var_1_0 = SurvivalMapModel.instance:getCurMapCo()

		arg_1_0._loader:setPathList(tabletool.copy(var_1_0.allPaths))
	end

	arg_1_0._loader:addPath(SurvivalSceneFogComp.FogResPath)

	for iter_1_0, iter_1_1 in pairs(SurvivalSceneMapPath.ResPaths) do
		arg_1_0._loader:addPath(iter_1_1)
	end

	for iter_1_2, iter_1_3 in pairs(SurvivalPointEffectComp.ResPaths) do
		arg_1_0._loader:addPath(iter_1_3)
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
	local var_4_0 = SurvivalMapModel.instance:getCurMapId()
	local var_4_1 = lua_survival_map_group_mapping.configDict[var_4_0].id
	local var_4_2 = SurvivalConfig.instance:getCopyCo(var_4_1)

	return "survival/scenes/" .. var_4_2.abPath
end

function var_0_0.onSceneClose(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._loader then
		arg_5_0._loader:dispose()

		arg_5_0._loader = nil
	end
end

return var_0_0
