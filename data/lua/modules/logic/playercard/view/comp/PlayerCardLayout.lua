module("modules.logic.playercard.view.comp.PlayerCardLayout", package.seeall)

slot0 = class("PlayerCardLayout", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.setLayoutList(slot0, slot1)
	slot0._layoutList = slot1
end

function slot0.setData(slot0, slot1)
	if slot0._layoutList then
		for slot5, slot6 in ipairs(slot0._layoutList) do
			slot6:setLayoutIndex(slot1[slot6:getLayoutKey()] or slot7)
		end

		table.sort(slot0._layoutList, SortUtil.keyLower("index"))
		slot0:refreshLayout()
	end
end

function slot0.refreshLayout(slot0)
	if not slot0._layoutList then
		return
	end

	table.sort(slot0._layoutList, SortUtil.keyLower("index"))

	slot1 = -197

	for slot5, slot6 in ipairs(slot0._layoutList) do
		recthelper.setAnchorY(slot6:getLayoutGO().transform, slot1)

		slot1 = slot1 - slot6:getHeight() - 5
	end
end

function slot0.setEditMode(slot0, slot1)
	if slot0._layoutList then
		for slot5, slot6 in ipairs(slot0._layoutList) do
			slot6:setEditMode(slot1)
		end
	end
end

function slot0.startUpdate(slot0, slot1)
	if slot0._inUpdate then
		return
	end

	slot0.dragItem = slot1
	slot0._inUpdate = true

	LateUpdateBeat:Add(slot0._lateUpdate, slot0)

	if slot0._layoutList then
		for slot5, slot6 in ipairs(slot0._layoutList) do
			slot6:onStartDrag()
		end
	end
end

function slot0.closeUpdate(slot0)
	if not slot0._inUpdate then
		return
	end

	slot0.dragItem = nil
	slot0._inUpdate = false

	LateUpdateBeat:Remove(slot0._lateUpdate, slot0)

	if slot0._layoutList then
		for slot4, slot5 in ipairs(slot0._layoutList) do
			slot5:onEndDrag()
		end
	end
end

function slot0._lateUpdate(slot0)
	slot0:caleLayout()
end

function slot0.caleLayout(slot0)
	if not slot0.dragItem then
		return
	end

	if slot0._layoutList then
		for slot4, slot5 in ipairs(slot0._layoutList) do
			if not slot5.inDrag and slot0.dragItem:isInArea(slot5:getCenterScreenPosY()) then
				slot0.dragItem:exchangeIndex(slot5)
				slot0:refreshLayout()

				break
			end
		end
	end
end

function slot0.getLayoutData(slot0)
	slot1 = {}

	if slot0._layoutList then
		for slot5, slot6 in ipairs(slot0._layoutList) do
			table.insert(slot1, string.format("%s_%s", slot6:getLayoutKey(), slot5))
		end
	end

	return table.concat(slot1, "&")
end

function slot0.onDestroy(slot0)
	slot0:closeUpdate()
end

return slot0
