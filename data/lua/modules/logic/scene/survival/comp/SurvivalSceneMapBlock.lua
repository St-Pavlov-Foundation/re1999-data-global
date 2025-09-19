module("modules.logic.scene.survival.comp.SurvivalSceneMapBlock", package.seeall)

local var_0_0 = class("SurvivalSceneMapBlock", BaseSceneComp)

function var_0_0.init(arg_1_0)
	arg_1_0:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	arg_2_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_2_0._onPreloadFinish, arg_2_0)

	arg_2_0._sceneGo = arg_2_0:getCurScene():getSceneContainerGO()
	arg_2_0._blockRoot = gohelper.create3d(arg_2_0._sceneGo, "BlockRoot")

	local var_2_0 = SurvivalMapModel.instance:getCurMapCo()

	arg_2_0._allBlocks = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0.allBlocks) do
		local var_2_1 = SurvivalBlockEntity.Create(iter_2_1, arg_2_0._blockRoot)

		table.insert(arg_2_0._allBlocks, var_2_1)
	end

	arg_2_0:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function var_0_0.onSceneClose(arg_3_0)
	arg_3_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_3_0._onPreloadFinish, arg_3_0)
	gohelper.destroy(arg_3_0._blockRoot)

	arg_3_0._blockRoot = nil
	arg_3_0._sceneGo = nil
	arg_3_0._allBlocks = {}
end

return var_0_0
