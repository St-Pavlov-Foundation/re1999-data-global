module("modules.logic.fight.system.work.FightWorkSkillOrBuffFocusMonster", package.seeall)

slot0 = class("FightWorkSkillOrBuffFocusMonster", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0)
	if slot0:isSkillFocus(slot0._fightStepMO) then
		ViewMgr.instance:openView(ViewName.FightTechniqueGuideView, {
			entity = FightDataHelper.entityMgr:getById(slot1),
			config = slot0.monster_guide_focus_config
		})
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.FightTechniqueGuideView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		TaskDispatcher.runDelay(slot0._delayDone, slot0, FightWorkFocusMonster.EaseTime)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.isSkillFocus(slot0, slot1)
	slot2 = FightModel.instance:getFightParam()

	if not FightHelper.getEntity(slot1.fromId) or not slot3:getMO() then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if DungeonModel.instance:hasPassLevel(slot2.episodeId) then
		return
	end

	if not lua_monster_guide_focus.configDict[slot2.episodeId] then
		return
	end

	if not FightConfig.instance:getMonsterGuideFocusConfig(slot2.episodeId, slot1.actType, slot1.actId, slot3:getMO().modelId) then
		for slot8, slot9 in ipairs(slot1.actEffectMOs) do
			if slot9.effectType == FightEnum.EffectType.BUFFADD and FightDataHelper.entityMgr:getById(slot9.targetId) and FightConfig.instance:getMonsterGuideFocusConfig(slot2.episodeId, FightWorkFocusMonster.invokeType.Buff, slot9.buff.buffId, slot10.modelId) then
				break
			end
		end

		if not slot4 then
			return
		end
	end

	slot0.monster_guide_focus_config = slot4

	if PlayerPrefsHelper.hasKey(uv0.getPlayerPrefKey(slot4)) then
		return
	end

	return slot1.fromId
end

function slot0.getPlayerPrefKey(slot0)
	return string.format("%s_%s_%s_%s_%s_%s", PlayerPrefsKey.FightFocusSkillOrBuffMonster, PlayerModel.instance:getPlayinfo().userId, tostring(slot0.id), tostring(slot0.invokeType), tostring(slot0.param), tostring(slot0.monster))
end

function slot0.clearWork(slot0)
end

return slot0
