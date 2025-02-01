module("modules.logic.activity.view.ActivityNormalViewContainer", package.seeall)

slot0 = class("ActivityNormalViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_item"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = ActivityCategoryItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 300
	slot2.cellHeight = 125
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 9.8
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(ActivityNormalCategoryListModel.instance, slot2))
	table.insert(slot1, ActivityNormalView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigationView
		}
	end
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_Activity_close)
end

return slot0
