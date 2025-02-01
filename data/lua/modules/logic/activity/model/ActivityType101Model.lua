module("modules.logic.activity.model.ActivityType101Model", package.seeall)

slot0 = class("ActivityType101Model", BaseModel)
slot1 = 0
slot2 = 1
slot3 = 2

function slot0.onInit(slot0)
	slot0._type101Info = {}
end

function slot0.reInit(slot0)
	slot0._type101Info = {}

	slot0:setCurIndex(nil)
end

function slot0.setType101Info(slot0, slot1)
	slot2 = {}
	slot3 = {
		[slot9.id] = slot10
	}
	slot4 = {}

	for slot8, slot9 in ipairs(slot1.infos) do
		ActivityType101InfoMo.New():init(slot9)
	end

	for slot8, slot9 in ipairs(slot1.spInfos or {}) do
		slot11 = ActivityType101SpInfoMo.New()

		slot11:init(slot9)

		slot4[slot9.id] = slot11
	end

	slot2.infos = slot3
	slot2.count = slot1.loginCount
	slot2.spInfos = slot4
	slot0._type101Info[slot1.activityId] = slot2
end

function slot0.setBonusGet(slot0, slot1)
	if not slot0:isInit(slot1.activityId) then
		return
	end

	slot0._type101Info[slot2].infos[slot1.id].state = uv0
end

function slot0.getType101LoginCount(slot0, slot1)
	if not slot0:isInit(slot1) then
		return 0
	end

	return slot0._type101Info[slot1].count
end

function slot0.isType101RewardGet(slot0, slot1, slot2)
	return slot0:getType101InfoState(slot1, slot2) == uv0
end

function slot0.isType101RewardCouldGet(slot0, slot1, slot2)
	return slot0:getType101InfoState(slot1, slot2) == uv0
end

function slot0.getType101Info(slot0, slot1)
	if not slot0:isInit(slot1) then
		return
	end

	return slot0._type101Info[slot1].infos
end

function slot0.getCurIndex(slot0)
	return slot0._curIndex
end

function slot0.setCurIndex(slot0, slot1)
	slot0._curIndex = slot1
end

function slot0.isType101RewardCouldGetAnyOne(slot0, slot1)
	if not slot0:getType101Info(slot1) then
		return false
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7.state == uv0 then
			return true
		end
	end

	return false
end

function slot0.hasReceiveAllReward(slot0, slot1)
	if not slot0:getType101Info(slot1) then
		return true
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7.state == uv0 or slot7.state == uv1 then
			return false
		end
	end

	return true
end

function slot0.isInit(slot0, slot1)
	return slot0._type101Info[slot1] and true or false
end

function slot0.isOpen(slot0, slot1)
	return ActivityHelper.getActivityStatus(slot1, true) == ActivityEnum.ActivityStatus.Normal
end

function slot0.getLastGetIndex(slot0, slot1)
	if uv0.instance:getType101LoginCount(slot1) == 0 then
		return 0
	end

	if slot0:isType101RewardGet(slot2) then
		return slot2
	end

	if not slot0:getType101Info(slot1) then
		return 0
	end

	slot5 = {}

	for slot9, slot10 in pairs(slot4) do
		if slot10.state == uv1 then
			slot5[#slot5 + 1] = slot10.id
		end
	end

	table.sort(slot5)

	return slot5[#slot5] or 0
end

function slot0.getType101InfoState(slot0, slot1, slot2)
	if not slot0:isInit(slot1) then
		return uv0
	end

	if not slot0:getType101Info(slot1) then
		return uv0
	end

	if not slot3[slot2] then
		return uv0
	end

	return slot4.state or uv0
end

function slot0.getType101SpInfo(slot0, slot1)
	if not slot0:isInit(slot1) then
		return
	end

	return slot0._type101Info[slot1].spInfos
end

function slot0.getType101SpInfoMo(slot0, slot1, slot2)
	if not slot0:isInit(slot1) then
		return
	end

	if not slot0:getType101SpInfo(slot1) then
		return
	end

	return slot3[slot2]
end

function slot0.isType101SpRewardUncompleted(slot0, slot1, slot2)
	if not slot0:getType101SpInfoMo(slot1, slot2) then
		return false
	end

	return slot3:isNone()
end

function slot0.isType101SpRewardCouldGet(slot0, slot1, slot2)
	if not slot0:getType101SpInfoMo(slot1, slot2) then
		return false
	end

	return slot3:isAvailable()
end

function slot0.isType101SpRewardGot(slot0, slot1, slot2)
	if not slot0:getType101SpInfoMo(slot1, slot2) then
		return false
	end

	return slot3:isReceived()
end

function slot0.setSpBonusGet(slot0, slot1)
	if not slot0:getType101SpInfoMo(slot1.activityId, slot1.id) then
		return
	end

	slot4:setState_Received()
end

function slot0.isType101SpRewardCouldGetAnyOne(slot0, slot1)
	if not slot0:getType101SpInfo(slot1) then
		return false
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7:isAvailable() then
			return true
		end
	end

	return false
end

function slot0.claimAll(slot0, slot1, slot2, slot3)
	if uv0.instance:getType101LoginCount(slot1) == 0 then
		if slot2 then
			slot2(slot3)
		end

		return
	end

	if not slot0:getType101Info(slot1) then
		if slot2 then
			slot2(slot3)
		end

		return
	end

	slot6 = {}

	for slot10, slot11 in pairs(slot5) do
		if slot11.state == uv1 then
			slot6[#slot6 + 1] = slot11.id
		end
	end

	for slot10, slot11 in ipairs(slot6) do
		slot12, slot13 = nil

		if slot10 == #slot6 then
			slot12 = slot2
			slot13 = slot3
		end

		Activity101Rpc.instance:sendGet101BonusRequest(slot1, slot11, slot12, slot13)
	end
end

slot0.instance = slot0.New()

return slot0
