module("modules.logic.fight.fightcomponent.FightViewComponent", package.seeall)

slot0 = class("FightViewComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0.inner_childViews = {}
end

function slot0.openSubView(slot0, slot1, slot2, slot3, ...)
	if not slot1.IS_FIGHT_BASE_VIEW then
		return slot0:openSubViewForBaseView(slot1, slot2, slot3, ...)
	end

	slot4 = slot0.PARENT_ROOT_CLASS
	slot5 = slot0:newClass(slot1, ...)
	slot5.viewName = slot4.viewName
	slot5.viewContainer = slot4.viewContainer
	slot5.PARENT_VIEW = slot4

	if type(slot2) == "string" then
		slot0:com_loadAsset(slot2, slot0._onViewGOLoadFinish, {
			handle = slot5,
			parent_obj = slot3 or slot4.viewGO
		})
	else
		slot5.viewGO = slot2
		slot5.keyword_gameObject = slot2

		slot5:inner_startView()
	end

	table.insert(slot0.inner_childViews, slot5)

	return slot5
end

function slot0._onViewGOLoadFinish(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot5 = gohelper.clone(slot2:GetResource(), slot3.parent_obj)
	slot6 = slot3.handle
	slot6.viewGO = slot5
	slot6.keyword_gameObject = slot5

	slot6:inner_startView()
end

function slot0.openSubViewForBaseView(slot0, slot1, slot2, ...)
	if not slot0.inner_childForBaseView then
		slot0.inner_childForBaseView = {}
	end

	slot3 = slot1.New(...)
	slot3.viewName = slot0.viewName
	slot3.viewContainer = slot0.viewContainer
	slot3.PARENT_VIEW = slot0

	slot3:__onInit()

	slot3.viewGO = slot2

	slot3:onInitViewInternal()
	slot3:addEventsInternal()
	slot3:onOpenInternal()
	slot3:onOpenFinishInternal()
	table.insert(slot0.inner_childForBaseView, slot3)

	return slot3
end

function slot0.openExclusiveView(slot0, slot1, slot2, slot3, slot4, ...)
	return slot0:openSignExclusiveView(1, slot1, slot2, slot3, slot4, ...)
end

function slot0.openSignExclusiveView(slot0, slot1, slot2, slot3, slot4, slot5, ...)
	if not slot0.exclusive_tab then
		slot0.exclusive_tab = {}
		slot0.exclusive_opening = {}
	end

	slot1 = slot1 or 1
	slot0.exclusive_tab[slot1] = slot0.exclusive_tab[slot1] or {}

	if slot0.exclusive_tab[slot1][slot0.exclusive_opening[slot1]] then
		if slot2 == slot0.exclusive_opening[slot1] then
			return slot6
		end

		slot0:hideExclusiveView(slot6, slot1, slot2)
	end

	if slot0.exclusive_tab[slot1][slot2] then
		slot0:setExclusiveViewVisible(slot0.exclusive_tab[slot1][slot2], true)

		slot0.exclusive_opening[slot1] = slot2

		return slot0.exclusive_tab[slot1][slot2]
	end

	slot6 = slot0:openSubView(slot3, slot4, slot5, ...)
	slot6.internalExclusiveSign = slot1
	slot6.internalExclusiveID = slot2
	slot0.exclusive_tab[slot1][slot2] = slot6
	slot0.exclusive_opening[slot1] = slot2

	return slot6
end

function slot0.hideExclusiveGroup(slot0, slot1)
	slot1 = slot1 or 1

	if slot0.exclusive_opening and slot0.exclusive_opening[slot1] then
		slot0:hideExclusiveView(slot0.exclusive_tab[slot1][slot0.exclusive_opening[slot1]])
	end
end

function slot0.hideExclusiveView(slot0, slot1, slot2, slot3)
	slot1 = slot1 or slot0.exclusive_tab[slot2 or 1][slot3]

	if slot0.exclusive_opening[slot1.internalExclusiveSign] == slot1.internalExclusiveID then
		slot0.exclusive_opening[slot1.internalExclusiveSign] = nil
	end

	slot0:setExclusiveViewVisible(slot1, false)
end

function slot0.setExclusiveViewVisible(slot0, slot1, slot2)
	if slot1.onSetExclusiveViewVisible then
		slot1:onSetExclusiveViewVisible(slot2)
	else
		slot1:setViewVisibleInternal(slot2)
	end
end

function slot0.killAllSubView(slot0)
	if slot0.inner_childForBaseView then
		for slot4 = #slot0.inner_childForBaseView, 1, -1 do
			slot5 = slot0.inner_childForBaseView[slot4]

			slot5:onCloseInternal()
			slot5:onCloseFinishInternal()
			slot5:removeEventsInternal()
			slot5:onDestroyViewInternal()
			slot5:__onDispose()
		end

		slot0.inner_childForBaseView = nil
	end

	for slot4 = #slot0.inner_childViews, 1, -1 do
		if not slot0.inner_childViews[slot4].IS_DISPOSED then
			slot5:onCloseInternal()
			slot5:onCloseFinishInternal()
			slot5:removeEventsInternal()
			slot5:onDestroyViewInternal()
			slot5:disposeSelf()
		end
	end
end

function slot0.onDestructor(slot0)
	slot0:killAllSubView()
end

return slot0
