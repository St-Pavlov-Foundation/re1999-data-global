module("modules.logic.rouge.model.RougeFavoriteCollectionEnchantListModel", package.seeall)

slot0 = class("RougeFavoriteCollectionEnchantListModel", ListScrollModel)

function slot0.initData(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(RougeCollectionListModel.instance:getEnchantList()) do
		if slot8 ~= slot1 then
			table.insert(slot3, slot8)
		end
	end

	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
