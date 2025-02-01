module("modules.logic.versionactivity2_2.dungeon.view.store.VersionActivity2_2StoreViewContainer", package.seeall)

slot0 = class("VersionActivity2_2StoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_store"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#scroll_store/Viewport/#go_content/#go_storegoodsitem"
	slot1.cellClass = VersionActivity2_2StoreGoodsItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 4
	slot1.cellWidth = 316
	slot1.cellHeight = 365

	return {
		VersionActivity2_2StoreView.New(),
		VersionActivity2_2StoreTalk.New(),
		LuaListScrollView.New(VersionActivity2_2StoreListModel.instance, slot1),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
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

	if slot1 == 2 then
		slot0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.V2a2Dungeon
		})

		slot0._currencyView:setOpenCallback(slot0._onCurrencyOpen, slot0)

		return {
			slot0._currencyView
		}
	end
end

function slot0._onCurrencyOpen(slot0)
	slot1 = slot0._currencyView:getCurrencyItem(1)

	gohelper.setActive(slot1.btn, false)
	gohelper.setActive(slot1.click, true)
	recthelper.setAnchorX(slot1.txt.transform, 313)
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_2Enum.ActivityId.DungeonStore)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_2Enum.ActivityId.DungeonStore
	})
end

return slot0
