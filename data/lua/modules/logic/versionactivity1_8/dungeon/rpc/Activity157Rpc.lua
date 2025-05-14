module("modules.logic.versionactivity1_8.dungeon.rpc.Activity157Rpc", package.seeall)

local var_0_0 = class("Activity157Rpc", BaseRpc)

function var_0_0.sendGet157InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity157Module_pb.Get157InfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet157InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity157Model.instance:setActivityInfo(arg_2_2)
end

function var_0_0.sendAct157UnlockComponentRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity157Module_pb.Act157UnlockComponentRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.componentId = arg_3_2

	return arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct157UnlockComponentReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	Activity157Model.instance:setComponentUnlock(arg_4_2.componentId)

	local var_4_0 = arg_4_2.productionInfo.productionMaterial.quantity
	local var_4_1 = arg_4_2.productionInfo.nextRecoverTime

	Activity157Model.instance:setProductionInfo(var_4_0, var_4_1)
	Activity157Model.instance:setSideMissionUnlockTime(arg_4_2.sideMissionUnlockTime)
end

function var_0_0.sendAct157AcceptProductionRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = Activity157Module_pb.Act157AcceptProductionRequest()

	var_5_0.activityId = arg_5_1

	return arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveAct157AcceptProductionReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.productionInfo.productionMaterial.quantity
	local var_6_1 = arg_6_2.productionInfo.nextRecoverTime

	Activity157Model.instance:setProductionInfo(var_6_0, var_6_1)
	GameFacade.showToast(ToastEnum.V1a8Activity157GetFactoryProductionSuccess)
end

function var_0_0.sendAct157CompoundRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = Activity157Module_pb.Act157CompoundRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.compoundTimes = arg_7_2

	return arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveAct157CompoundReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end
end

function var_0_0.sendAct157GainMilestoneRewardRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = Activity157Module_pb.Act157GainMilestoneRewardRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.componentId = arg_9_2

	return arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveAct157GainMilestoneRewardReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = {
		materilType = arg_10_2.info.buildingData.materilType,
		materilId = arg_10_2.info.buildingData.materilId,
		quantity = arg_10_2.info.buildingData.quantity,
		roomBuildingLevel = arg_10_2.info.buildingLevel
	}
	local var_10_1 = {
		var_10_0
	}

	if arg_10_2.dataList then
		for iter_10_0, iter_10_1 in ipairs(arg_10_2.dataList) do
			if iter_10_1.materilType ~= MaterialEnum.MaterialType.Building then
				var_10_1[#var_10_1 + 1] = iter_10_1
			end
		end
	end

	local var_10_2 = MaterialRpc.receiveMaterial({
		dataList = var_10_1
	})

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157OnGetComponentReward, var_10_2)
	Activity157Model.instance:setHasGotRewardComponentByList(arg_10_2.componentIds)
end

function var_0_0.onReceiveProductionInfoChangePush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	local var_11_0 = arg_11_2.productionInfo.productionMaterial.quantity
	local var_11_1 = arg_11_2.productionInfo.nextRecoverTime

	Activity157Model.instance:setProductionInfo(var_11_0, var_11_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
