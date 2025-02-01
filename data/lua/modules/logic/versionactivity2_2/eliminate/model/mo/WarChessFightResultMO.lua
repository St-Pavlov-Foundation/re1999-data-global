module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessFightResultMO", package.seeall)

slot0 = class("WarChessFightResultMO")

function slot0.updateInfo(slot0, slot1)
	slot0.resultCode = slot1.resultCode

	if not string.nilorempty(slot1.extraData) then
		slot0.result = cjson.decode(slot1.extraData)
	end
end

function slot0.getResultInfo(slot0)
	return slot0.result and slot0.result or {}
end

function slot0.getRewardCount(slot0)
	slot1 = 0

	if slot0.result then
		for slot5, slot6 in pairs(slot0.result) do
			if slot5 ~= "star" then
				slot1 = slot1 + tabletool.len(slot6)
			end
		end
	end

	return slot1
end

function slot0.getStar(slot0)
	slot1 = 0

	if slot0.result then
		slot1 = tonumber(slot0.result.star)
	end

	return slot1
end

function slot0.haveReward(slot0)
	return slot0:getRewardCount() > 0
end

return slot0
