module("modules.logic.seasonver.act123.view1_8.Season123_1_8EquipBookViewContainer", package.seeall)

slot0 = class("Season123_1_8EquipBookViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0:createEquipItemsParam()

	slot1 = Season123_1_8EquipFloatTouch.New()

	slot1:init("left/#go_target/#go_ctrl", "left/#go_target/#go_touch")

	slot2 = Season123_1_8EquipTagSelect.New()

	slot2:init(Season123EquipBookController.instance, "right/#drop_filter")

	return {
		Season123_1_8EquipBookView.New(),
		slot1,
		slot2,
		slot0.scrollView,
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "right/#go_righttop")
	}
end

function slot0.createEquipItemsParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "right/mask/#scroll_cardlist"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season123_1_8EquipBookItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = Season123_1_8EquipBookItem.ColumnCount
	slot1.cellWidth = 170
	slot1.cellHeight = 235
	slot1.cellSpaceH = 8.2
	slot1.cellSpaceV = 1.74
	slot1.frameUpdateMs = 100
	slot1.minUpdateCountInFrame = Season123_1_8EquipBookItem.ColumnCount
	slot0.scrollView = LuaListScrollView.New(Season123EquipBookModel.instance, slot1)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end

	if slot1 == 2 then
		slot3 = CurrencyView.New({
			Season123Config.instance:getEquipItemCoin(Season123Model.instance:getCurSeasonId(), Activity123Enum.Const.EquipItemCoin)
		})
		slot3.foreHideBtn = true

		return {
			slot3
		}
	end
end

function slot0.playCloseTransition(slot0)
	ZProj.ProjAnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Close, slot0.onCloseAnimDone, slot0)
end

function slot0.onCloseAnimDone(slot0)
	slot0:onPlayCloseTransitionFinish()
end

return slot0
