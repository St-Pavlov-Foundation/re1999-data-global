module("modules.logic.rouge.view.RougeCollectionEnchantViewContainer", package.seeall)

slot0 = class("RougeCollectionEnchantViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "right/#scroll_enchants"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "right/#scroll_enchants/Viewport/Content/#go_enchantitem"
	slot1.cellClass = RougeCollectionEnchantListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 3
	slot1.cellWidth = 186
	slot1.cellHeight = 186
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 9
	slot1.endSpace = 0
	slot0._enchantScrollView = LuaListScrollView.New(RougeCollectionEnchantListModel.instance, slot1)

	return {
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		RougeCollectionEnchantView.New(),
		slot0._enchantScrollView
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return slot0
