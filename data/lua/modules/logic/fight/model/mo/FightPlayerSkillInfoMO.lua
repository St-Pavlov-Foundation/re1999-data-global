module("modules.logic.fight.model.mo.FightPlayerSkillInfoMO", package.seeall)

slot0 = pureTable("FightPlayerSkillInfoMO")

function slot0.init(slot0, slot1)
	slot0.skillId = slot1.skillId
	slot0.cd = slot1.cd
	slot0.needPower = slot1.needPower
	slot0.type = slot1.type
end

return slot0
