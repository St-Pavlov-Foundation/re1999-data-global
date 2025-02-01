module("modules.logic.seasonver.act123.view1_8.Season123_1_8CardPackageViewContainer", package.seeall)

slot0 = class("Season123_1_8CardPackageViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0:buildScrollViews()

	return {
		Season123_1_8CardPackageView.New(),
		slot0.scrollView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot2:setHelpId(HelpEnum.HelpId.Season1_8CardGetViewHelp)
		slot2:hideHelpIcon()

		return {
			slot2
		}
	end
end

function slot0.buildScrollViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_cardget/mask/#scroll_cardget"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season123_1_8CardPackageItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 204
	slot1.cellHeight = 290
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 50
	slot1.frameUpdateMs = 100

	for slot6 = 1, 15 do
	end

	slot0.scrollView = LuaListScrollViewWithAnimator.New(Season123CardPackageModel.instance, slot1, {
		[slot6] = math.ceil(slot6 / 5) * 0.06
	})
end

return slot0
