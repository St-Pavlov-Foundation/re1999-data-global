module("modules.logic.turnback.model.TurnbackRecommendModel", package.seeall)

slot0 = class("TurnbackRecommendModel", BaseModel)

function slot0.onInit(slot0)
	slot0.recommendOpenMap = {}
	slot0.turnbackId = 0
end

function slot0.reInit(slot0)
	slot0.recommendOpenMap = {}
	slot0.turnbackId = 0
end

function slot0.initReommendShowState(slot0, slot1)
	slot0.turnbackId = slot1

	for slot6, slot7 in pairs(TurnbackConfig.instance:getAllRecommendCo(slot1) or {}) do
		if not slot0.recommendOpenMap[slot1] then
			slot0.recommendOpenMap[slot1] = {}
		end

		slot0.recommendOpenMap[slot1][slot6] = slot0:checkReommendShowState(slot1, slot6)
	end
end

function slot0.checkReommendShowState(slot0, slot1, slot2)
	if not TurnbackConfig.instance:getRecommendCo(slot1, slot2) then
		return false
	end

	slot4 = slot0:checkRecommendIsInTime(slot3)
	slot5 = true

	if string.nilorempty(slot3.relateActId) and slot3.openId > 0 then
		slot5 = OpenModel.instance:isFunctionUnlock(slot3.openId)
	end

	return slot4 and slot5
end

function slot0.checkRecommendIsInTime(slot0, slot1)
	slot2 = TurnbackModel.instance:getLeaveTime()
	slot3 = 0
	slot4 = 0
	slot5 = 0

	if not string.nilorempty(slot1.onlineTime) then
		slot4 = TimeUtil.stringToTimestamp(slot1.onlineTime)
	end

	if not string.nilorempty(slot1.offlineTime) then
		slot5 = TimeUtil.stringToTimestamp(slot1.offlineTime)
	end

	if not string.nilorempty(slot1.constTime) then
		slot3 = TimeUtil.stringToTimestamp(slot1.constTime)
	end

	slot9 = slot6 and ServerTime.now() - slot4 >= 0
	slot10 = slot7 and ServerTime.now() - slot5 > 0
	slot11 = slot8 and slot3 - slot2 > 0 and slot2 > 0
	slot12 = slot0:checkHasOpenRelateAct(slot1)
	slot13 = not string.nilorempty(slot1.relateActId)

	if slot2 <= 0 then
		return false
	end

	if slot13 and slot12 and slot11 then
		return true
	elseif slot13 and slot12 and not slot8 then
		return true
	elseif not slot13 and not slot8 then
		return true
	elseif not slot13 and slot9 and not slot10 and slot11 then
		return true
	else
		return false
	end
end

function slot0.checkHasOpenRelateAct(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1.relateActId) then
		slot7 = "#"

		for slot7, slot8 in ipairs(string.splitToNumber(slot1.relateActId, slot7)) do
			if ActivityHelper.getActivityStatusAndToast(slot8) == ActivityEnum.ActivityStatus.Normal then
				return true
			end
		end
	end

	return false
end

function slot0.checkRecommendCanShow(slot0, slot1)
	if not string.nilorempty(slot1.prepose) then
		for slot6, slot7 in pairs(string.splitToNumber(slot1.prepose, "#")) do
			if not TurnbackConfig.instance:getRecommendCo(slot0.turnbackId, slot7) then
				logError("推荐页或前置推荐页id不存在,请检查配置，id: " .. tostring(slot7))

				return
			end

			if slot0:checkRecommendCanShow(slot8) then
				return false
			end
		end
	end

	return slot0.recommendOpenMap[slot0.turnbackId][slot1.id]
end

function slot0.getCanShowRecommendList(slot0)
	slot1 = {}
	slot4 = TurnbackConfig.instance
	slot6 = slot4
	slot7 = slot0.turnbackId

	for slot6, slot7 in pairs(tabletool.copy(slot4.getAllRecommendCo(slot6, slot7))) do
		if slot0:checkRecommendCanShow(slot7) then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.getCanShowRecommendCount(slot0)
	return #slot0:getCanShowRecommendList()
end

slot0.instance = slot0.New()

return slot0
