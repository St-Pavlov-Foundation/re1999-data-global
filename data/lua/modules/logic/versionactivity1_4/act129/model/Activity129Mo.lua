module("modules.logic.versionactivity1_4.act129.model.Activity129Mo", package.seeall)

slot0 = class("Activity129Mo")

function slot0.ctor(slot0, slot1)
	slot0.activityId = slot1
	slot0.id = slot1

	slot0:initCfg()
end

function slot0.initCfg(slot0)
	slot0.poolDict = {}

	if Activity129Config.instance:getPoolDict(slot0.activityId) then
		for slot5, slot6 in pairs(slot1) do
			slot0.poolDict[slot6.poolId] = Activity129PoolMo.New(slot6)
		end
	end
end

function slot0.init(slot0, slot1)
	for slot5 = 1, #slot1.lotteryDetail do
		if slot0:getPoolMo(slot1.lotteryDetail[slot5].poolId) then
			slot7:init(slot6)
		else
			logError(string.format("cant find poolCfg，poolId:%s", slot6.poolId))
		end
	end
end

function slot0.onLotterySuccess(slot0, slot1)
	if slot0:getPoolMo(slot1.poolId) then
		slot2:onLotterySuccess(slot1)
	else
		logError(string.format("cant find poolCfg，poolId:%s", slot1.poolId))
	end
end

function slot0.getPoolMo(slot0, slot1)
	return slot0.poolDict[slot1]
end

function slot0.checkPoolIsEmpty(slot0, slot1)
	return slot0:getPoolMo(slot1) and slot2:checkPoolIsEmpty()
end

return slot0
