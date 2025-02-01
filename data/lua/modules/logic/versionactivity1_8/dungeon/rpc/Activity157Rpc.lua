module("modules.logic.versionactivity1_8.dungeon.rpc.Activity157Rpc", package.seeall)

slot0 = class("Activity157Rpc", BaseRpc)

function slot0.sendGet157InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity157Module_pb.Get157InfoRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet157InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity157Model.instance:setActivityInfo(slot2)
end

function slot0.sendAct157UnlockComponentRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity157Module_pb.Act157UnlockComponentRequest()
	slot5.activityId = slot1
	slot5.componentId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct157UnlockComponentReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity157Model.instance:setComponentUnlock(slot2.componentId)
	Activity157Model.instance:setProductionInfo(slot2.productionInfo.productionMaterial.quantity, slot2.productionInfo.nextRecoverTime)
	Activity157Model.instance:setSideMissionUnlockTime(slot2.sideMissionUnlockTime)
end

function slot0.sendAct157AcceptProductionRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity157Module_pb.Act157AcceptProductionRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct157AcceptProductionReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity157Model.instance:setProductionInfo(slot2.productionInfo.productionMaterial.quantity, slot2.productionInfo.nextRecoverTime)
	GameFacade.showToast(ToastEnum.V1a8Activity157GetFactoryProductionSuccess)
end

function slot0.sendAct157CompoundRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity157Module_pb.Act157CompoundRequest()
	slot5.activityId = slot1
	slot5.compoundTimes = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct157CompoundReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendAct157GainMilestoneRewardRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity157Module_pb.Act157GainMilestoneRewardRequest()
	slot5.activityId = slot1
	slot5.componentId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct157GainMilestoneRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot4 = {
		{
			materilType = slot2.info.buildingData.materilType,
			materilId = slot2.info.buildingData.materilId,
			quantity = slot2.info.buildingData.quantity,
			roomBuildingLevel = slot2.info.buildingLevel
		}
	}

	if slot2.dataList then
		for slot8, slot9 in ipairs(slot2.dataList) do
			if slot9.materilType ~= MaterialEnum.MaterialType.Building then
				slot4[#slot4 + 1] = slot9
			end
		end
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157OnGetComponentReward, MaterialRpc.receiveMaterial({
		dataList = slot4
	}))
	Activity157Model.instance:setHasGotRewardComponentByList(slot2.componentIds)
end

function slot0.onReceiveProductionInfoChangePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity157Model.instance:setProductionInfo(slot2.productionInfo.productionMaterial.quantity, slot2.productionInfo.nextRecoverTime)
end

slot0.instance = slot0.New()

return slot0
