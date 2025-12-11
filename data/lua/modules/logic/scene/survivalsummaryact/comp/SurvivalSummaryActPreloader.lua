module("modules.logic.scene.survivalsummaryact.comp.SurvivalSummaryActPreloader", package.seeall)

local var_0_0 = class("SurvivalSummaryActPreloader", SurvivalShelterScenePreloader)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._loader = MultiAbLoader.New()

	if not GameResMgr.IsFromEditorDir then
		local var_1_0 = {}

		arg_1_0._loader:setPathList(var_1_0)
		arg_1_0._loader:addPath(arg_1_0:getMapBlockAbPath())
	else
		local var_1_1 = {}

		tabletool.addValues(var_1_1, arg_1_0:getSummaryActBlock())
		arg_1_0._loader:setPathList(var_1_1)
	end

	arg_1_0._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.PlayerRes))

	local var_1_2 = SurvivalMapModel.instance.resultData:getFirstNpcMos()

	for iter_1_0, iter_1_1 in ipairs(var_1_2) do
		if SurvivalConfig.instance:getNpcRenown(iter_1_1.id) then
			arg_1_0._loader:addPath(iter_1_1.co.resource)
		end
	end

	arg_1_0._loader:addPath(SurvivalShelterSceneFogComp.FogResPath)

	for iter_1_2, iter_1_3 in pairs(SurvivalShelterScenePathComp.ResPaths) do
		arg_1_0._loader:addPath(iter_1_3)
	end

	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0.getSummaryActBlock(arg_2_0)
	local var_2_0 = SurvivalConfig.instance:getCurShelterMapId()
	local var_2_1 = lua_survival_shelter.configDict[var_2_0]
	local var_2_2 = SurvivalConfig.instance:getShelterMapCo(var_2_1.mapId)

	return (tabletool.copy(var_2_2.allBlockPaths))
end

return var_0_0
