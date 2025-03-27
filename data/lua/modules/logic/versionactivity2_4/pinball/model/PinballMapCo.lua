module("modules.logic.versionactivity2_4.pinball.model.PinballMapCo", package.seeall)

slot0 = pureTable("PinballMapCo")

function slot0.init(slot0, slot1)
	slot0.units = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.units[slot5] = PinballUnitCo.New()

		slot0.units[slot5]:init(slot6)
	end
end

return slot0
