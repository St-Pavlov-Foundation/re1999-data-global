module("modules.logic.scene.survivalsummaryact.comp.SurvivalSummaryActBlock", package.seeall)

local var_0_0 = class("SurvivalSummaryActBlock", BaseSceneComp)

function var_0_0.init(arg_1_0)
	arg_1_0:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	arg_2_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_2_0._onPreloadFinish, arg_2_0)

	local var_2_0 = arg_2_0:getCurScene():getSceneContainerGO()

	arg_2_0.blockRoot = gohelper.create3d(var_2_0, "BlockRoot")

	local var_2_1 = SurvivalConfig.instance:getShelterCfg()
	local var_2_2 = SurvivalConfig.instance:getShelterMapCo(var_2_1.mapId)

	arg_2_0.blocks = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_2.allBlocks) do
		local var_2_3 = SurvivalShelterBlockEntity.Create(iter_2_1, arg_2_0.blockRoot)

		table.insert(arg_2_0.blocks, var_2_3)
	end

	arg_2_0:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function var_0_0.onSceneClose(arg_3_0)
	arg_3_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_3_0._onPreloadFinish, arg_3_0)
	gohelper.destroy(arg_3_0.blockRoot)

	arg_3_0.blocks = {}
end

return var_0_0
