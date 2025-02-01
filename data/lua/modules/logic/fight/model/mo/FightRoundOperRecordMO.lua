module("modules.logic.fight.model.mo.FightRoundOperRecordMO", package.seeall)

slot0 = pureTable("FightRoundOperRecordMO")

function slot0.ctor(slot0)
	slot0.clothSkillOpers = {}
	slot0.opers = {}
end

function slot0.init(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.clothSkillOpers) do
		table.insert(slot0.clothSkillOpers, {
			skillId = slot6.skillId,
			fromId = slot6.fromId,
			toId = slot6.toId,
			type = slot6.type
		})
	end

	for slot5, slot6 in ipairs(slot1.opers) do
		slot7 = FightBeginRoundOp.New()

		slot7:init(slot6)
		table.insert(slot0.opers, slot7)
	end
end

return slot0
