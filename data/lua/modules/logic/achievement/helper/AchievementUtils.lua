module("modules.logic.achievement.helper.AchievementUtils", package.seeall)

slot0 = class("AchievementUtils")
slot0.SingleShowTag = "1"
slot0.GroupShowTag = "2"

function slot0.decodeShowStr(slot0)
	if string.nilorempty(slot0) then
		return {}, {}
	end

	for slot7 = 1, #string.split(slot0, ",") do
		if not string.nilorempty(slot3[slot7]) then
			uv0.fillShowSet(slot1, slot2, slot8)
		end
	end

	return slot1, slot2
end

function slot0.fillShowSet(slot0, slot1, slot2)
	if #string.split(slot2, ":") >= 2 then
		slot7 = slot3[1] == uv0.GroupShowTag and slot1 or slot0

		if not string.nilorempty(slot3[2]) and string.splitToNumber(slot5, "#") and #slot8 > 0 then
			for slot12, slot13 in ipairs(slot8) do
				table.insert(slot7, slot13)
			end
		end
	end
end

function slot0.encodeShowStr()
end

return slot0
