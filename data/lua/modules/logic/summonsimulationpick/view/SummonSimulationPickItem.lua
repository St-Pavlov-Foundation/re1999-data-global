module("modules.logic.summonsimulationpick.view.SummonSimulationPickItem", package.seeall)

slot0 = class("SummonSimulationPickItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._imageicon = gohelper.findChildImage(slot1, "heroicon/#image_icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._heroItems = {}
	slot0._goheroItem = gohelper.findChild(slot0._go, "#scroll_result/Viewport/content/#go_heroitem")
	slot0._root = gohelper.findChild(slot0._go, "#scroll_result/Viewport/content")

	gohelper.setActive(slot0._goheroItem, false)
end

function slot0.refreshData(slot0, slot1, slot2)
	slot0.selectType = slot2
	slot4 = #slot0._heroItems
	slot5 = slot1 and #slot1 or 0

	for slot9 = 1, slot5 do
		slot10 = nil

		if slot4 < slot9 then
			slot10 = SummonSimulationPickListItem.New()

			slot10:init(slot0:getItem())
			table.insert(slot3, slot10)
		else
			slot10 = slot3[slot9]
		end

		gohelper.setActive(slot10.go, true)
		slot10:setData(slot1[slot9], slot0.selectType)
	end

	if slot5 < slot4 then
		for slot9 = slot5 + 1, slot4 do
			gohelper.setActive(slot3[slot9].go, false)
		end
	end
end

function slot0.getItem(slot0)
	return gohelper.clone(slot0._goheroItem, slot0._root)
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0._go, slot1)
end

function slot0.setParent(slot0, slot1)
	slot0._go.transform.parent = slot1.transform

	transformhelper.setLocalPosXY(slot0._go.transform, 0, 0)
end

function slot0.getTransform(slot0)
	return slot0._go.transform
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in ipairs(slot0._heroItems) do
		slot5:onDestroy()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
