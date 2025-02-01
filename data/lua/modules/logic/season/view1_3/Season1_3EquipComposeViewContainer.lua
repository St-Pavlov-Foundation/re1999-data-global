module("modules.logic.season.view1_3.Season1_3EquipComposeViewContainer", package.seeall)

slot0 = class("Season1_3EquipComposeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot2 = Season1_3EquipTagSelect.New()

	slot2:init(Activity104EquipComposeController.instance, "left/#drop_filter")

	return {
		Season1_3EquipComposeView.New(),
		slot2,
		LuaListScrollView.New(Activity104EquipItemComposeModel.instance, slot0:createEquipItemsParam()),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.createEquipItemsParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "left/mask/#scroll_cardlist"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season1_3EquipComposeItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = Season1_3EquipComposeItem.ColumnCount
	slot1.cellWidth = 170
	slot1.cellHeight = 235
	slot1.cellSpaceH = 8.48
	slot1.cellSpaceV = 1
	slot1.frameUpdateMs = 100
	slot1.minUpdateCountInFrame = Season1_3EquipComposeItem.ColumnCount

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
