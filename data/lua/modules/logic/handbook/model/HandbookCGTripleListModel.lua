module("modules.logic.handbook.model.HandbookCGTripleListModel", package.seeall)

slot0 = class("HandbookCGTripleListModel", MixScrollModel)

function slot0.setCGList(slot0, slot1)
	slot4 = {}

	for slot10, slot11 in ipairs(slot1.cgList) do
		if HandbookModel.instance:isCGUnlock(slot11.id) then
			slot12 = slot11.storyChapterId
			slot6 = nil or {}

			if not slot5 or slot5 ~= slot12 then
				if #slot6 > 0 then
					slot13 = HandbookCGTripleMO.New()

					slot13:init({
						cgList = slot6,
						cgType = slot1.cgType
					})
					table.insert(slot4, slot13)

					slot6 = {}
				end

				slot13 = HandbookCGTripleMO.New()

				slot13:init({
					isTitle = true,
					storyChapterId = slot12
				})
				table.insert(slot4, slot13)
			end

			if slot11.preCgId == 0 then
				table.insert(slot6, slot11)
			end

			slot5 = slot12
		end

		if slot6 and #slot6 >= 3 or slot10 == #slot3 and slot6 and #slot6 > 0 then
			slot12 = HandbookCGTripleMO.New()

			slot12:init({
				cgList = slot6,
				cgType = slot2
			})
			table.insert(slot4, slot12)

			slot6 = nil
		end
	end

	slot0:setList(slot4)
end

function slot0.getInfoList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(slot7.isTitle and 0 or 1, slot8 and 90 or 298, nil))
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
