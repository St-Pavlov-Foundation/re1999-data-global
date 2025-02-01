module("modules.logic.rouge.model.RougeOutsideModel", package.seeall)

slot0 = class("RougeOutsideModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0:_setRougeSeason(nil, RougeConfig1.instance:season())
end

function slot0.onReceiveGetRougeOutsideInfoReply(slot0, slot1)
	slot0:updateRougeOutsideInfo(slot1.rougeInfo)
end

function slot0.updateRougeOutsideInfo(slot0, slot1)
	slot0:_setRougeSeason(slot1)

	slot0._rougeGameRecord = slot0._rougeGameRecord or RougeGameRecordInfoMO.New()

	slot0._rougeGameRecord:init(slot1.gameRecordInfo)
	RougeFavoriteModel.instance:initReviews(slot1.review)
	RougeOutsideController.instance:dispatchEvent(RougeEvent.OnUpdateRougeOutsideInfo)
end

function slot0.getRougeGameRecord(slot0)
	return slot0._rougeGameRecord
end

function slot0._setRougeSeason(slot0, slot1, slot2)
	if slot1 ~= nil then
		slot0._rougeInfo = slot1
	else
		assert(tonumber(slot2))

		slot0._rougeInfo = RougeOutsideModule_pb.GetRougeOutsideInfoReply()

		rawset(slot0._rougeInfo, "season", slot2)
	end

	slot2 = slot2 or slot0:season()

	if not slot0._config or slot0._config:season() ~= slot2 then
		slot0._config = _G["RougeConfig" .. slot2].instance
	end
end

function slot0.config(slot0)
	return slot0._config
end

function slot0.openUnlockId(slot0)
	return slot0._config:openUnlockId()
end

function slot0.season(slot0)
	slot1 = nil

	if slot0._rougeInfo then
		slot1 = slot0._rougeInfo.season
	end

	if not slot1 and slot0._config then
		slot1 = slot0._config:season()
	end

	if not slot1 then
		return 1
	end

	return math.max(slot1, 1)
end

function slot0.isUnlock(slot0)
	return OpenModel.instance:isFunctionUnlock(slot0:openUnlockId())
end

function slot0.passedDifficulty(slot0)
	if not slot0._rougeGameRecord then
		return 0
	end

	return slot0._rougeGameRecord.maxDifficulty or 0
end

function slot0.isPassedDifficulty(slot0, slot1)
	return slot1 <= slot0:passedDifficulty()
end

function slot0.isOpenedDifficulty(slot0, slot1)
	return slot0:isPassedDifficulty(slot0._config:getDifficultyCO(slot1).preDifficulty)
end

function slot0.isOpenedStyle(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._config:getStyleConfig(slot1).unlockType or slot3 == 0 then
		return true
	end

	return RougeMapUnlockHelper.checkIsUnlock(slot3, slot2.unlockParam)
end

function slot0.endCdTs(slot0)
	if not slot0._rougeGameRecord then
		return 0
	end

	if slot0._rougeGameRecord:lastGameEndTimestamp() <= 0 then
		return 0
	end

	if slot0._config:getAbortCDDuration() == 0 then
		return 0
	end

	return slot1 + slot2
end

function slot0.leftCdSec(slot0)
	return slot0:endCdTs() - ServerTime.now()
end

function slot0.isInCdStart(slot0)
	return slot0:leftCdSec() > 0
end

function slot0.getDifficultyInfoList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0._config:getDifficultyCOListByVersions(slot1)) do
		slot9 = slot8.difficulty

		table.insert(slot3, {
			difficulty = slot9,
			difficultyCO = slot8,
			isUnLocked = slot0:isOpenedDifficulty(slot9)
		})
	end

	table.sort(slot3, function (slot0, slot1)
		if slot0.difficulty ~= slot1.difficulty then
			return slot2 < slot3
		end
	end)

	return slot3
end

function slot0.getStyleInfoList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0._config:getStyleCOListByVersions(slot1)) do
		slot3[#slot3 + 1] = slot0:_createStyleMo(slot8)
	end

	table.sort(slot3, uv0._styleSortFunc)

	return slot3
end

function slot0._createStyleMo(slot0, slot1)
	slot2 = slot1.id

	return {
		style = slot2,
		styleCO = slot1,
		isUnLocked = slot0:isOpenedStyle(slot2)
	}
end

function slot0._styleSortFunc(slot0, slot1)
	if (slot0.isUnLocked and 1 or 0) ~= (slot1.isUnLocked and 1 or 0) then
		return slot3 < slot2
	end

	return slot0.style < slot1.style
end

function slot0.getSeasonStyleInfoList(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._config:getSeasonStyleConfigs()) do
		slot2[#slot2 + 1] = slot0:_createStyleMo(slot7)
	end

	table.sort(slot2, uv0._styleSortFunc)

	return slot2
end

slot1 = 1
slot2 = 0

function slot0.getIsNewUnlockDifficulty(slot0, slot1)
	return slot0:_getUnlockDifficulty(slot1, uv0) == uv1
end

function slot0.setIsNewUnlockDifficulty(slot0, slot1, slot2)
	slot0:_saveUnlockDifficulty(slot1, slot2 and uv0 or uv1)
end

function slot0.getIsNewUnlockStyle(slot0, slot1)
	return slot0:_getUnlockStyle(slot1, uv0) == uv1
end

function slot0.setIsNewUnlockStyle(slot0, slot1, slot2)
	slot0:_saveUnlockStyle(slot1, slot2 and uv0 or uv1)
end

slot3 = "RougeOutside|"
slot4 = "LastMark|"

function slot0._getPrefsKeyPrefix(slot0)
	return uv0 .. tostring(slot0:season()) .. tostring(table.concat(RougeModel.instance:getVersion(), "#"))
end

function slot0._saveInteger(slot0, slot1, slot2)
	GameUtil.playerPrefsSetNumberByUserId(slot1, slot2)
end

function slot0._getInteger(slot0, slot1, slot2)
	return GameUtil.playerPrefsGetNumberByUserId(slot1, slot2)
end

slot5 = "D|"

function slot0._getPrefsKeyDifficulty(slot0, slot1)
	assert(type(slot1) == "number")

	return slot0:_getPrefsKeyPrefix() .. uv0 .. tostring(slot1)
end

function slot0._saveUnlockDifficulty(slot0, slot1, slot2)
	slot0:_saveInteger(slot0:_getPrefsKeyDifficulty(slot1), slot2)
end

function slot0._getUnlockDifficulty(slot0, slot1, slot2)
	return slot0:_getInteger(slot0:_getPrefsKeyDifficulty(slot1), slot2)
end

function slot0._getPrefsKeyLastMarkDifficulty(slot0)
	return slot0:_getPrefsKeyPrefix() .. uv0 .. uv1
end

function slot0.setLastMarkSelectedDifficulty(slot0, slot1)
	slot0:_saveInteger(slot0:_getPrefsKeyLastMarkDifficulty(), slot1)
end

function slot0.getLastMarkSelectedDifficulty(slot0, slot1)
	return slot0:_getInteger(slot0:_getPrefsKeyLastMarkDifficulty(), slot1)
end

slot6 = "S|"

function slot0._getPrefsKeyStyle(slot0, slot1)
	assert(type(slot1) == "number")

	return slot0:_getPrefsKeyPrefix() .. uv0 .. tostring(slot1)
end

function slot0._saveUnlockStyle(slot0, slot1, slot2)
	slot0:_saveInteger(slot0:_getPrefsKeyStyle(slot1), slot2)
end

function slot0._getUnlockStyle(slot0, slot1, slot2)
	return slot0:_getInteger(slot0:_getPrefsKeyStyle(slot1), slot2)
end

function slot0.passedLayerId(slot0, slot1)
	if not slot0._rougeGameRecord then
		return false
	end

	return slot0._rougeGameRecord:passedLayerId(slot1)
end

function slot0.collectionIsPass(slot0, slot1)
	if not slot0._rougeGameRecord then
		return false
	end

	return slot0._rougeGameRecord:collectionIsPass(slot1)
end

function slot0.storyIsPass(slot0, slot1)
	if not slot0._rougeGameRecord then
		return false
	end

	return slot0._rougeGameRecord:storyIsPass(slot1)
end

function slot0.passedAnyEventId(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0:passedEventId(slot6) then
			return true
		end
	end

	return false
end

function slot0.passedEventId(slot0, slot1)
	if not slot0._rougeGameRecord then
		return false
	end

	return slot0._rougeGameRecord:passedEventId(slot1)
end

function slot0.passAnyOneEnd(slot0)
	return slot0._rougeGameRecord and slot0._rougeGameRecord:passAnyOneEnd()
end

function slot0.passEndId(slot0, slot1)
	return slot0._rougeGameRecord and slot0._rougeGameRecord:passEndId(slot1)
end

function slot0.passEntrustId(slot0, slot1)
	return slot0._rougeGameRecord and slot0._rougeGameRecord:passEntrustId(slot1)
end

function slot0.getGeniusBranchStartViewInfo(slot0, slot1)
	if not RougeTalentModel.instance:isTalentUnlock(slot1) then
		return 0
	end

	return slot0._config:getGeniusBranchStartViewInfo(slot1)
end

function slot0.getGeniusBranchStartViewDeltaValue(slot0, slot1, slot2)
	return slot0:getGeniusBranchStartViewInfo(slot1)[slot2] or 0
end

function slot0.getGeniusBranchStartViewAllInfo(slot0)
	slot1 = {
		[slot7] = false
	}

	for slot6, slot7 in ipairs(slot0._config:getGeniusBranchIdListWithStartView()) do
		-- Nothing
	end

	RougeTalentModel.instance:calcTalentUnlockIds(slot1)

	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		if slot8 then
			for slot13, slot14 in pairs(slot0._config:getGeniusBranchStartViewInfo(slot7)) do
				slot3[slot13] = (slot3[slot13] or 0) + slot14
			end
		end
	end

	return slot3
end

function slot0.getStartViewAllInfo(slot0, slot1)
	slot3 = slot0:getGeniusBranchStartViewAllInfo()
	slot4 = {}

	for slot8, slot9 in pairs(slot0._config:getDifficultyCOStartViewInfo(slot1)) do
		slot4[slot8] = (slot4[slot8] or 0) + slot9
	end

	for slot8, slot9 in pairs(slot3) do
		slot4[slot8] = (slot4[slot8] or 0) + slot9
	end

	return slot4
end

slot0.instance = slot0.New()

return slot0
