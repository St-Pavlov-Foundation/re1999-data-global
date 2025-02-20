module("modules.logic.fight.model.mo.FightAssistBossSkillInfoMo", package.seeall)

slot0 = pureTable("FightAssistBossSkillInfoMo")

function slot0.init(slot0, slot1)
	slot0.skillId = slot1.skillId
	slot0.needPower = slot1.needPower
	slot0.powerLow = slot1.powerLow
	slot0.powerHigh = slot1.powerHigh
end

return slot0
