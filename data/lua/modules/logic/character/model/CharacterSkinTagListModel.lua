module("modules.logic.character.model.CharacterSkinTagListModel", package.seeall)

slot0 = class("CharacterSkinTagListModel", ListScrollModel)

function slot0.updateList(slot0, slot1)
	slot2 = {}

	if string.nilorempty(slot1.storeTag) == false then
		for slot7, slot8 in ipairs(string.splitToNumber(slot1.storeTag, "|")) do
			table.insert(slot2, SkinConfig.instance:getSkinStoreTagConfig(slot8))
		end
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
