module("modules.logic.activity.view.LinkageActivity_BaseView", package.seeall)

slot0 = class("LinkageActivity_BaseView", Activity101SignViewBase)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)

	slot0._pageItemList = {}
	slot0._curPageIndex = false
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_pageItemList")
	Activity101SignViewBase._internal_onDestroy(slot0)
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
end

function slot0.selectedPage(slot0, slot1)
	if slot0._curPageIndex == slot1 then
		return
	end

	slot0._curPageIndex = slot1

	slot0:onSelectedPage(slot1, slot0._curPageIndex)
end

function slot0.getPage(slot0, slot1)
	return slot0._pageItemList[slot1]
end

function slot0.addPage(slot0, slot1, slot2, slot3)
	slot4 = slot3.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})

	slot4:setIndex(slot1)
	slot4:init(slot2)
	table.insert(slot0._pageItemList, slot4)

	return slot4
end

function slot0.getLinkageActivityCO(slot0)
	return ActivityType101Config.instance:getLinkageActivityCO(slot0:actId())
end

function slot0.onStart(slot0)
	assert(false, "please override this function")
end

function slot0.onSelectedPage(slot0, slot1, slot2)
	slot3 = slot0:getPage(slot1)
	slot4 = nil

	if slot2 then
		slot0:getPage(slot2):setActive(false)
	end

	slot3:setActive(true)

	for slot8, slot9 in ipairs(slot0._pageItemList) do
		slot9:onPostSelectedPage(slot3, slot4)
	end
end

function slot0.onRefresh(slot0)
	for slot4, slot5 in ipairs(slot0._pageItemList) do
		slot5:onUpdateMO()
	end
end

return slot0
