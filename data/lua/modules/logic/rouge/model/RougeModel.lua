module("modules.logic.rouge.model.RougeModel", package.seeall)

slot0 = class("RougeModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0._rougeInfo = nil
end

function slot0.updateRougeInfo(slot0, slot1)
	slot0._rougeInfo = slot0._rougeInfo or RougeInfoMO.New()

	slot0._rougeInfo:init(slot1)

	if slot1:HasField("mapInfo") then
		slot0._mapModel = RougeMapModel.instance

		slot0._mapModel:updateMapInfo(slot1.mapInfo)
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfo)
end

function slot0.updateResultInfo(slot0, slot1)
	slot0._rougeResult = slot0._rougeResult or RougeResultMO.New()

	slot0._rougeResult:init(slot1)
end

function slot0.getRougeInfo(slot0)
	return slot0._rougeInfo
end

function slot0.getRougeResult(slot0)
	return slot0._rougeResult
end

function slot0.getMapModel(slot0)
	return slot0._mapModel
end

function slot0.getSeason(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.season
end

function slot0.getVersion(slot0)
	if not slot0:inRouge() then
		return RougeOutsideModel.instance:getRougeGameRecord() and slot2:getVersionIds() or {}
	end

	return slot0._rougeInfo and slot0._rougeInfo.version or nil or {}
end

function slot0.getDifficulty(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.difficulty or nil
end

function slot0.getStyle(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.style or nil
end

function slot0.getTeamCapacity(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.teamSize
end

function slot0.getTeamInfo(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.teamInfo
end

function slot0.updatePower(slot0, slot1, slot2)
	if not slot0._rougeInfo then
		return
	end

	slot0._rougeInfo.power = slot1
	slot0._rougeInfo.powerLimit = slot2

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoPower)
end

function slot0.updateTeamInfo(slot0, slot1)
	slot0._rougeInfo:updateTeamInfo(slot1)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTeamInfo)
end

function slot0.updateTeamLife(slot0, slot1)
	slot0._rougeInfo:updateTeamLife(slot1)
end

function slot0.updateExtraHeroInfo(slot0, slot1)
	slot0._rougeInfo:updateExtraHeroInfo(slot1)
end

function slot0.updateTeamLifeAndDispatchEvent(slot0, slot1)
	slot0._rougeInfo:updateTeamLifeAndDispatchEvent(slot1)
end

function slot0.updateTalentInfo(slot0, slot1)
	slot0._rougeInfo:updateTalentInfo(slot1)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentInfo)
end

function slot0.isContinueLast(slot0)
	if not slot0._rougeInfo then
		return false
	end

	return slot0._rougeInfo:isContinueLast()
end

function slot0.clear(slot0)
	slot0._mapModel = nil
	slot0._rougeInfo = nil
	slot0._isAbort = nil
	slot0._rougeResult = nil
	slot0._initHeroDict = nil

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfo)
end

function slot0.isCanSelectRewards(slot0)
	if not slot0._rougeInfo then
		return false
	end

	return slot0._rougeInfo:isCanSelectRewards()
end

function slot0.isFinishedDifficulty(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.state == RougeEnum.State.Difficulty
end

function slot0.isFinishedLastReward(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.state == RougeEnum.State.LastReward
end

function slot0.isFinishedStyle(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.state == RougeEnum.State.Style
end

function slot0.isStarted(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.state == RougeEnum.State.Start
end

function slot0.isFinish(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.state == RougeEnum.State.isEnd
end

function slot0.getState(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.state or RougeEnum.State.Empty
end

function slot0.inRouge(slot0)
	return slot0:getState() ~= RougeEnum.State.Empty and slot1 ~= RougeEnum.State.isEnd
end

function slot0.getEndId(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.endId
end

function slot0.updateFightResultMo(slot0, slot1)
	if not slot0.fightResultMo then
		slot0.fightResultMo = RougeFightResultMO.New()
	end

	slot0.fightResultMo:init(slot1)
end

function slot0.getFightResultInfo(slot0)
	return slot0.fightResultMo
end

function slot0.getLastRewardList(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.lastReward or {}
end

function slot0.getSelectRewardNum(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.selectRewardNum or 0
end

function slot0.getRougeRetryNum(slot0)
	return slot0._rougeInfo and slot0._rougeInfo.retryNum or 0
end

function slot0.updateRetryNum(slot0, slot1)
	if slot0._rougeInfo then
		slot0._rougeInfo.retryNum = slot1
	end
end

function slot0.isRetryFight(slot0)
	if not slot0:getRougeRetryNum() then
		return false
	end

	return slot1 > 0
end

function slot0.getEffectDict(slot0)
	return slot0._rougeInfo and slot0._rougeInfo:getEffectDict()
end

function slot0.isAbortRouge(slot0)
	return slot0._isAbort
end

function slot0.onAbortRouge(slot0)
	slot0._isAbort = true
end

function slot0.getDeadHeroNum(slot0)
	return slot0._rougeInfo and slot0._rougeInfo:getDeadHeroNum() or 0
end

function slot0.setTeamInitHeros(slot0, slot1)
	slot0._initHeroDict = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot0._initHeroDict[slot6] = true
		end
	end
end

function slot0.isInitHero(slot0, slot1)
	slot2 = false

	if slot1 then
		slot2 = slot0._initHeroDict and slot0._initHeroDict[slot1]
	end

	return slot2
end

function slot0.getInitHeroIds(slot0)
	slot1 = {}

	if slot0._initHeroDict then
		for slot5, slot6 in pairs(slot0._initHeroDict) do
			slot1[#slot1 + 1] = slot5
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
