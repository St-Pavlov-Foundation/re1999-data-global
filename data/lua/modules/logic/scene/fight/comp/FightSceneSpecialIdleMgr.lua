module("modules.logic.scene.fight.comp.FightSceneSpecialIdleMgr", package.seeall)

slot0 = class("FightSceneSpecialIdleMgr", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	FightController.instance:registerCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
	FightController.instance:registerCallback(FightEvent.PlaySpecialIdle, slot0._onPlaySpecialIdle, slot0)
	FightController.instance:registerCallback(FightEvent.OnEntityDead, slot0._releaseEntity, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._releaseAllEntity, slot0)

	slot0._entity_dic = {}
	slot0._play_dic = {}
end

function slot0.onSceneClose(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.PlaySpecialIdle, slot0._onPlaySpecialIdle, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnEntityDead, slot0._releaseEntity, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._releaseAllEntity, slot0)
	slot0:_releaseAllEntity()

	slot0._entity_dic = nil
	slot0._play_dic = nil
end

function slot0._onStageChange(slot0, slot1)
	if slot1 == FightEnum.Stage.Card then
		for slot6, slot7 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)) do
			if slot7.spine and uv0.Condition[slot7:getMO().modelId] then
				if not slot0._entity_dic[slot8.id] then
					slot0._entity_dic[slot8.id] = _G["EntitySpecialIdle" .. uv0.Condition[slot8.modelId]].New(slot7)
				end

				if slot0._entity_dic[slot8.id].detectState then
					slot0._entity_dic[slot8.id]:detectState()
				end
			end
		end

		slot0:_detectCanPlay()
	end
end

function slot0._detectCanPlay(slot0)
	if slot0._play_dic then
		for slot4, slot5 in pairs(slot0._play_dic) do
			if FightHelper.getEntity(slot5) and lua_skin_special_act.configDict[slot6:getMO().modelId] and math.random(0, 100) <= slot7.probability and slot6.spine.tryPlay and slot6.spine:tryPlay(SpineAnimState.idle_special1, slot7.loop == 1 and true) then
				slot0._entityPlayActName = slot0._entityPlayActName or {}
				slot0._entityPlayActName[slot6.id] = FightHelper.processEntityActionName(slot6, SpineAnimState.idle_special1)

				slot6.spine:addAnimEventCallback(slot0._onAnimEvent, slot0, slot6)
			end
		end
	end

	slot0._play_dic = {}
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3, slot4)
	if slot0._entityPlayActName and slot2 == SpineAnimEvent.ActionComplete and slot1 == slot0._entityPlayActName[slot4.id] then
		slot4.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		slot4:resetAnimState()
	end
end

function slot0._onPlaySpecialIdle(slot0, slot1)
	slot0._play_dic[slot1] = slot1
end

function slot0._releaseEntity(slot0, slot1)
	if slot0._entity_dic and slot0._entity_dic[slot1] then
		if slot0._entityPlayActName then
			slot0._entityPlayActName[slot1] = nil
		end

		slot0._entity_dic[slot1]:releaseSelf()

		slot0._entity_dic[slot1] = nil

		if FightHelper.getEntity(slot1) and slot2.spine then
			slot2.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		end
	end
end

function slot0._releaseAllEntity(slot0)
	if slot0._entity_dic then
		for slot4, slot5 in pairs(slot0._entity_dic) do
			slot0:_releaseEntity(slot5.id)
		end
	end

	slot0._play_dic = {}
end

slot0.Condition = {
	[3003.0] = 2,
	[3025.0] = 6,
	[3039.0] = 8,
	[3009.0] = 5,
	[3032.0] = 7,
	[3004.0] = 3,
	[3052.0] = 3,
	[3047.0] = 9,
	[3051.0] = 1,
	[3007.0] = 4
}

return slot0
