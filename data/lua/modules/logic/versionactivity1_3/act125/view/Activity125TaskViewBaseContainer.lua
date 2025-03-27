module("modules.logic.versionactivity1_3.act125.view.Activity125TaskViewBaseContainer", package.seeall)

slot0 = class("Activity125TaskViewBaseContainer", Activity125ViewBaseContainer)

function slot0.onContainerInit(slot0)
	uv0.super.onContainerInit(slot0)

	slot0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0._taskScrollView)

	slot0._taskAnimRemoveItem:setMoveInterval(0)
end

function slot0.removeByIndex(slot0, slot1, slot2, slot3)
	slot0._taskAnimRemoveItem:removeByIndex(slot1, slot2, slot3)
end

return slot0
