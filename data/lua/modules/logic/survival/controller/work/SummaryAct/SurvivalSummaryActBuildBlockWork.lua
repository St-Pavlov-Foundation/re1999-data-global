module("modules.logic.survival.controller.work.SummaryAct.SurvivalSummaryActBuildBlockWork", package.seeall)

local var_0_0 = class("SurvivalSummaryActBuildBlockWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.mapCo = arg_1_1.mapCo
	arg_1_0.actMapId = arg_1_0.mapCo.mapId
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = SurvivalMapHelper.instance:getScene():getSceneContainerGO()

	arg_2_0.goBlockRoot = gohelper.create3d(var_2_0, "SummaryAct_BlockRoot")

	local var_2_1 = SurvivalConfig.instance:getShelterMapCo(arg_2_0.actMapId)

	arg_2_0.blocks = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1.allBlocks) do
		local var_2_2 = tabletool.copy(iter_2_1)

		var_2_2.pos = SurvivalHexNode.New(var_2_2.pos.q, var_2_2.pos.r + SurvivalModel.instance.summaryActPosOffset)

		local var_2_3 = SurvivalShelterBlockEntity.Create(var_2_2, arg_2_0.goBlockRoot)

		table.insert(arg_2_0.blocks, var_2_3)
	end

	arg_2_0:onDone(true)
end

function var_0_0.onDestroy(arg_3_0)
	gohelper.destroy(arg_3_0.goBlockRoot)
	var_0_0.super.onDestroy(arg_3_0)
end

return var_0_0
