module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionStorageViewContainer", package.seeall)

slot0 = class("RougeMapCollectionStorageViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeMapCollectionStorageView.New())
	table.insert(slot1, TabViewGroup.New(2, "#go_rougemapdetailcontainer"))

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "Left/#scroll_view"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = RougeMapEnum.CollectionLeftItemRes
	slot2.cellClass = RougeMapCollectionLossLeftItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 850
	slot2.cellHeight = 180
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 8
	slot2.startSpace = 0
	slot0.scrollView = LuaListScrollView.New(RougeLossCollectionListModel.instance, slot2)

	table.insert(slot1, slot0.scrollView)

	return slot1
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

return slot0
