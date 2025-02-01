module("modules.logic.rouge.model.RougeRewardModel", package.seeall)

slot0 = class("RougeRewardModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.setReward(slot0, slot1)
	if not slot0._season then
		slot0._season = RougeOutsideModel.instance:season()
	end

	if slot1.point then
		slot0.point = slot1.point
	end

	if slot1.bonus then
		if #slot1.bonus.bonusStages > 0 then
			slot0:_initStageInfo(slot1.bonus.bonusStages)
		end

		slot0._isNewStage = slot1.bonus.isNewStage
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeRewardInfo)
end

function slot0.updateReward(slot0, slot1)
	if slot1 and next(slot1) then
		slot0:_updateStageInfo(slot1)
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeRewardInfo)
end

function slot0._initStageInfo(slot0, slot1)
	if not slot0._stageInfo then
		slot0._stageInfo = {}
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:_updateStageInfo(slot6)
	end
end

function slot0._updateStageInfo(slot0, slot1)
	if not slot0._stageInfo then
		slot0._stageInfo = {}
	end

	if not slot0._stageInfo[slot1.stage] then
		slot0._stageInfo[slot1.stage] = {}
	end

	slot0._stageInfo[slot1.stage] = slot1.bonusIds
end

function slot0.checkCanGetBigReward(slot0, slot1)
	if slot0:getLastRewardCounter(slot1) < RougeRewardConfig.instance:getNeedUnlockNum(slot1) then
		return false
	end

	return true
end

function slot0.getRewardPoint(slot0)
	return slot0.point or 0
end

function slot0.checkIsNewStage(slot0)
	return slot0._isNewStage
end

function slot0.setNewStage(slot0, slot1)
	slot0._isNewStage = slot1
end

function slot0.checkRewardCanGet(slot0, slot1, slot2)
	if not slot0:isStageUnLock(slot1) then
		return
	end

	if RougeRewardConfig.instance:getConfigById(slot0._season, slot2).type == 3 then
		return true
	end

	if not slot0:checkRewardGot(slot1, slot3.preId) then
		return false
	end

	return true
end

function slot0.checkRewardGot(slot0, slot1, slot2)
	if not slot0._stageInfo or not next(slot0._stageInfo) then
		return
	end

	if not slot0:isStageUnLock(slot1) then
		return false
	end

	if slot0._stageInfo[slot1] then
		for slot7, slot8 in ipairs(slot3) do
			if slot2 == slot8 then
				return true
			end
		end
	end

	return false
end

function slot0.getHadConsumeRewardPoint(slot0)
	slot1 = 0

	if not slot0._stageInfo or #slot0._stageInfo == 0 then
		return 0
	end

	for slot5, slot6 in ipairs(slot0._stageInfo) do
		slot7 = false

		if slot0:checkBigRewardGot(slot5) then
			slot7 = true
		end

		if slot6 and #slot6 > 0 then
			slot1 = slot1 + #slot6
		end

		if slot7 and slot1 > 0 then
			slot1 = slot1 - 1
		end
	end

	return slot1
end

function slot0.getHadGetRewardPoint(slot0)
	slot2 = slot0:getHadConsumeRewardPoint()
	slot4 = RougeRewardConfig.instance:getPointLimitByStage(slot0._season, slot0:getLastOpenStage())

	if slot0.point then
		slot2 = slot4 < slot1 + slot0.point and slot4 or slot5
	end

	return slot2
end

function slot0.isStageOpen(slot0, slot1)
	if slot1 == 1 or slot1 == 2 then
		return true
	end

	if not string.nilorempty(RougeRewardConfig.instance:getStageRewardConfigById(slot0._season, slot1).openTime) then
		return TimeUtil.stringToTimestamp(slot2.openTime) <= ServerTime.now()
	end

	return false
end

function slot0.isShowNextStageTag(slot0, slot1)
	slot3 = 1

	for slot7, slot8 in ipairs(RougeRewardConfig.instance:getStageRewardConfig(slot0._season)) do
		if slot7 < #slot2 and not slot0:isStageOpen(slot8.stage) then
			slot3 = slot8.stage

			break
		end
	end

	if slot1 == slot3 and slot3 ~= slot2[#slot2].stage then
		return true
	end

	return false
end

function slot0.isStageUnLock(slot0, slot1)
	if not slot0._season then
		slot0._season = RougeOutsideModel.instance:season()
	end

	if slot1 == 1 then
		return true
	end

	if not slot0:isStageOpen(slot1) then
		return false
	end

	if slot0:isStageClear(RougeRewardConfig.instance:getStageRewardConfigById(slot0._season, slot1).preStage) then
		return true
	else
		return false
	end
end

function slot0.isStageClear(slot0, slot1)
	if not slot0._stageInfo or #slot0._stageInfo == 0 then
		return
	end

	if not slot0._stageInfo[slot1] then
		return false
	end

	if RougeRewardConfig.instance:getRewardStageDictNum(slot1) > #slot2 then
		return false
	end

	return true
end

function slot0.getLastOpenStage(slot0)
	slot3 = 1

	for slot7 = 1, RougeRewardConfig.instance:getStageRewardCount(RougeOutsideModel.instance:season()) do
		if slot0:isStageOpen(slot7) then
			slot3 = slot7
		else
			return slot3
		end
	end

	return slot3
end

function slot0.getLastUnlockStage(slot0)
	slot3 = 1

	for slot7 = 1, RougeRewardConfig.instance:getStageRewardCount(RougeOutsideModel.instance:season()) do
		if slot0:isStageUnLock(slot7) then
			slot3 = slot7
		else
			return slot3
		end
	end

	return slot3
end

function slot0.checkOpenStage(slot0, slot1)
	slot2 = RougeRewardConfig.instance:getBigRewardToStageConfigById(slot1)
	slot3 = false
	slot4 = nil

	if slot1 == 1 then
		for slot8, slot9 in pairs(slot2) do
			if slot0:isStageUnLock(slot9.stage) then
				slot3 = true
				slot4 = slot9.stage
			end
		end
	else
		for slot8, slot9 in pairs(slot2) do
			if slot0:isStageOpen(slot9.stage) then
				slot3 = true
				slot4 = slot9.stage
			end
		end
	end

	if slot3 then
		return slot4
	end
end

function slot0.getLastRewardCounter(slot0, slot1)
	if not slot0._stageInfo or #slot0._stageInfo == 0 then
		return 0
	end

	if not slot0._stageInfo[slot1] then
		return slot2
	end

	slot4 = RougeRewardConfig.instance:getConfigByStage(slot1)

	for slot8, slot9 in ipairs(slot3) do
		for slot13, slot14 in ipairs(slot4) do
			if slot14.id == slot9 and slot14.type == 2 then
				slot2 = slot2 + 1
			end
		end
	end

	return slot2
end

function slot0.checShowBigRewardGot(slot0, slot1)
	for slot7, slot8 in ipairs(RougeRewardConfig.instance:getBigRewardToStageConfigById(slot1)) do
		if slot0:checkBigRewardGot(slot8.stage) then
			slot3 = 0 + 1
		end
	end

	if #slot2 == slot3 then
		return true
	end

	return false
end

function slot0.checkBigRewardGot(slot0, slot1)
	if not slot0._stageInfo or #slot0._stageInfo == 0 then
		return false
	end

	if not slot0._stageInfo[slot1] then
		return false
	end

	for slot6, slot7 in ipairs(slot2) do
		if RougeRewardConfig.instance:getConfigById(slot0._season, slot7).type == 1 then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
