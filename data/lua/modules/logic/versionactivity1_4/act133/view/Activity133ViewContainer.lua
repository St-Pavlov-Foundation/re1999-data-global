module("modules.logic.versionactivity1_4.act133.view.Activity133ViewContainer", package.seeall)

slot0 = class("Activity133ViewContainer", BaseViewContainer)
slot1 = 1
slot2 = 2

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_view"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = Activity133ListItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 268
	slot2.cellHeight = 650
	slot2.cellSpaceH = 30
	slot2.startSpace = 20
	slot2.endSpace = 20

	for slot7 = 1, 4 do
	end

	slot0._scrollview = LuaListScrollViewWithAnimator.New(Activity133ListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.06
	})

	table.insert(slot1, slot0._scrollview)
	table.insert(slot1, Activity133View.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, TabViewGroup.New(2, "#go_topright"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == uv1 then
		slot0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.Act133
		})
		slot0._currencyView.foreHideBtn = true

		return {
			slot0._currencyView
		}
	end
end

return slot0
