module("modules.logic.activity.model.chessmap.ActivityChessGameModel", package.seeall)

slot0 = class("ActivityChessGameModel", BaseModel)

function slot0.onInit(slot0)
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
end

function slot0.initData(slot0, slot1, slot2)
	slot3 = Activity109Config.instance:getMapCo(slot1, slot2)
	slot0._actId = slot1
	slot0._mapId = slot2
	slot0.width = slot3.width
	slot0.height = slot3.height
	slot0._mapTileBaseList = string.splitToNumber(slot3.tilebase, ",")
	slot0._optList = {}
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
		if Activity109Config.instance:getInteractObjectCo(slot1, slot2[slot7].id) then
			slot9 = ActivityChessGameInteractMO.New()

			slot9:init(slot1, slot8)
			table.insert(slot0._mapInteractObjs, slot9)

			slot0._mapInteractObjDict[slot9.id] = slot9
		end
	end
end

function slot0.addObject(slot0, slot1, slot2)
	slot3 = ActivityChessGameInteractMO.New()

	slot3:init(slot1, slot2)
	table.insert(slot0._mapInteractObjs, slot3)

	slot0._mapInteractObjDict[slot3.id] = slot3

	return slot3
end

function slot0.removeObjectById(slot0, slot1)
	for slot5 = #slot0._mapInteractObjs, 1, -1 do
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

function slot0.addFinishInteract(slot0, slot1)
	slot0._finishInteract[slot1] = true
end

function slot0.isInteractFinish(slot0, slot1)
	if slot0._finishInteract then
		return slot0._finishInteract[slot1]
	end
end

function slot0.getBaseTile(slot0, slot1, slot2)
	return slot0._mapTileBaseList[slot0:getIndex(slot1, slot2)]
end

function slot0.setBaseTile(slot0, slot1, slot2, slot3)
	slot0._mapTileBaseList[slot0:getIndex(slot1, slot2)] = slot3
end

function slot0.setRound(slot0, slot1)
	slot0._round = slot1
end

function slot0.setResult(slot0, slot1)
	slot0._isWin = slot1
end

function slot0.getResult(slot0)
	return slot0._isWin
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

function slot0.isPosInChessBoard(slot0, slot1, slot2)
	return slot1 >= 0 and slot1 < slot0.width and slot2 >= 0 and slot2 < slot0.height
end

function slot0.getFinishGoalNum(slot0)
	if not slot0._actId then
		return 0
	end

	if not Activity109ChessModel.instance:getEpisodeId() then
		return 0
	end

	slot2 = Activity109Config.instance:getEpisodeCo(slot0._actId, slot1)
	slot4 = string.split(slot2.extStarCondition, "|")
	slot5 = string.split(slot2.conditionStr, "|")

	if slot0:isGoalFinished() then
		slot6 = 0 + 1
	end

	for slot10, slot11 in ipairs(slot4) do
		if slot0:isGoalFinished(slot11) then
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
		return ActivityChessMapUtils.isClearConditionFinish(string.splitToNumber(slot1, "#"), slot0._actId)
	else
		return slot0:getResult() == true
	end
end

slot0.instance = slot0.New()

return slot0
