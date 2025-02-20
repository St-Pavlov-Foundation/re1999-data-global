module("modules.logic.scene.fight.comp.FightScenePreloader", package.seeall)

slot0 = class("FightScenePreloader", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
end

function slot0.startPreload(slot0, slot1)
	slot3 = FightModel.instance:getFightParam() and slot2.episodeId

	if not slot1 and FightPreloadController.instance:hasPreload(slot2 and slot2.battleId or slot3 and DungeonConfig.instance:getEpisodeBattleId(slot3)) then
		slot0:_onPreloadFinish()

		return
	end

	slot7 = {}
	slot8 = {}
	slot9 = {}
	slot11 = FightDataHelper.entityMgr:getEnemyNormalList()
	slot12 = FightDataHelper.entityMgr:getMySubList()

	for slot16, slot17 in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		table.insert({}, slot17.modelId)
		table.insert({}, slot17.skin)
	end

	for slot16, slot17 in ipairs(slot11) do
		table.insert(slot7, slot17.modelId)
		table.insert(slot8, slot17.skin)
	end

	for slot16, slot17 in ipairs(slot12) do
		table.insert(slot9, slot17.skin)
	end

	FightController.instance:registerCallback(FightEvent.OnPreloadFinish, slot0._onPreloadFinish, slot0)

	if FightModel.instance.needFightReconnect then
		FightPreloadController.instance:preloadReconnect(slot4, slot5, slot6, slot7, slot8, slot9)
	elseif slot1 then
		FightPreloadController.instance:preloadSecond(slot4, slot5, slot6, slot7, slot8, slot9)
	else
		FightPreloadController.instance:preloadFirst(slot4, slot5, slot6, slot7, slot8, slot9)
	end
end

function slot0._onPreloadFinish(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnPreloadFinish, slot0._onPreloadFinish, slot0)
	slot0:dispatchEvent(FightSceneEvent.OnPreloadFinish)
end

function slot0.onSceneClose(slot0)
	FightPreloadController.instance:dispose()
	FightRoundPreloadController.instance:dispose()
	FightController.instance:unregisterCallback(FightEvent.OnPreloadFinish, slot0._onPreloadFinish, slot0)
end

return slot0
