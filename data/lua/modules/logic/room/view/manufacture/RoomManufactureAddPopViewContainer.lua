module("modules.logic.room.view.manufacture.RoomManufactureAddPopViewContainer", package.seeall)

slot0 = class("RoomManufactureAddPopViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = MixScrollParam.New()
	slot2.scrollGOPath = "root/#go_addPop/#scroll_production"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "root/#go_addPop/#scroll_production/viewport/content/#go_productionItem"
	slot2.cellClass = RoomManufactureFormulaItem
	slot2.scrollDir = ScrollEnum.ScrollDirV

	table.insert(slot1, LuaMixScrollView.New(ManufactureFormulaListModel.instance, slot2))

	slot0._popView = RoomManufactureAddPopView.New()

	table.insert(slot1, slot0._popView)

	return slot1
end

function slot0.playCloseTransition(slot0)
	slot0:startViewCloseBlock()
	slot0._popView.animatorPlayer:Play(UIAnimationName.Close, slot0.onPlayCloseTransitionFinish, slot0)
end

return slot0
