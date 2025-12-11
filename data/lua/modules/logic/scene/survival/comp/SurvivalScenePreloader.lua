module("modules.logic.scene.survival.comp.SurvivalScenePreloader", package.seeall)

local var_0_0 = class("SurvivalScenePreloader", BaseSceneComp)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._mapGroupId = nil

	arg_1_0:initMapGroupId()

	arg_1_0._loader = MultiAbLoader.New()

	if not GameResMgr.IsFromEditorDir then
		arg_1_0._loader:addPath(arg_1_0:getMapBlockAbPath())
		arg_1_0._loader:addPath(arg_1_0:getMapBlockCommonAbPath())
	else
		local var_1_0 = SurvivalMapModel.instance:getCurMapCo()

		arg_1_0._loader:setPathList(tabletool.copy(var_1_0.allPaths))

		for iter_1_0, iter_1_1 in ipairs(lua_survival_block.configList) do
			local var_1_1 = tonumber(iter_1_1.copyIds) or 0

			if var_1_1 == 0 or var_1_1 == arg_1_0._mapGroupId then
				arg_1_0._loader:addPath(arg_1_0:getBlockResPath(var_1_1, iter_1_1.resource))
			end
		end

		arg_1_0._loader:addPath(arg_1_0:getBlockResPath(0, "survival_cloud"))
		arg_1_0._loader:addPath(arg_1_0:getBlockResPath(0, "survival_kengdong"))
	end

	arg_1_0:addPlayerRes()
	arg_1_0._loader:addPath(SurvivalSceneFogComp.FogResPath)
	arg_1_0._loader:addPath(SurvivalSceneMapSpBlock.EdgeResPath)

	for iter_1_2, iter_1_3 in pairs(SurvivalSceneMapPath.ResPaths) do
		arg_1_0._loader:addPath(iter_1_3)
	end

	for iter_1_4, iter_1_5 in pairs(SurvivalPointEffectComp.ResPaths) do
		arg_1_0._loader:addPath(iter_1_5)
	end

	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0.addPlayerRes(arg_2_0)
	arg_2_0._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.PlayerRes))
	arg_2_0._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_Miasma))
	arg_2_0._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_Morass))
	arg_2_0._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_Magma))
	arg_2_0._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_Ice))
	arg_2_0._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_Water))
	arg_2_0._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_WaterNormal))
end

function var_0_0._onPreloadFinish(arg_3_0)
	arg_3_0:dispatchEvent(SurvivalEvent.OnSurvivalPreloadFinish)
end

function var_0_0.getRes(arg_4_0, arg_4_1)
	if not arg_4_0._loader or arg_4_0._loader.isLoading then
		return
	end

	local var_4_0

	if not GameResMgr.IsFromEditorDir and string.find(arg_4_1, "survival/scenes/") then
		var_4_0 = arg_4_0._loader:getAssetItem(arg_4_0:getMapBlockAbPath())
	else
		var_4_0 = arg_4_0._loader:getAssetItem(arg_4_1)
	end

	if not var_4_0 then
		return
	end

	return var_4_0:GetResource(arg_4_1)
end

function var_0_0.getBlockRes(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 then
		return
	end

	if not arg_5_0._loader or arg_5_0._loader.isLoading then
		return
	end

	local var_5_0
	local var_5_1 = arg_5_1 == 0 and arg_5_0:getMapBlockCommonAbPath() or arg_5_0:getMapBlockAbPath()
	local var_5_2 = arg_5_0:getBlockResPath(arg_5_1, arg_5_2)

	if not GameResMgr.IsFromEditorDir and string.find(var_5_2, "survival/scenes/") then
		var_5_0 = arg_5_0._loader:getAssetItem(var_5_1)
	else
		var_5_0 = arg_5_0._loader:getAssetItem(var_5_2)
	end

	if not var_5_0 then
		return
	end

	return var_5_0:GetResource(var_5_2)
end

function var_0_0.getBlockResPath(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 == 0 and arg_6_0:getMapBlockCommonAbPath() or arg_6_0:getMapBlockAbPath()

	return (string.format("%s/prefab/%s.prefab", var_6_0, arg_6_2))
end

function var_0_0.getMapBlockAbPath(arg_7_0)
	return "survival/scenes/map0" .. (arg_7_0._mapGroupId or 1)
end

function var_0_0.initMapGroupId(arg_8_0)
	if not arg_8_0._mapGroupId then
		local var_8_0 = SurvivalMapModel.instance:getCurMapId()
		local var_8_1 = lua_survival_map_group_mapping.configDict[var_8_0].id

		arg_8_0._mapGroupId = lua_survival_map_group.configDict[var_8_1].type
	end
end

function var_0_0.getMapBlockCommonAbPath(arg_9_0)
	return "survival/scenes/map_common"
end

function var_0_0.onSceneClose(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._loader then
		arg_10_0._loader:dispose()

		arg_10_0._loader = nil
	end

	arg_10_0._mapGroupId = nil
end

return var_0_0
