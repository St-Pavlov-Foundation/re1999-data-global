module("modules.logic.versionactivity2_1.lanshoupa.model.LanShouPaStoryListModel", package.seeall)

slot0 = class("LanShouPaStoryListModel", ListScrollModel)

function slot0.init(slot0, slot1, slot2)
	slot4 = {}

	if Activity164Config.instance:getStoryList(slot1, slot2) then
		for slot8, slot9 in ipairs(slot3) do
			slot10 = LanShouPaStoryMO.New()

			slot10:init(slot8, slot9)
			table.insert(slot4, slot10)
		end
	end

	slot0:setList(slot4)
end

slot0.instance = slot0.New()

return slot0
