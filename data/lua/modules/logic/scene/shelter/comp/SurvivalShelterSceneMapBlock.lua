module("modules.logic.scene.shelter.comp.SurvivalShelterSceneMapBlock", package.seeall)

local var_0_0 = class("SurvivalShelterSceneMapBlock", BaseSceneComp)

function var_0_0.init(arg_1_0)
	arg_1_0:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	arg_2_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_2_0._onPreloadFinish, arg_2_0)

	arg_2_0._sceneGo = arg_2_0:getCurScene():getSceneContainerGO()
	arg_2_0._blockRoot = gohelper.create3d(arg_2_0._sceneGo, "BlockRoot")

	local var_2_0 = SurvivalConfig.instance:getShelterMapCo()

	arg_2_0._allBlocks = {}
	arg_2_0.blockDict = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0.allBlocks) do
		SurvivalHelper.instance:addNodeToDict(arg_2_0.blockDict, iter_2_1.pos)

		local var_2_1 = SurvivalShelterBlockEntity.Create(iter_2_1, arg_2_0._blockRoot)

		table.insert(arg_2_0._allBlocks, var_2_1)
	end

	arg_2_0:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function var_0_0.isClickBlock(arg_3_0, arg_3_1)
	return SurvivalHelper.instance:isHaveNode(arg_3_0.blockDict, arg_3_1)
end

function var_0_0.onSceneClose(arg_4_0)
	arg_4_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_4_0._onPreloadFinish, arg_4_0)
	gohelper.destroy(arg_4_0._blockRoot)

	arg_4_0._blockRoot = nil
	arg_4_0._sceneGo = nil
	arg_4_0.blockDict = {}
	arg_4_0._allBlocks = {}
end

return var_0_0
