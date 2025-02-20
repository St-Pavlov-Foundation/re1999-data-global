module("modules.logic.act189.view.ShortenActViewContainer_impl", package.seeall)

slot0 = class("ShortenActViewContainer_impl", Activity189BaseViewContainer)

function slot0.initTaskScrollView(slot0, slot1)
	if slot0.__taskScrollView then
		return slot0.__taskScrollView
	end

	if not slot1 then
		slot1 = ListScrollParam.New()
		slot1.scrollGOPath = "root/right/#scroll_tasklist"
		slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot1.prefabUrl = slot0._viewSetting.otherRes[1]
		slot1.cellClass = ShortenAct_TaskItem
		slot1.scrollDir = ScrollEnum.ScrollDirV
		slot1.lineCount = 1
		slot1.cellWidth = 872
		slot1.cellHeight = 132
		slot1.cellSpaceH = 0
		slot1.cellSpaceV = 16
	end

	for slot6 = 1, 5 do
	end

	slot0.__taskScrollView = LuaListScrollViewWithAnimator.New(Activity189_TaskListModel.instance, slot1, {
		[slot6] = (slot6 - 1) * 0.06
	})
	slot0.notPlayAnimation = true

	return slot0.__taskScrollView
end

function slot0.taskScrollView(slot0)
	return slot0.__taskScrollView or slot0:initTaskScrollView()
end

function slot0.onContainerInit(slot0)
	uv0.super.onContainerInit(slot0)

	slot0.__taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0:taskScrollView())

	slot0.__taskAnimRemoveItem:setMoveInterval(0)
end

function slot0.onContainerClose(slot0)
	uv0.super.onContainerClose(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.removeByIndex(slot0, slot1, slot2, slot3)
	slot0.__taskAnimRemoveItem:removeByIndex(slot1, slot2, slot3)
end

function slot0.actId(slot0)
	return ShortenActConfig.instance:getActivityId()
end

return slot0
