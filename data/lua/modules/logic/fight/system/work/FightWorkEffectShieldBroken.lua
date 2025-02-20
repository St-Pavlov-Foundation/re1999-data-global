module("modules.logic.fight.system.work.FightWorkEffectShieldBroken", package.seeall)

slot0 = class("FightWorkEffectShieldBroken", FightEffectBase)
slot1 = "buff_rush_break"
slot2 = {
	[51400021.0] = true,
	[514000111.0] = true
}

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot1.skill then
		if slot0:_isBossRushBossShieldBroken(slot1) then
			FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillEnd, slot0, LuaEventSystem.Low)
			slot1.skill:playTimeline(uv0, slot0._fightStepMO)
			slot0:com_registTimer(slot0._delayDone, 10)
		else
			slot0:onDone(true)
		end
	else
		slot0:onDone(true)
	end
end

function slot0._isBossRushBossShieldBroken(slot0, slot1)
	if not BossRushController.instance:isInBossRushFight() then
		return false
	end

	if not slot1:isEnemySide() then
		return false
	end

	slot3 = FightModel.instance:getCurMonsterGroupId() and lua_monster_group.configDict[slot2]
	slot4 = slot3 and slot3.bossId

	if not (slot4 and FightHelper.isBossId(slot4, slot1:getMO().modelId)) then
		return false
	end

	for slot10, slot11 in pairs(slot1:getMO():getBuffDic()) do
		if uv0[slot11.buffId] then
			return true
		end
	end

	return false
end

function slot0._onSkillEnd(slot0, slot1, slot2)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	logError("播放破盾Timeline超时")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillEnd, slot0)
end

return slot0
