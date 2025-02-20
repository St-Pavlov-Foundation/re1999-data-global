slot0 = class("VersionActivity2_3NewCultivationGiftRewardListModel", ListScrollModel)

function slot0.setRewardList(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) and string.split(slot1, "|") and #slot3 > 0 then
		for slot7, slot8 in ipairs(slot3) do
			slot10 = string.splitToNumber(slot8, "#")

			table.insert(slot2, {
				type = slot10[1],
				id = slot10[2],
				quantity = slot10[3]
			})
		end
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
