module("modules.logic.guide.model.GuideModel", package.seeall)

slot0 = class("GuideModel", BaseModel)
slot0.GuideFlag = {
	FightForbidRoundView = 3,
	SeasonDiscount = 28,
	FightForbidCloseSkilltip = 25,
	FightForbidLongPressCard = 2,
	MaskUseMainCamera = 23,
	FightDoingEnterPassedEpisode = 10,
	FightForbidClickTechnique = 7,
	SkipShowDungeonMapLevelView = 26,
	KeepEpisodeItemLock = 29,
	FightDoingSubEntity = 5,
	PinballBanOper = 34,
	DontOpenMain = 24,
	FightBackSkipDungeonView = 9,
	UseBlock = 17,
	FightForbidAutoFight = 4,
	FightForbidRestrainTag = 6,
	FightForbidClickOpenView = 15,
	MainViewGuideId = 32,
	SkipShowElementAnim = 19,
	FightForbidSpeed = 8,
	MoveFightBtn2MapView = 21,
	FightMoveCard = 1,
	SkipInitElement = 20,
	PutTalent = 22,
	MainViewGuideBlock = 31,
	TianShiNaNaBanOper = 33,
	ForceJumpToMainView = 14,
	DelayGetPointReward = 18,
	Guidepost = 12,
	SeasonUTTU = 27,
	SkipClickElement = 13,
	RoomForbidBtn = 16,
	FightSetSpecificCardIndex = 30,
	FightLeadRoleSkillGuide = 11
}

function slot0.onInit(slot0)
	slot0._stepExecList = {}
	slot0._guideHasSetFlag = {}
	slot0._guideFlagDict = {}
	slot0._firstOpenMainViewTime = nil
	slot0._gmStartGuideId = nil
	slot0._fixNextStepGOPathDict = {}
	slot0._lockGuideId = nil
	slot0._guideParam = {
		OnPushBoxWinPause = false
	}
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.execStep(slot0, slot1, slot2)
	slot0:addStepLog(string.format("%d_%d", slot1, slot2))
end

function slot0.onClickJumpGuides(slot0)
	slot0:addStepLog("click jump all guides")
end

function slot0.addStepLog(slot0, slot1)
	if #slot0._stepExecList >= 10 then
		table.remove(slot0._stepExecList, 1)
	end

	table.insert(slot0._stepExecList, slot1)
end

function slot0.getStepExecStr(slot0)
	return table.concat(slot0._stepExecList, ",")
end

function slot0.onOpenMainView(slot0)
	if slot0._firstOpenMainViewTime == nil then
		slot0._firstOpenMainViewTime = Time.time
	end
end

function slot0.setFlag(slot0, slot1, slot2, slot3)
	if slot3 then
		slot0._guideHasSetFlag[slot3] = slot0._guideHasSetFlag[slot3] or {}
		slot0._guideHasSetFlag[slot3][slot1] = slot2
	end

	slot0._guideFlagDict[slot1] = slot2
end

function slot0.isFlagEnable(slot0, slot1)
	if slot0._guideFlagDict[slot1] ~= nil then
		return true
	end

	return false
end

function slot0.getFlagValue(slot0, slot1)
	return slot0._guideFlagDict[slot1]
end

function slot0.clearFlagByGuideId(slot0, slot1)
	slot0._guideHasSetFlag[slot1] = nil

	if slot0._guideHasSetFlag[slot1] then
		for slot6, slot7 in pairs(slot2) do
			if slot7 then
				slot0._guideFlagDict[slot6] = nil
			end
		end
	end
end

function slot0.setGuideList(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot1 do
		if GuideConfig.instance:getGuideCO(slot1[slot6].guideId) then
			if GuideConfig.instance:getStepList(slot7.guideId) then
				slot10 = GuideMO.New()

				slot10:init(slot7)
				table.insert(slot2, slot10)
			else
				logError("guide step config not exist: " .. slot7.guideId)
			end
		else
			logError("guide config not exist: " .. slot7.guideId)
		end
	end

	slot0:addList(slot2)
end

function slot0.updateGuideList(slot0, slot1)
	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]

		slot0:setGMGuideStep(slot6)

		if slot0:getById(slot6.guideId) == nil then
			if slot0._firstOpenMainViewTime and Time.time - slot0._firstOpenMainViewTime < 6 then
				logNormal(string.format("<color=#FFA500>login trigger guide_%d</color>", slot6.guideId))
				GuideMO.New():init(slot6)
			else
				slot7:updateGuide(slot6)
			end

			slot0:addAtLast(slot7)
		elseif slot7.isFinish then
			logNormal(string.format("<color=#FFA500>restart guide_%d</color>", slot6.guideId))
			slot7:init(slot6)
		else
			slot7:updateGuide(slot6)
		end
	end
end

function slot0.addEmptyGuide(slot0, slot1)
	if slot0:getById(slot1) == nil then
		slot2 = GuideMO.New()
		slot2.id = slot1

		slot0:addAtLast(slot2)
	end
end

function slot0.clientFinishStep(slot0, slot1, slot2)
	slot0:getById(slot1):setClientStep(slot2)
end

function slot0.isDoingFirstGuide(slot0)
	return slot0:getDoingGuideId() == 101
end

function slot0.lastForceGuideId(slot0)
	return 108
end

function slot0.getDoingGuideId(slot0)
	if slot0:getDoingGuideIdList() then
		for slot5 = #slot1, 1, -1 do
			if GuideConfig.instance:getGuideCO(slot1[slot5]).parallel == 1 or GuideInvalidController.instance:isInvalid(slot6.id) then
				table.remove(slot1, slot5)
			end
		end

		return GuideConfig.instance:getHighestPriorityGuideId(slot1)
	end
end

function slot0.getDoingGuideIdList(slot0)
	slot1 = nil

	for slot6 = 1, #slot0:getList() do
		if not slot2[slot6].isFinish or slot7.currStepId > 0 then
			table.insert(slot1 or {}, slot2[slot6].id)
		end
	end

	return slot1
end

function slot0.isDoingClickGuide(slot0)
	for slot5 = 1, #slot0:getList() do
		if (not slot1[slot5].isFinish or slot6.currStepId > 0) and not string.nilorempty(uv0.instance:getStepGOPath(slot6.id, slot6.currStepId)) then
			return true
		end
	end

	return false
end

function slot0.isGuideRunning(slot0, slot1)
	if slot0:getById(slot1) and not slot2.isFinish then
		return true
	end

	return false
end

function slot0.isGuideFinish(slot0, slot1)
	if slot0:getById(slot1) and slot2.isFinish then
		return true
	end

	return false
end

function slot0.isStepFinish(slot0, slot1, slot2)
	if slot0:isGuideFinish(slot1) then
		return true
	end

	if slot0:getById(slot1) and slot2 < slot3.currStepId then
		return true
	end

	return false
end

function slot0.setLockGuide(slot0, slot1, slot2)
	if slot0._lockGuideId and not slot0:isGuideFinish(slot0._lockGuideId) and not slot2 then
		logNormal(string.format("<color=#FFA500>setLockGuide old:%s new:%s</color>", slot0._lockGuideId, slot1))

		return
	end

	slot0._lockGuideId = slot1

	logNormal(string.format("<color=#FFA500>setLockGuide guideId:%s</color>", slot0._lockGuideId))
end

function slot0.getLockGuideId(slot0)
	if slot0._lockGuideId and slot0:isGuideFinish(slot0._lockGuideId) then
		slot0._lockGuideId = nil
	end

	return slot0._lockGuideId
end

function slot0.gmStartGuide(slot0, slot1, slot2)
	slot0._gmStartGuideId = slot1
	slot0._gmStartGuideStep = slot2
end

function slot0.setGMGuideStep(slot0, slot1)
	if not slot1 or slot1.guideId ~= slot0._gmStartGuideId or not slot0._gmStartGuideStep then
		return
	end

	slot1.stepId = slot0._gmStartGuideStep
	slot0._gmStartGuideStep = nil

	logNormal(string.format("<color=#FF0000>setGMGuideStep guideId:%d step:%d</color>", slot1.guideId, slot1.stepId))
end

function slot0.isGMStartGuide(slot0, slot1)
	return slot1 == slot0._gmStartGuideId
end

function slot0.setNextStepGOPath(slot0, slot1, slot2, slot3)
	if GuideConfig.instance:getNextStepId(slot1, slot2) then
		slot0._fixNextStepGOPathDict[slot1] = slot0._fixNextStepGOPathDict[slot1] or {}
		slot0._fixNextStepGOPathDict[slot1][slot4] = slot3
	end
end

function slot0.getStepGOPath(slot0, slot1, slot2)
	if slot0._fixNextStepGOPathDict[slot1] and slot0._fixNextStepGOPathDict[slot1][slot2] then
		return slot3
	end

	return GuideConfig.instance:getStepCO(slot1, slot2) and slot3.goPath
end

function slot0.getGuideParam(slot0)
	return slot0._guideParam
end

slot0.instance = slot0.New()

return slot0
