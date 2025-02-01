module("modules.logic.versionactivity1_9.lucy.view.ActLucyTaskViewContainer", package.seeall)

slot0 = class("ActLucyTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_TaskList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = ActLucyTaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1160
	slot2.cellHeight = 165
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	for slot7 = 1, 6 do
	end

	slot4 = LuaListScrollViewWithAnimator.New(RoleActivityTaskListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.06
	})
	slot4.dontPlayCloseAnimation = true

	table.insert(slot1, slot4)
	table.insert(slot1, ActLucyTaskView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return slot0
