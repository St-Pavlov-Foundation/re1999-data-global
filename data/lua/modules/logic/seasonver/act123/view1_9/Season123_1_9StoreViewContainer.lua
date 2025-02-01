module("modules.logic.seasonver.act123.view1_9.Season123_1_9StoreViewContainer", package.seeall)

slot0 = class("Season123_1_9StoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0:buildScrollViews()

	slot1 = {}

	table.insert(slot1, slot0.scrollView)
	table.insert(slot1, Season123_1_9StoreView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, TabViewGroup.New(2, "#go_righttop"))

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

	if slot1 == 2 then
		slot4 = CurrencyView.New({
			Season123Config.instance:getSeasonConstNum(Season123Model.instance:getCurSeasonId(), Activity123Enum.Const.StoreCoinId)
		})
		slot4.foreHideBtn = true

		return {
			slot4
		}
	end
end

function slot0.buildScrollViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "mask/#scroll_store"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season123_1_9StoreItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 356
	slot1.cellHeight = 376
	slot1.cellSpaceH = 4.26
	slot1.cellSpaceV = 15.73
	slot1.startSpace = 39
	slot1.frameUpdateMs = 100
	slot0.scrollView = LuaListScrollView.New(Season123StoreModel.instance, slot1)
end

return slot0
