module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5RevivalTaskView", package.seeall)

slot0 = class("VersionActivity1_5RevivalTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._goheroTabList = gohelper.findChild(slot0.viewGO, "#go_heroTabList")
	slot0._goTabItem = gohelper.findChild(slot0.viewGO, "#go_heroTabList/#go_TabItem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goTabItem, false)

	slot0.heroTabItemList = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot4 = VersionActivity1_5RevivalTaskModel.instance
	slot6 = slot4

	for slot5, slot6 in ipairs(slot4.getTaskMoList(slot6)) do
		table.insert(slot0.heroTabItemList, VersionActivity1_5HeroTabItem.createItem(gohelper.cloneInPlace(slot0._goTabItem), slot6))

		if not false and slot6:isUnlock() then
			slot1 = true

			VersionActivity1_5RevivalTaskModel.instance:setSelectHeroTaskId(slot6.id)
		end
	end
end

function slot0.onClose(slot0)
	VersionActivity1_5RevivalTaskModel.instance:clearSelectTaskId()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.heroTabItemList) do
		slot5:destroy()
	end

	slot0.heroTabItemList = nil
end

return slot0
