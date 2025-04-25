module("modules.logic.playercard.model.PlayerCardThemeListModel", package.seeall)

slot0 = class("PlayerCardThemeListModel", ListScrollModel)

function slot0.init(slot0)
	slot1 = {}
	slot3 = PlayerCardModel.instance:getCardInfo():getThemeId()

	for slot7, slot8 in ipairs(ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.PlayerBg)) do
		slot9 = PlayerCardSkinMo.New()

		slot9:init(slot8)
		table.insert(slot1, slot9)

		if slot3 == slot9.id then
			PlayerCardModel.instance:setSelectSkinMO(slot9)
		end
	end

	slot4 = PlayerCardSkinMo.New()

	slot4:setEmpty()
	table.insert(slot1, slot4)
	table.sort(slot1, uv0.sort)

	if #slot1 == 1 or slot3 == 0 then
		PlayerCardModel.instance:setSelectSkinMO(slot4)
	end

	slot0:setList(slot1)
end

function slot0.sort(slot0, slot1)
	if (slot0:checkIsUse() and 3 or slot0:isEmpty() and 2 or 1) ~= (slot1:checkIsUse() and 3 or slot1:isEmpty() and 2 or 1) then
		return slot3 < slot2
	else
		return slot0.id < slot1.id
	end
end

function slot0.getMoById(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot1 == slot7.id then
			return slot7
		end
	end
end

function slot0.getSelectIndex(slot0)
	return slot0._selectIndex or 1
end

slot0.instance = slot0.New()

return slot0
