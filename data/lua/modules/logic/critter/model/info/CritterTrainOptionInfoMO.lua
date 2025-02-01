module("modules.logic.critter.model.info.CritterTrainOptionInfoMO", package.seeall)

slot0 = pureTable("CritterTrainOptionInfoMO")
slot1 = {}

function slot0.ctor(slot0)
	slot0.optionId = 0
	slot0.addAttriButes = {}
end

function slot0.init(slot0, slot1)
	slot1 = slot1 or uv0
	slot0.optionId = slot1.optionId or 0
	slot0.addAttriButes = CritterHelper.getInitClassMOList(slot1.addAttributes, CritterAttributeInfoMO, slot0.addAttriButes)
end

function slot0.getAddAttriuteInfoById(slot0, slot1)
	for slot5, slot6 in pairs(slot0.addAttriButes) do
		if slot6.attributeId == slot1 then
			return slot6
		end
	end
end

return slot0
