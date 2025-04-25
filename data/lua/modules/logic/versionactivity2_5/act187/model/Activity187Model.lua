module("modules.logic.versionactivity2_5.act187.model.Activity187Model", package.seeall)

slot0 = class("Activity187Model", BaseModel)

function slot0.onInit(slot0)
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
	slot0:setLoginCount()
	slot0:setRemainPaintingCount()
	slot0:setFinishPaintingIndex()
	slot0:setAccrueRewardIndex()

	slot0._paintingRewardDict = {}
end

function slot0.checkActId(slot0, slot1)
	if not (slot1 == slot0:getAct187Id()) then
		logError(string.format("Activity187Model:setServerInfo error, not same actId, server:%s, local:%s", slot1, slot2))
	end

	return slot3
end

function slot0.setAct187Info(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:setLoginCount(slot1.loginCount)
	slot0:setRemainPaintingCount(slot1.haveGameCount)
	slot0:setFinishPaintingIndex(slot1.finishGameCount)
	slot0:setAccrueRewardIndex(slot1.acceptRewardGameCount)
	slot0:setAllPaintingReward(slot1.randomBonusInfos)
end

function slot0.setLoginCount(slot0, slot1)
	slot0._loginCount = slot1 or 0
end

function slot0.setRemainPaintingCount(slot0, slot1)
	slot0._remainPaintingCount = slot1 or 0
end

function slot0.setFinishPaintingIndex(slot0, slot1)
	slot0._finishPaintingIndex = slot1 or 0
end

function slot0.setAccrueRewardIndex(slot0, slot1)
	slot0._accrueRewardIndex = slot1 or 0
end

function slot0.setAllPaintingReward(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:setPaintingRewardList(slot5, slot6.randomBonusList)
	end
end

function slot0.setPaintingRewardList(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot2) do
		slot9 = MaterialDataMO.New()

		slot9:initValue(slot8.materilType, slot8.materilId, slot8.quantity)
		table.insert(slot3, slot9)
	end

	slot0._paintingRewardDict[slot1] = slot3
end

function slot0.getAct187Id(slot0)
	return VersionActivity2_5Enum.ActivityId.LanternFestival
end

function slot0.isAct187Open(slot0, slot1)
	slot2, slot3, slot4 = nil

	if ActivityModel.instance:getActivityInfo()[slot0:getAct187Id()] then
		slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(slot5)
	else
		slot3 = ToastEnum.ActivityEnd
	end

	if slot1 and slot3 then
		GameFacade.showToast(slot3, slot4)
	end

	return slot2 == ActivityEnum.ActivityStatus.Normal
end

function slot0.getAct187RemainTimeStr(slot0)
	slot1 = ""

	if ActivityModel.instance:getActMO(slot0:getAct187Id()) then
		slot1 = string.format(luaLang("remain"), slot3:getRemainTimeStr3())
	end

	return slot1
end

function slot0.getLoginCount(slot0)
	return slot0._loginCount
end

function slot0.getRemainPaintingCount(slot0)
	return slot0._remainPaintingCount
end

function slot0.getFinishPaintingIndex(slot0)
	return slot0._finishPaintingIndex
end

function slot0.getAccrueRewardIndex(slot0)
	return slot0._accrueRewardIndex
end

function slot0.getPaintingRewardList(slot0, slot1)
	return slot0._paintingRewardDict and slot0._paintingRewardDict[slot1] or {}
end

function slot0.getPaintingRewardId(slot0, slot1)
	slot2 = nil

	if slot0:getPaintingRewardList(slot1) and #slot3 then
		for slot7, slot8 in ipairs(slot3) do
			slot9 = string.format("%s#%s", slot8.materilType, slot8.materilId)
			slot2 = string.nilorempty(slot2) and slot9 or string.format("%s|%s", slot9, slot9)
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
