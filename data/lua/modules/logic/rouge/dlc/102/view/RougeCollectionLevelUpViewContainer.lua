module("modules.logic.rouge.dlc.102.view.RougeCollectionLevelUpViewContainer", package.seeall)

slot0 = class("RougeCollectionLevelUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeCollectionLevelUpView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, TabViewGroup.New(2, "#go_rougemapdetailcontainer"))

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "Left/#scroll_view"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = RougeEnum.ResPath.CollectionLevelUpLeftItem
	slot2.cellClass = RougeCollectionLevelUpLeftItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 850
	slot2.cellHeight = 180
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 8
	slot2.startSpace = 0
	slot0.scrollView = LuaListScrollView.New(RougeCollectionLevelUpListModel.instance, slot2)

	table.insert(slot1, slot0.scrollView)

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			slot0.viewParam and slot0.viewParam.closeBtnVisible,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	elseif slot1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function slot0.onContainerInit(slot0)
	slot0.listRemoveComp = ListScrollAnimRemoveItem.Get(slot0.scrollView)

	slot0.listRemoveComp:setMoveInterval(0)
end

function slot0.getListRemoveComp(slot0)
	return slot0.listRemoveComp
end

function slot0.getNavigateView(slot0)
	return slot0.navigateView
end

return slot0
