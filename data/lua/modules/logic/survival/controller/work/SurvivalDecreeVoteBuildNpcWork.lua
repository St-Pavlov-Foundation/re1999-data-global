module("modules.logic.survival.controller.work.SurvivalDecreeVoteBuildNpcWork", package.seeall)

local var_0_0 = class("SurvivalDecreeVoteBuildNpcWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:initParam(arg_1_1)
end

function var_0_0.initParam(arg_2_0, arg_2_1)
	arg_2_0.npcDataList = arg_2_1.npcDataList
	arg_2_0.votePercent = arg_2_1.votePercent
	arg_2_0.goAgreeItem = arg_2_1.goAgreeItem
	arg_2_0.goDisAgreeItem = arg_2_1.goDisAgreeItem
	arg_2_0.mapCo = arg_2_1.mapCo
	arg_2_0.unitComp = arg_2_1.unitComp
	arg_2_0.bubbleList = arg_2_1.bubbleList or {}
	arg_2_0.toastList = arg_2_1.toastList or {}
	arg_2_0.npcList = {}
end

function var_0_0.onStart(arg_3_0)
	local var_3_0 = GameUtil.splitString2(arg_3_0.mapCo.npcPosition, true, "#", ",")
	local var_3_1 = arg_3_0.unitComp:getUnitParentGO(SurvivalEnum.ShelterUnitType.VoteEntity)
	local var_3_2 = #var_3_0
	local var_3_3 = math.floor(var_3_2 * arg_3_0.votePercent)
	local var_3_4 = var_3_2 - var_3_3
	local var_3_5 = 1

	for iter_3_0 = 1, math.min(var_3_3, #arg_3_0.npcDataList[1]) do
		if var_3_2 < var_3_5 then
			break
		end

		arg_3_0:createNpc(arg_3_0.npcDataList[1][iter_3_0], var_3_1, var_3_0[var_3_5])

		var_3_5 = var_3_5 + 1
	end

	for iter_3_1 = 1, math.min(var_3_4, #arg_3_0.npcDataList[2]) do
		if var_3_2 < var_3_5 then
			break
		end

		arg_3_0:createNpc(arg_3_0.npcDataList[2][iter_3_1], var_3_1, var_3_0[var_3_5])

		var_3_5 = var_3_5 + 1
	end

	arg_3_0:onBuildFinish()
end

function var_0_0.createNpc(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = SurvivalDecreeVoteEntity.Create(arg_4_1.resource, arg_4_2, SurvivalHexNode.New(arg_4_3[1], arg_4_3[2]), arg_4_4)

	table.insert(arg_4_0.npcList, var_4_0)
	table.insert(arg_4_0.toastList, arg_4_1)

	if arg_4_1.isAgree then
		arg_4_0:createBubbleItem(arg_4_0.goAgreeItem, var_4_0.go)
	else
		arg_4_0:createBubbleItem(arg_4_0.goDisAgreeItem, var_4_0.go)
	end
end

function var_0_0.clearNpc(arg_5_0)
	if arg_5_0.npcList then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.npcList) do
			iter_5_1:dispose()
		end
	end

	arg_5_0.npcList = {}
end

function var_0_0.createBubbleItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = gohelper.cloneInPlace(arg_6_1)

	gohelper.setActive(var_6_0, false)

	local var_6_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_0, SurvivalDecreeVoteUIItem, arg_6_2)

	table.insert(arg_6_0.bubbleList, var_6_1)
end

function var_0_0.onBuildFinish(arg_7_0)
	arg_7_0:onDone(true)
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0:clearNpc()
	var_0_0.super.onDestroy(arg_8_0)
end

return var_0_0
