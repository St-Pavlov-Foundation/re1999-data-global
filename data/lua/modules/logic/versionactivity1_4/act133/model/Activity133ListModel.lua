module("modules.logic.versionactivity1_4.act133.model.Activity133ListModel", package.seeall)

slot0 = class("Activity133ListModel", ListScrollModel)

function slot0.init(slot0, slot1)
	slot2 = {}
	slot0.scrollgo = slot1

	for slot7, slot8 in ipairs(Activity133Config.instance:getBonusCoList()) do
		slot9 = Activity133ListMO.New()

		slot9:init(slot8[1])
		table.insert(slot2, slot9)
	end

	slot7 = uv0._sortFunction

	table.sort(slot2, slot7)

	for slot7, slot8 in ipairs(slot2) do
		if not Activity133Model.instance:checkBonusReceived(slot8.id) and tonumber(string.splitToNumber(slot8.config.needTokens, "#")[3]) <= CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act133).quantity then
			slot8.showRed = true

			break
		end
	end

	slot0:setList(slot2)
end

function slot0._sortFunction(slot0, slot1)
	if slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

function slot0.reInit(slot0)
end

slot0.instance = slot0.New()

return slot0
