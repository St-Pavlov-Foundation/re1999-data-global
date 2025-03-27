module("modules.logic.playercard.model.PlayerCardThemeListModel", package.seeall)

slot0 = class("PlayerCardThemeListModel", ListScrollModel)

function slot0.init(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(ItemModel.instance:getItemsBySubType(ItemEnum.SubType.PlayerBg)) do
		slot8 = PlayerCardSkinMo.New()

		slot8:init(slot7)
		table.insert(slot1, slot8)
	end

	slot3 = PlayerCardSkinMo.New()

	slot3:setEmpty()
	table.insert(slot1, slot3)
	table.sort(slot1, uv0.sort)
	slot0:setList(slot1)

	if #slot1 == 1 then
		PlayerCardModel.instance:setSelectSkinMO(slot3)
	end
end

function slot0.sort(slot0, slot1)
	if (slot0:checkIsUse() and 3 or slot0:isEmpty() and 2 or 1) ~= (slot1:checkIsUse() and 3 or slot1:isEmpty() and 2 or 1) then
		return slot3 < slot2
	else
		return slot0.id < slot1.id
	end
end

function slot0.checkSkinUnlock(slot0)
end

function slot0.getSelectIndex(slot0)
	return slot0._selectIndex or 1
end

slot0.instance = slot0.New()

return slot0
