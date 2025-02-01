module("modules.logic.seasonver.act123.view2_0.Season123_2_0BatchDecomposeViewContainer", package.seeall)

slot0 = class("Season123_2_0BatchDecomposeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0:createEquipItemsParam()

	return {
		Season123_2_0BatchDecomposeView.New(),
		slot0.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function slot0.createEquipItemsParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "left_container/#go_scrollcontainer/#scroll_equip"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season123_2_0DecomposeItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = slot0:getLineCount()
	slot1.cellWidth = 170
	slot1.cellHeight = 235
	slot1.cellSpaceH = 8.48
	slot1.cellSpaceV = 1
	slot1.frameUpdateMs = 100
	slot1.minUpdateCountInFrame = SeasonEquipComposeItem.ColumnCount
	slot0.scrollView = LuaListScrollView.New(Season123DecomposeModel.instance, slot1)
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

function slot0.getLineCount(slot0)
	return math.floor(recthelper.getWidth(gohelper.findChildComponent(slot0.viewGO, "left_container/#go_scrollcontainer", gohelper.Type_Transform)) / 178.48)
end

function slot0.playCloseTransition(slot0)
	ZProj.ProjAnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Close, slot0.onCloseAnimDone, slot0)
end

function slot0.onCloseAnimDone(slot0)
	slot0:onPlayCloseTransitionFinish()
end

return slot0
