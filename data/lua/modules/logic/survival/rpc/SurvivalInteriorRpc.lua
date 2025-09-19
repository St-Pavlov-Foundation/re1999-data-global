module("modules.logic.survival.rpc.SurvivalInteriorRpc", package.seeall)

local var_0_0 = class("SurvivalInteriorRpc", BaseRpc)

function var_0_0.sendEnterSurvival(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = SurvivalInteriorModule_pb.EnterSurvivalRequest()

	if arg_1_1 then
		var_1_0.copyId = arg_1_1.selectCopyIndex

		for iter_1_0 = 1, arg_1_1:getCarryHeroCount() do
			local var_1_1 = arg_1_1.allSelectHeroMos[iter_1_0]

			if var_1_1 and (not arg_1_1.assistHeroMo or var_1_1 ~= arg_1_1.assistHeroMo.heroMO) then
				table.insert(var_1_0.heroUid, var_1_1.uid)
			end
		end

		if arg_1_1.assistHeroMo then
			var_1_0.assistHeroUid = arg_1_1.assistHeroMo.heroUid
		end

		for iter_1_1 = 1, arg_1_1:getCarryNPCCount() do
			local var_1_2 = arg_1_1.allSelectNpcs[iter_1_1]

			if var_1_2 then
				table.insert(var_1_0.npcId, var_1_2.id)
			end
		end
	end

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveEnterSurvivalReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		SurvivalShelterModel.instance:getWeekInfo().inSurvival = true

		SurvivalMapModel.instance:setSceneData(arg_2_2.scene)
	end
end

function var_0_0.sendSurvivalSceneOperation(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = SurvivalInteriorModule_pb.SurvivalSceneOperationRequest()

	var_3_0.operationType = arg_3_1
	var_3_0.param = arg_3_2

	return arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveSurvivalSceneOperationReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveSurvivalSceneEndPush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalSceneEndPush", arg_5_2)
	end
end

function var_0_0.onReceiveSurvivalDailyReportPush(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalDailyReportPush", arg_6_2)
	end
end

function var_0_0.sendSurvivalSceneOperationLog(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = SurvivalInteriorModule_pb.SurvivalSceneOperationLogRequest()

	return arg_7_0:sendMsg(var_7_0, arg_7_1, arg_7_2)
end

function var_0_0.onReceiveSurvivalSceneOperationLogReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_2.data) do
			local var_8_1 = SurvivalLogMo.New()

			var_8_1:init(iter_8_1, SurvivalEnum.ItemRareColor2)
			table.insert(var_8_0, var_8_1)
		end

		tabletool.revert(var_8_0)
		ViewMgr.instance:openView(ViewName.SurvivalLogView, var_8_0)
	end
end

function var_0_0.onReceiveSurvivalSceneOperationLogPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalSceneOperationLogPush", arg_9_2)
	end
end

function var_0_0.sendSurvivalSceneGiveUp(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = SurvivalInteriorModule_pb.SurvivalSceneGiveUpRequest()

	return arg_10_0:sendMsg(var_10_0, arg_10_1, arg_10_2)
end

function var_0_0.onReceiveSurvivalSceneGiveUpReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalUpdateClientDataRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = SurvivalInteriorModule_pb.SurvivalUpdateClientDataRequest()

	var_12_0.data = arg_12_1

	return arg_12_0:sendMsg(var_12_0, arg_12_2, arg_12_3)
end

function var_0_0.onReceiveSurvivalUpdateClientDataReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalTaskFollowRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	local var_14_0 = SurvivalInteriorModule_pb.SurvivalTaskFollowRequest()

	var_14_0.moduleId = arg_14_1
	var_14_0.taskId = arg_14_2
	var_14_0.follow = arg_14_3

	return arg_14_0:sendMsg(var_14_0, arg_14_4, arg_14_5)
end

function var_0_0.onReceiveSurvivalTaskFollowReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendSurvivalUseItemRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = SurvivalInteriorModule_pb.SurvivalUseItemRequest()

	var_16_0.itemUid = arg_16_1
	var_16_0.param = arg_16_2

	return arg_16_0:sendMsg(var_16_0, arg_16_3, arg_16_4)
end

function var_0_0.onReceiveSurvivalUseItemReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveMsg(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6)
	var_0_0.super.onReceiveMsg(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6)

	if arg_18_1 == 0 and string.find(arg_18_3, "Reply$") then
		SurvivalMapHelper.instance:tryStartFlow(arg_18_3)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
