module("modules.logic.room.view.common.RoomStroreGoodsTipViewBanner", package.seeall)

slot0 = class("RoomStroreGoodsTipViewBanner", RoomMaterialTipViewBanner)

function slot0._getItemDataList(slot0)
	slot3 = {
		MaterialEnum.MaterialType.RoomTheme,
		MaterialEnum.MaterialType.BlockPackage,
		MaterialEnum.MaterialType.Building
	}

	for slot9 = 1, #slot2 do
		slot10 = slot2[slot9]
		slot11 = slot10[1]

		if #GameUtil.splitString2(slot0.viewParam.storeGoodsMO.config.product, true) > 1 and RoomConfig.instance:getThemeIdByItem(slot10[2], slot11) then
			slot0:_addItemInfoToDic({}, slot13, MaterialEnum.MaterialType.RoomTheme)
		end

		if tabletool.indexOf(slot3, slot11) then
			slot0:_addItemInfoToDic(slot4, slot12, slot11)
		end
	end

	slot6 = {}

	for slot10, slot11 in ipairs(slot3) do
		if slot4[slot11] then
			for slot15, slot16 in ipairs(slot4[slot11]) do
				table.insert(slot6, {
					itemId = slot16,
					itemType = slot11
				})
			end
		end
	end

	return slot6
end

function slot0._addItemInfoToDic(slot0, slot1, slot2, slot3)
	if not (slot1 or {})[slot3] then
		slot1[slot3] = {}
	end

	if tabletool.indexOf(slot1[slot3], slot2) == nil then
		table.insert(slot1[slot3], slot2)
	end

	return slot1
end

return slot0
