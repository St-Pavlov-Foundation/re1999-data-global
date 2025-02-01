module("modules.logic.critter.model.info.CritterSkillInfoMO", package.seeall)

slot0 = pureTable("CritterSkillInfoMO")

function slot0.init(slot0, slot1)
	if not slot0.tags or #slot0.tags > 0 then
		slot0.tags = {}
	end

	if slot1 and slot1.tags then
		tabletool.addValues(slot0.tags, slot1.tags)
	end
end

function slot0.getTags(slot0)
	return slot0.tags
end

return slot0
