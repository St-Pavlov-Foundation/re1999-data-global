module("modules.common.others.ViewHelper", package.seeall)

slot0 = class("ViewHelper")

function slot0.checkViewNameDictInit(slot0)
	if slot0.viewNameDict then
		return
	end

	slot0.viewNameDict = {}
end

function slot0.OpenViewAndWaitViewClose(slot0, slot1, slot2, slot3, slot4)
	slot0:checkViewNameDictInit()

	if slot0.viewNameDict[slot1] then
		logWarn(slot1 .. "close callback override!")
	end

	slot0.viewNameDict[slot1] = {
		slot3,
		slot4
	}

	ViewMgr.instance:openView(slot1, slot2)

	if not slot0.registerEvent then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0.onViewClose, slot0)

		slot0.registerEvent = true
	end
end

function slot0.onViewClose(slot0, slot1)
	if not slot0.viewNameDict[slot1] then
		return
	end

	slot2 = slot0.viewNameDict[slot1][1]
	slot3 = slot0.viewNameDict[slot1][2]
	slot0.viewNameDict[slot1] = nil

	if tabletool.len(slot0.viewNameDict) == 0 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0.onViewClose, slot0)

		slot0.registerEvent = false
	end

	if slot2 then
		return slot2(slot3)
	end
end

function slot0.initGlobalIgnoreViewList(slot0)
	if not slot0.checkViewTopIgnoreViewList then
		slot0.checkViewTopIgnoreViewList = {
			ViewName.ToastView
		}
	end

	return slot0.checkViewTopIgnoreViewList
end

function slot0.checkIsGlobalIgnore(slot0, slot1)
	slot0:initGlobalIgnoreViewList()

	return tabletool.indexOf(slot0.checkViewTopIgnoreViewList, slot1)
end

function slot0.checkViewOnTheTop(slot0, slot1, slot2)
	slot0:initGlobalIgnoreViewList()

	for slot8 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
		if not tabletool.indexOf(slot0.checkViewTopIgnoreViewList, slot3[slot8]) then
			if not slot2 then
				return slot9 == slot1
			end

			if not tabletool.indexOf(slot2, slot9) then
				return slot9 == slot1
			end
		end
	end

	return false
end

function slot0.checkAnyViewOnTheTop(slot0, slot1, slot2)
	if not slot1 or #slot1 == 0 then
		return false
	end

	slot3 = {
		[slot10] = true
	}
	slot4 = {}
	slot5 = ViewMgr.instance:getOpenViewNameList()

	for slot9, slot10 in ipairs(slot1) do
		-- Nothing
	end

	if slot2 then
		for slot9, slot10 in ipairs(slot2) do
			slot4[slot10] = true
		end
	end

	for slot9 = #slot5, 1, -1 do
		if ViewMgr.instance:getContainer(slot5[slot9]) and not slot0:checkIsGlobalIgnore(slot10) and not slot4[slot10] and slot3[slot10] then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
