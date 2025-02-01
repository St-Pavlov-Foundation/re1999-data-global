module("modules.logic.season.view1_6.Season1_6FightCardView", package.seeall)

slot0 = class("Season1_6FightCardView", BaseView)

function slot0.onInitView(slot0)
	slot0._goCardItem = gohelper.findChild(slot0.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(slot0._goCardItem, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot1 = Activity104Model.instance:getFightCardDataList()

	if not slot0.itemList then
		slot0.itemList = {}
	end

	slot5 = #slot1

	for slot5 = 1, math.max(#slot0.itemList, slot5) do
		slot0:updateItem(slot0.itemList[slot5] or slot0:createItem(slot5), slot1[slot5])
	end
end

function slot0.createItem(slot0, slot1)
	slot3 = Season1_6FightCardItem.New(gohelper.cloneInPlace(slot0._goCardItem, string.format("card%s", slot1)))
	slot0.itemList[slot1] = slot3

	return slot3
end

function slot0.updateItem(slot0, slot1, slot2)
	slot1:setData(slot2)
end

function slot0.destroyItem(slot0, slot1)
	slot1:destroy()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.itemList then
		for slot4, slot5 in pairs(slot0.itemList) do
			slot0:destroyItem(slot5)
		end

		slot0.itemList = nil
	end
end

return slot0
