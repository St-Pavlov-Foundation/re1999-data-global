module("modules.logic.seasonver.act166.model.Season166TalentMO", package.seeall)

slot0 = pureTable("Season166TalentMO")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.level = 1
	slot0.skillIds = {}
end

function slot0.setData(slot0, slot1)
	slot0.id = slot1.id
	slot0.level = slot1.level

	slot0:updateSkillIds(slot1.skillIds)

	slot0.config = lua_activity166_talent_style.configDict[slot1.id][slot1.level]
end

function slot0.updateSkillIds(slot0, slot1)
	tabletool.clear(slot0.skillIds)

	for slot5, slot6 in ipairs(slot1) do
		slot0.skillIds[slot5] = slot6
	end
end

return slot0
