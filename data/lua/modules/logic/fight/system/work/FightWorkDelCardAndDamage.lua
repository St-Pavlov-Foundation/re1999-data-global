module("modules.logic.fight.system.work.FightWorkDelCardAndDamage", package.seeall)

slot0 = class("FightWorkDelCardAndDamage", FightEffectBase)

function slot0.onStart(slot0)
	slot1 = nil

	if (slot0._actEffectMO.teamType ~= FightEnum.TeamType.EnemySide or FightHelper.getEntity(FightEntityScene.EnemySideId)) and FightHelper.getEntity(FightEntityScene.MySideId) then
		slot1.effect:addGlobalEffect("v2a2_znps/znps_unique_03_hit", nil, 1):setLocalPos(slot0._actEffectMO.teamType == FightEnum.TeamType.EnemySide and -6.14 or 6.14, 1.65, -1.74)
		slot0:com_registTimer(slot0._delayAfterPerformance, 1)
		AudioMgr.instance:trigger(410000104)

		return
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
