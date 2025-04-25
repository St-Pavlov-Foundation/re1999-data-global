module("modules.logic.fight.system.work.FightWorkUpdateFightByProto", package.seeall)

slot0 = class("FightWorkUpdateFightByProto", FightWorkItem)

function slot0.onConstructor(slot0, slot1)
	slot0._fightProto = slot1
end

function slot0.onStart(slot0)
	slot1 = FightModel.instance:getFightParam()
	slot2 = FightModel.instance:getCurWaveId()

	if slot1:getSceneLevel(slot2 + 1) and slot5 ~= slot1:getSceneLevel(slot2) then
		slot0._nextLevelId = slot5

		slot0:com_registTimer(slot0._delayDone, 10)
		slot0:com_registTimer(slot0._startLoadLevel, 0.25 / FightModel.instance:getSpeed())
	else
		slot0:_startChange()
	end
end

function slot0._changeEntity(slot0)
	slot1 = slot0:_cacheExpoint()
	slot2 = FightModel.instance.power
	slot0._existBuffUidDict = {}

	for slot7, slot8 in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		slot0._existBuffUidDict[slot8.id] = {}

		for slot12, slot13 in pairs(slot8:getBuffDic()) do
			slot0._existBuffUidDict[slot8.id][slot13.id] = slot13
		end
	end

	slot0._myStancePos2EntityId = {}
	slot0._enemyStancePos2EntityId = {}
	slot7 = SceneTag.UnitPlayer

	for slot7, slot8 in pairs(slot0:getTagUnitDict(slot7)) do
		slot0._myStancePos2EntityId[slot8:getMO().position] = slot8.id
	end

	slot7 = SceneTag.UnitMonster

	for slot7, slot8 in pairs(slot0:getTagUnitDict(slot7)) do
		slot0._enemyStancePos2EntityId[slot8:getMO().position] = slot8.id
	end

	FightDataMgr.instance:updateFightData(slot0._fightProto)

	FightModel.instance.power = slot2

	slot0:_applyExpoint(slot1)
	GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:changeWave(slot0._nextWaveMsg.fight)
end

function slot0._startChange(slot0)
	slot0:_changeEntity()
	slot0:onDone(true)
end

function slot0._onLevelLoaded(slot0)
	slot0:_startChange()
end

function slot0._startLoadLevel(slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevelWithSwitchEffect(slot0._nextLevelId)
end

function slot0._delayDone(slot0)
	slot0:_startChange()
end

function slot0._cacheExpoint(slot0)
	for slot6, slot7 in ipairs(FightHelper.getAllEntitys()) do
		-- Nothing
	end

	return {
		[slot7.id] = slot7:getMO().exPoint
	}
end

function slot0._applyExpoint(slot0, slot1)
	for slot6, slot7 in ipairs(FightHelper.getAllEntitys()) do
		if slot1[slot7.id] then
			slot7:getMO():setExPoint(slot8)
		end
	end
end

return slot0
