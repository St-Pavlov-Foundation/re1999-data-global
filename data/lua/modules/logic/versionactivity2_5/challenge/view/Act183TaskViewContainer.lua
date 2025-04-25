module("modules.logic.versionactivity2_5.challenge.view.Act183TaskViewContainer", package.seeall)

slot0 = class("Act183TaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(slot1, Act183TaskView.New())

	slot2 = MixScrollParam.New()
	slot2.scrollGOPath = "root/right/#scroll_task"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = Act183TaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.startSpace = 0
	slot2.endSpace = 0
	slot0._scrollView = LuaMixScrollView.New(Act183TaskListModel.instance, slot2)

	slot0._scrollView:setDynamicGetItem(slot0._dynamicGetItem, slot0)
	table.insert(slot1, slot0._scrollView)

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

function slot0._dynamicGetItem(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1.type == Act183Enum.TaskListItemType.Head then
		return "taskheader", Act183TaskHeadItem, slot0._viewSetting.otherRes[2]
	elseif slot1.type == Act183Enum.TaskListItemType.OneKey then
		return "onekey", Act183TaskOneKeyItem, slot0._viewSetting.otherRes[3]
	end
end

function slot0.getTaskScrollView(slot0)
	return slot0._scrollView
end

return slot0
