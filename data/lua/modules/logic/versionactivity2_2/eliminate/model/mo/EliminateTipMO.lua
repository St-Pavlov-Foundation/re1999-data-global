module("modules.logic.versionactivity2_2.eliminate.model.mo.EliminateTipMO", package.seeall)

slot0 = class("EliminateTipMO")

function slot0.ctor(slot0)
	slot0.from = {}
	slot0.to = {}
	slot0.eliminate = {}
end

function slot0.updateInfoByServer(slot0, slot1)
	if slot1 == nil or slot1.from == nil then
		return
	end

	slot0.from.x = slot1.from.x + 1
	slot0.from.y = slot1.from.y + 1
	slot0.to.x = slot1.to.x + 1
	slot0.to.y = slot1.to.y + 1

	tabletool.clear(slot0.eliminate)

	if slot1.eliminate then
		for slot6, slot7 in ipairs(slot2.coordinate) do
			slot0.eliminate[#slot0.eliminate + 1] = slot7.x + 1
			slot0.eliminate[#slot0.eliminate + 1] = slot7.y + 1
		end
	end
end

function slot0.getEliminateCount(slot0)
	return tabletool.len(slot0.eliminate)
end

return slot0
