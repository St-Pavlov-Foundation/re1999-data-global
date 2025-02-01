module("modules.logic.rouge.model.RougeIllustrationListModel", package.seeall)

slot0 = class("RougeIllustrationListModel", MixScrollModel)

function slot0.initList(slot0)
	tabletool.addValues({}, RougeFavoriteConfig.instance:getIllustrationPages())

	if RougeFavoriteConfig.instance:getNormalIllustrationPageCount() > 0 then
		table.insert(slot1, slot3 + 1, slot0:getSplitSpaceInfoItem())
	end

	slot0:setList(slot1)
end

slot1 = {
	480,
	660,
	1140,
	1500,
	1770,
	2103
}
slot2 = 300
slot3 = 1000

function slot0.getInfoList(slot0, slot1)
	slot2 = {}
	slot0._splitSpaceStartPosX = 0
	slot4 = false

	for slot8, slot9 in ipairs(slot0:getList()) do
		slot10 = nil

		if slot9.isSplitSpace then
			slot10 = SLFramework.UGUI.MixCellInfo.New(uv0, uv1, slot8)
			slot4 = true
		else
			slot11 = #slot9
			slot10 = SLFramework.UGUI.MixCellInfo.New(slot11, uv2[slot11], slot8)

			if not slot4 then
				slot0._splitSpaceStartPosX = slot0._splitSpaceStartPosX + uv2[slot11]
			end
		end

		table.insert(slot2, slot10)
	end

	return slot2
end

function slot0.getSplitSpaceInfoItem(slot0)
	if not slot0._splitSpaceItem then
		slot0._splitSpaceItem = {
			isSplitSpace = true
		}
	end

	return slot0._splitSpaceItem
end

function slot0.getSplitEmptySpaceStartPosX(slot0)
	return slot0._splitSpaceStartPosX or 0
end

slot0.instance = slot0.New()

return slot0
