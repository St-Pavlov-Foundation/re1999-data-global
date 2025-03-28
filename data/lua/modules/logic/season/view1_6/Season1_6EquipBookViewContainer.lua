module("modules.logic.season.view1_6.Season1_6EquipBookViewContainer", package.seeall)

slot0 = class("Season1_6EquipBookViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot2 = Season1_6EquipFloatTouch.New()

	slot2:init("left/#go_target/#go_ctrl", "left/#go_target/#go_touch")

	slot3 = Season1_6EquipTagSelect.New()

	slot3:init(Activity104EquipBookController.instance, "right/#drop_filter")

	return {
		Season1_6EquipBookView.New(),
		slot2,
		slot3,
		LuaListScrollView.New(Activity104EquipItemBookModel.instance, slot0:createEquipItemsParam()),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.createEquipItemsParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "right/mask/#scroll_cardlist"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season1_6EquipBookItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = Season1_6EquipBookItem.ColumnCount
	slot1.cellWidth = 170
	slot1.cellHeight = 235
	slot1.cellSpaceH = 8.2
	slot1.cellSpaceV = 1.74
	slot1.frameUpdateMs = 100
	slot1.minUpdateCountInFrame = Season1_6EquipBookItem.ColumnCount

	return slot1
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
end

function slot0.playCloseTransition(slot0)
	slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("close", 0, 0)
	TaskDispatcher.runDelay(slot0.delayOnPlayCloseAnim, slot0, 0.2)
end

function slot0.delayOnPlayCloseAnim(slot0)
	slot0:onPlayCloseTransitionFinish()
end

return slot0
