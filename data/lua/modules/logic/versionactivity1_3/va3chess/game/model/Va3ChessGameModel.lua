module("modules.logic.versionactivity1_3.va3chess.game.model.Va3ChessGameModel", package.seeall)

slot0 = class("Va3ChessGameModel", BaseModel)

function slot0.onInit(slot0)
	slot0._mapTileMOList = {}
end

function slot0.reInit(slot0)
end

function slot0.release(slot0)
	slot0.width = nil
	slot0.height = nil
	slot0._mapTileBaseList = nil
	slot0._mapInteractObjs = nil
	slot0._mapInteractObjDict = nil
	slot0._actId = nil
	slot0._mapId = nil
	slot0._optList = nil
	slot0._round = nil
	slot0._result = nil
	slot0._finishInteract = nil
	slot0._allFinishInteract = nil
	slot0.failReason = nil
	slot0.lastMapRound = nil
	slot0._playingStory = nil
end

function slot0.initData(slot0, slot1, slot2)
	slot3 = Va3ChessConfig.instance:getMapCo(slot1, slot2)
	slot0._actId = slot1
	slot0._mapId = slot2
	slot0.width = slot3.width
	slot0.height = slot3.height
	slot0._optList = {}

	slot0:_initTileNum()

	slot0._mapTileBaseList = {}

	for slot8 = 1, #slot0._mapTileMOList do
		slot0._mapTileMOList[slot8]:setParamStr((string.split(slot3.tilebase, ",") or {})[slot8])
	end
end

function slot0._initTileNum(slot0)
	slot0._mapTileMOList = {}

	for slot5 = 1, slot0.width * slot0.height do
		if not slot0._mapTileMOList[slot5] then
			slot0._mapTileMOList[slot5] = Va3ChessGameTileMO.New()
		end

		slot6:init(slot5)
	end
end

function slot0.addInteractData(slot0, slot1)
	table.insert(slot0._mapInteractObjs, slot1)

	slot0._mapInteractObjDict[slot1.id] = slot1
end

function slot0.removeInteractData(slot0, slot1)
	tabletool.removeValue(slot0._mapInteractObjs, slot1)

	slot0._mapInteractObjDict[slot1.id] = nil
end

function slot0.initObjects(slot0, slot1, slot2)
	slot0._mapInteractObjs = {}
	slot0._mapInteractObjDict = {}

	for slot7 = 1, #slot2 do
		if Va3ChessConfig.instance:getInteractObjectCo(slot1, slot2[slot7].id) then
			slot9 = Va3ChessGameInteractMO.New()

			slot9:init(slot1, slot8)
			table.insert(slot0._mapInteractObjs, slot9)

			slot0._mapInteractObjDict[slot9.id] = slot9
		end
	end
end

function slot0.addObject(slot0, slot1, slot2)
	slot3 = Va3ChessGameInteractMO.New()

	slot3:init(slot1, slot2)
	table.insert(slot0._mapInteractObjs, slot3)

	slot0._mapInteractObjDict[slot3.id] = slot3

	return slot3
end

function slot0.removeObjectById(slot0, slot1)
	for slot5 = 1, #slot0._mapInteractObjs do
		if slot0._mapInteractObjs[slot5].id == slot1 then
			table.remove(slot0._mapInteractObjs, slot5)

			slot0._mapInteractObjDict[slot1] = nil

			return slot0._mapInteractObjs[slot5]
		end
	end
end

function slot0.syncObjectData(slot0, slot1, slot2)
	slot3 = nil

	if slot0._mapInteractObjDict[slot1] then
		slot3 = slot0:compareObjectData(slot4.data, slot2)
		slot4.data = slot2
	end

	return slot3
end

function slot0.compareObjectData(slot0, slot1, slot2)
	slot3 = {}

	slot0:compareAlertArea(slot3, slot1, slot2)
	slot0:compareValueTypeField(slot3, slot1, slot2, "goToObject")
	slot0:compareValueTypeField(slot3, slot1, slot2, "lostTarget")
	slot0:compareValueTypeField(slot3, slot1, slot2, "status")
	slot0:compareValueTypeField(slot3, slot1, slot2, "attributes")
	slot0:compareValueTypeField(slot3, slot1, slot2, "pedalStatus")

	return slot3
end

function slot0.compareAlertArea(slot0, slot1, slot2, slot3)
	if slot2 and slot3 and slot2.alertArea and slot3.alertArea and #slot2.alertArea == #slot3.alertArea then
		for slot7 = 1, #slot2.alertArea do
			if slot2.alertArea[slot7].x ~= slot3.alertArea[slot7].x or slot2.alertArea[slot7].y ~= slot3.alertArea[slot7].y then
				slot1.alertArea = slot3.alertArea

				break
			end
		end
	else
		slot0:compareValueOverride(slot1, slot2, slot3, "alertArea")
	end
end

function slot0.compareValueTypeField(slot0, slot1, slot2, slot3, slot4)
	if slot2 and slot3 then
		if slot2[slot4] ~= slot3[slot4] then
			if slot2[slot4] ~= nil and slot3[slot4] == nil then
				slot1.__deleteFields = slot1.__deleteFields or {}
				slot1.__deleteFields[slot4] = true
			else
				slot1[slot4] = slot3[slot4]
			end
		end
	else
		slot0:compareValueOverride(slot1, slot2, slot3, slot4)
	end
end

function slot0.compareValueOverride(slot0, slot1, slot2, slot3, slot4)
	if slot2 and slot2[slot4] ~= nil and (slot3 == null or slot3[slot4] == nil) then
		slot1.__deleteFields = slot1.__deleteFields or {}
		slot1.__deleteFields[slot4] = true
	elseif slot3 then
		slot1[slot4] = slot3[slot4]
	end
end

function slot0.getObjectDataById(slot0, slot1)
	return slot0._mapInteractObjDict[slot1]
end

function slot0.appendOpt(slot0, slot1)
	table.insert(slot0._optList, slot1)
end

function slot0.getOptList(slot0)
	return slot0._optList
end

function slot0.cleanOptList(slot0)
	for slot4, slot5 in pairs(slot0._optList) do
		slot0._optList[slot4] = nil
	end
end

function slot0.updateFinishInteracts(slot0, slot1)
	slot0._finishInteract = {}

	if slot1 then
		for slot5 = 1, #slot1 do
			slot0._finishInteract[slot1[slot5]] = true
		end
	end
end

function slot0.updateBrokenTilebases(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	if Activity142Model.instance:getActivityId() == slot1 then
		for slot7, slot8 in ipairs(slot2) do
			slot9 = Va3ChessEnum.TileTrigger.Broken

			slot0:updateTileTriggerStatus(slot8.x, slot8.y, slot9, Va3ChessEnum.TriggerStatus[slot9].Broken)
			slot0:addTileFinishTrigger(slot8.x, slot8.y, slot9)
		end
	else
		for slot7, slot8 in ipairs(slot2) do
			slot0:addTileFinishTrigger(slot8.x, slot8.y, Va3ChessEnum.TileTrigger.PoSui)
		end
	end
end

function slot0.updateLightUpBrazier(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot0:getObjectDataById(slot7) then
			slot8:setBrazierIsLight(true)
		end
	end
end

function slot0.updateFragileTilebases(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		slot8 = Va3ChessEnum.TileTrigger.Broken

		slot0:updateTileTriggerStatus(slot7.x, slot7.y, slot8, Va3ChessEnum.TriggerStatus[slot8].Fragile)
	end
end

function slot0.updateTileTriggerStatus(slot0, slot1, slot2, slot3, slot4)
	if slot0:getTileMO(slot1, slot2) then
		slot5:updateTrigger(slot3, slot4)
	end
end

function slot0.addTileFinishTrigger(slot0, slot1, slot2, slot3)
	if slot0:getTileMO(slot1, slot2) then
		slot4:addFinishTrigger(slot3)
	end
end

function slot0.addFinishInteract(slot0, slot1)
	slot0._finishInteract[slot1] = true
end

function slot0.isInteractFinish(slot0, slot1, slot2)
	if slot2 and slot0._allFinishInteract then
		return slot0._allFinishInteract[slot1]
	end

	if slot0._finishInteract then
		return slot0._finishInteract[slot1]
	end
end

function slot0.findInteractFinishIds(slot0, slot1)
	slot2 = slot0._finishInteract

	if slot1 then
		slot2 = slot0._allFinishInteract
	end

	if not slot2 then
		return nil
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		if slot8 == true then
			table.insert(slot3, slot7)
		end
	end

	return slot3
end

function slot0.addAllMapFinishInteract(slot0, slot1)
	slot0._allFinishInteract[slot1] = true
end

function slot0.updateAllFinishInteracts(slot0, slot1)
	slot0._allFinishInteract = {}

	if slot1 then
		for slot5 = 1, #slot1 do
			slot0._allFinishInteract[slot1[slot5]] = true
		end
	end
end

function slot0.getTileMO(slot0, slot1, slot2)
	return slot0._mapTileMOList[slot0:getIndex(slot1, slot2)]
end

function slot0.getBaseTile(slot0, slot1, slot2)
	return slot0:getTileMO(slot1, slot2) and slot3.tileType
end

function slot0.setBaseTile(slot0, slot1, slot2, slot3)
	if slot0:getTileMO(slot1, slot2) then
		slot4.tileType = slot3
	end
end

function slot0.setResult(slot0, slot1)
	slot0._isWin = slot1
end

function slot0.getResult(slot0)
	return slot0._isWin
end

function slot0.setFailReason(slot0, slot1)
	slot0.failReason = slot1
end

function slot0.getFailReason(slot0)
	return slot0.failReason
end

function slot0.getInteractDatas(slot0)
	return slot0._mapInteractObjs
end

function slot0.getIndex(slot0, slot1, slot2)
	return slot2 * slot0.width + slot1 + 1
end

function slot0.getGameSize(slot0)
	return slot0.width, slot0.height
end

function slot0.getMapId(slot0)
	return slot0._mapId
end

function slot0.getActId(slot0)
	return slot0._actId
end

function slot0.getRound(slot0)
	return math.max(slot0._round or 1, 1)
end

function slot0.setRound(slot0, slot1)
	if slot0.lastMapRound then
		slot0._round = slot1 + slot0.lastMapRound

		return
	end

	slot0._round = slot1
end

function slot0.recordLastMapRound(slot0)
	slot0.lastMapRound = slot0._round
end

function slot0.clearLastMapRound(slot0)
	slot0.lastMapRound = nil
end

function slot0.getHp(slot0)
	return math.max(slot0._hp or 1, 1)
end

function slot0.setHp(slot0, slot1)
	slot0._hp = slot1
end

function slot0.setPlayingStory(slot0, slot1)
	slot0._playingStory = slot1
end

function slot0.isPlayingStory(slot0)
	return slot0._playingStory
end

function slot0.isPosInChessBoard(slot0, slot1, slot2)
	return slot1 >= 0 and slot1 < slot0.width and slot2 >= 0 and slot2 < slot0.height
end

function slot0.isPosValid(slot0, slot1, slot2)
end

function slot0.setFinishedTargetNum(slot0, slot1)
	slot0._finishedTargetNum = slot1
end

function slot0.getFinishedTargetNum(slot0)
	return slot0._finishedTargetNum
end

function slot0.getFinishGoalNum(slot0)
	if not slot0._actId then
		return 0
	end

	if not Va3ChessModel.instance:getEpisodeId() then
		return 0
	end

	slot2 = Va3ChessConfig.instance:getEpisodeCo(slot0._actId, slot1)
	slot3, slot4 = nil

	if slot0._actId == VersionActivity1_3Enum.ActivityId.Act304 then
		slot3 = slot2.starCondition
		slot4 = slot2.extStarCondition
	elseif slot0._actId == VersionActivity1_3Enum.ActivityId.Act306 then
		slot3 = slot2.mainConfition
		slot4 = slot2.extStarCondition
	end

	slot5 = {}

	if not string.nilorempty(slot3) then
		slot9 = true

		for slot9, slot10 in ipairs(GameUtil.splitString2(slot3, slot9)) do
			table.insert(slot5, slot10)
		end
	end

	if not string.nilorempty(slot4) then
		slot9 = true

		for slot9, slot10 in ipairs(GameUtil.splitString2(slot4, slot9)) do
			table.insert(slot5, slot10)
		end
	end

	if slot0:getResult() then
		slot6 = 0 + 1
	end

	for slot10, slot11 in ipairs(slot5) do
		if Va3ChessMapUtils.isClearConditionFinish(slot11, slot0._actId) then
			slot6 = slot6 + 1
		end
	end

	return slot6
end

function slot0.isGoalFinished(slot0, slot1)
	if not slot0._actId then
		return false
	end

	if not string.nilorempty(slot1) then
		return Va3ChessMapUtils.isClearConditionFinish(string.splitToNumber(slot1, "#"), slot0._actId)
	else
		return slot0:getResult() == true
	end
end

function slot0.getFireBallCount(slot0)
	return slot0._fireBallCount or 0
end

function slot0.setFireBallCount(slot0, slot1, slot2)
	if not slot1 or slot1 < 0 then
		slot1 = 0
	end

	slot0._fireBallCount = slot1

	if not slot2 then
		return
	end

	slot3 = nil

	if Va3ChessGameController.instance.interacts then
		slot3 = slot4:getMainPlayer(true) and slot5:getHandler() or nil
	end

	if slot3 and slot3.updateFireBallCount then
		slot3:updateFireBallCount()
	end
end

slot0.instance = slot0.New()

return slot0
