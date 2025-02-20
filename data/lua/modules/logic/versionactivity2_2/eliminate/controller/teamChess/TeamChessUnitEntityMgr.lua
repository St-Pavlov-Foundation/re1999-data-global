module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.TeamChessUnitEntityMgr", package.seeall)

slot0 = class("TeamChessUnitEntityMgr")

function slot0.ctor(slot0)
	slot0._entitys = {}
	slot0.emptyEntity = {}
end

function slot0.addEntity(slot0, slot1, slot2)
	if slot0._entitys[slot1:getUid()] then
		return slot0._entitys[slot3]
	end

	slot5 = nil

	if slot1.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.create3d(slot2, slot3), TeamChessPlayerSoldierUnit)
	end

	if slot1.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, TeamChessEnemySoldierUnit)
	end

	if slot5 == nil then
		logError("TeamChessUnitEntityMgr:addEntity entity is nil.. type: " .. slot1.teamType)

		slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, TeamChessSoldierUnit)
	end

	slot5:updateMo(slot1)

	slot0._entitys[slot3] = slot5

	return slot5
end

function slot0.getEmptyEntity(slot0, slot1, slot2)
	if slot0.emptyEntity[EliminateConfig.instance:getSoldierChessModelPath(slot2)] then
		return slot0.emptyEntity[slot3]
	end

	if gohelper.isNil(slot1) then
		return nil
	end

	slot4 = gohelper.create3d(slot1, "tempEmpty")
	slot6 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, TeamChessEmptyUnit)

	slot6:init(slot4)
	slot6:setScale(EliminateConfig.instance:getSoldierChessConfig(slot2).resZoom)
	slot6:setPath(slot3)

	slot0.emptyEntity[slot3] = slot6

	return slot6
end

function slot0.setAllEmptyEntityActive(slot0, slot1)
	for slot5, slot6 in pairs(slot0.emptyEntity) do
		if slot6 then
			slot6:setActive(slot1)
		end
	end
end

function slot0.getEntity(slot0, slot1)
	return slot0._entitys[slot1]
end

function slot0.getAllEntity(slot0)
	return slot0._entitys
end

function slot0.removeEntity(slot0, slot1)
	if slot0._entitys[slot1] then
		slot0._entitys[slot1]:dispose()

		slot0._entitys[slot1] = nil
	end
end

function slot0.setAllEntityActive(slot0, slot1)
	for slot5, slot6 in pairs(slot0._entitys) do
		if slot6 then
			if slot1 then
				slot6:updatePosByTr()
			end

			slot6:setActive(slot1)
		end
	end
end

function slot0.setAllEntityActiveAndPlayAni(slot0, slot1)
	for slot5, slot6 in pairs(slot0._entitys) do
		if slot6 then
			if slot1 then
				slot6:updatePosByTr()
			end

			slot6:setActiveAndPlayAni(slot1)
		end
	end
end

function slot0.setAllEntityCanClick(slot0, slot1)
	for slot5, slot6 in pairs(slot0._entitys) do
		if slot6 then
			slot6:setCanClick(slot1)
		end
	end
end

function slot0.setAllEntityCanDrag(slot0, slot1)
	for slot5, slot6 in pairs(slot0._entitys) do
		if slot6 then
			slot6:setCanDrag(slot1)
		end
	end
end

function slot0.setOutlineActive(slot0, slot1, slot2)
	if slot0._entitys and slot0._entitys[slot1] then
		slot0._entitys[slot1]:setShowModeType(slot2 and EliminateTeamChessEnum.ModeType.outline or EliminateTeamChessEnum.ModeType.Normal)
	end
end

function slot0.setGrayActive(slot0, slot1, slot2)
	if slot0._entitys and slot0._entitys[slot1] then
		slot0._entitys[slot1]:setShowModeType(slot2 and EliminateTeamChessEnum.ModeType.Gray or EliminateTeamChessEnum.ModeType.Normal)
	end
end

function slot0.moveEntityByTeamTypeAndStrongHold(slot0, slot1, slot2, slot3, slot4, slot5)
	for slot9, slot10 in pairs(slot0._entitys) do
		if slot10 and slot10._unitMo.teamType == slot1 and slot10._unitMo.stronghold == slot2 then
			slot10:moveToPosByTargetTr(slot3, slot4, slot5)
		end
	end
end

function slot0.resetEntityPosByTeamTypeAndStrongHold(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._entitys) do
		if slot7 and slot7._unitMo.teamType == slot1 and slot7._unitMo.stronghold == slot2 then
			slot7:movePosByTr()
		end
	end
end

function slot0.cacheAllEntityShowMode(slot0)
	if slot0.entityCacheMode == nil then
		slot0.entityCacheMode = {}
	end

	for slot4, slot5 in pairs(slot0._entitys) do
		if slot5 then
			slot0.entityCacheMode[slot4] = slot5:getShowModeType()
		end
	end
end

function slot0.setAllEntityNormal(slot0)
	for slot4, slot5 in pairs(slot0._entitys) do
		if slot5 then
			slot5:setShowModeType(EliminateTeamChessEnum.ModeType.Normal)
		end
	end
end

function slot0.cacheEntityShowMode(slot0, slot1)
	if slot0.entityCacheMode == nil then
		slot0.entityCacheMode = {}
	end

	for slot5, slot6 in pairs(slot0._entitys) do
		if slot6 and slot6._unitMo.stronghold == slot1 then
			slot0.entityCacheMode[slot5] = slot6:getShowModeType()
		end
	end
end

function slot0.restoreEntityShowMode(slot0)
	if slot0.entityCacheMode == nil then
		return
	end

	for slot4, slot5 in pairs(slot0.entityCacheMode) do
		if slot0._entitys[slot4] then
			slot6:setShowModeType(slot5)
		end
	end

	tabletool.clear(slot0.entityCacheMode)
end

function slot0.setTempShowModeAndCacheByTeamType(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._entitys) do
		if slot7 and slot7._unitMo.teamType == slot1 and slot6 ~= EliminateTeamChessEnum.tempPieceUid then
			slot7:cacheModel()
			slot7:setShowModeType(slot2)
		end
	end
end

function slot0.restoreTempShowModeAndCacheByTeamType(slot0, slot1)
	for slot5, slot6 in pairs(slot0._entitys) do
		if slot6 and slot6._unitMo.teamType == slot1 then
			slot6:restoreModel()
		end
	end
end

function slot0.refreshShowModeStateByTeamType(slot0, slot1)
	for slot5, slot6 in pairs(slot0._entitys) do
		if slot6 and slot6._unitMo.teamType == slot1 then
			slot6:refreshShowModeState()
		end
	end
end

function slot0.clear(slot0)
	for slot4, slot5 in pairs(slot0._entitys) do
		slot5:dispose()
	end

	for slot4, slot5 in pairs(slot0.emptyEntity) do
		slot5:dispose()
	end

	slot0._entitys = {}
	slot0.emptyEntity = {}
end

slot0.instance = slot0.New()

return slot0
