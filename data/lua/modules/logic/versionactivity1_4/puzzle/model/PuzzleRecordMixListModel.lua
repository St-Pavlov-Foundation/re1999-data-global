module("modules.logic.versionactivity1_4.puzzle.model.PuzzleRecordMixListModel", package.seeall)

slot0 = class("PuzzleRecordMixListModel", MixScrollModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._infos = nil
end

function slot0.setRecordList(slot0, slot1)
	slot0._infos = slot1

	slot0:setList(slot1)
end

function slot0.getInfoList(slot0, slot1)
	if not slot0._infos or #slot0._infos <= 0 then
		return {}
	end

	for slot8, slot9 in ipairs(slot0._infos) do
		slot10 = 0

		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(0, GameUtil.getTextHeightByLine(gohelper.findChildText(slot1, "Viewport/Content/RecordItem"), GameUtil.filterRichText(slot9:GetRecord()) .. "   ", 37.1) + 20, nil))
	end

	return slot2
end

function slot0.clearData(slot0)
	slot0._infos = nil
end

slot0.instance = slot0.New()

return slot0
