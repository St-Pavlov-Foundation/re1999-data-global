module("modules.logic.rouge.view.RougeTeamViewContainer", package.seeall)

slot0 = class("RougeTeamViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_view"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = RougeTeamHeroItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 6
	slot1.cellWidth = 250
	slot1.cellHeight = 555
	slot1.cellSpaceH = 20
	slot1.cellSpaceV = 56
	slot1.startSpace = 50

	for slot6 = 1, 21 do
	end

	slot3 = {}

	table.insert(slot3, RougeTeamView.New())
	table.insert(slot3, LuaListScrollViewWithAnimator.New(RougeTeamListModel.instance, slot1, {
		[slot6] = math.ceil((slot6 - 1) % 6) * 0.03
	}))
	table.insert(slot3, TabViewGroup.New(1, "#go_lefttop"))

	return slot3
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

return slot0
