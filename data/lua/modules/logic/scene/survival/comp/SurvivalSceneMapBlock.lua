module("modules.logic.scene.survival.comp.SurvivalSceneMapBlock", package.seeall)

local var_0_0 = class("SurvivalSceneMapBlock", BaseSceneComp)

function var_0_0.init(arg_1_0)
	arg_1_0:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	arg_2_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_2_0._onPreloadFinish, arg_2_0)

	arg_2_0._sceneGo = arg_2_0:getCurScene():getSceneContainerGO()
	arg_2_0._blockRoot = gohelper.create3d(arg_2_0._sceneGo, "BlockRoot")

	local var_2_0 = SurvivalMapModel.instance:getSceneMo()
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0.blocks) do
		SurvivalHelper.instance:addNodeToDict(var_2_1, iter_2_1.pos)

		for iter_2_2, iter_2_3 in pairs(iter_2_1.exPoints) do
			SurvivalHelper.instance:addNodeToDict(var_2_1, iter_2_3)
		end
	end

	local var_2_2 = SurvivalMapModel.instance:getCurMapCo()

	arg_2_0._allBlocks = {}

	for iter_2_4, iter_2_5 in ipairs(var_2_2.allBlocks) do
		local var_2_3 = iter_2_5.pos

		if not SurvivalHelper.instance:getValueFromDict(var_2_0.allDestroyPos, var_2_3) and not SurvivalHelper.instance:getValueFromDict(var_2_1, var_2_3) then
			local var_2_4 = SurvivalBlockEntity.Create(iter_2_5, arg_2_0._blockRoot)

			if not arg_2_0._allBlocks[var_2_3.q] then
				arg_2_0._allBlocks[var_2_3.q] = {}
			end

			arg_2_0._allBlocks[var_2_3.q][var_2_3.r] = var_2_4
		end
	end

	for iter_2_6, iter_2_7 in ipairs(var_2_0.extraBlock) do
		local var_2_5 = iter_2_7.pos

		if not SurvivalHelper.instance:getValueFromDict(var_2_0.allDestroyPos, var_2_5) and not SurvivalHelper.instance:getValueFromDict(var_2_1, var_2_5) then
			local var_2_6 = SurvivalExBlockEntity.Create(iter_2_7, arg_2_0._blockRoot)

			if not arg_2_0._allBlocks[var_2_5.q] then
				arg_2_0._allBlocks[var_2_5.q] = {}
			end

			arg_2_0._allBlocks[var_2_5.q][var_2_5.r] = var_2_6

			var_2_2:setWalkByUnitMo(iter_2_7, true)
		end
	end

	arg_2_0:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function var_0_0.addExBlock(arg_3_0, arg_3_1)
	local var_3_0 = SurvivalExBlockEntity.Create(arg_3_1, arg_3_0._blockRoot)
	local var_3_1 = arg_3_1.pos

	if not arg_3_0._allBlocks[var_3_1.q] then
		arg_3_0._allBlocks[var_3_1.q] = {}
	end

	arg_3_0._allBlocks[var_3_1.q][var_3_1.r] = var_3_0

	SurvivalMapModel.instance:getCurMapCo():setWalkByUnitMo(arg_3_1, true)
end

function var_0_0.setBlockActive(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._allBlocks[arg_4_1.q] and arg_4_0._allBlocks[arg_4_1.q][arg_4_1.r]

	if var_4_0 then
		gohelper.setActive(var_4_0.go, arg_4_2)
	end
end

function var_0_0.onSceneClose(arg_5_0)
	arg_5_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_5_0._onPreloadFinish, arg_5_0)
	gohelper.destroy(arg_5_0._blockRoot)

	arg_5_0._blockRoot = nil
	arg_5_0._sceneGo = nil
	arg_5_0._allBlocks = {}
end

return var_0_0
