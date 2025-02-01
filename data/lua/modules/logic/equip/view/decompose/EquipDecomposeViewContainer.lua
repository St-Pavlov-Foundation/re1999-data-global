module("modules.logic.equip.view.decompose.EquipDecomposeViewContainer", package.seeall)

slot0 = class("EquipDecomposeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "left_container/#go_scrollcontainer/#scroll_equip"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = EquipDecomposeScrollItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = slot0:getLineCount()
	slot1.cellWidth = 200
	slot1.cellHeight = 200
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.frameUpdateMs = 0
	slot1.minUpdateCountInFrame = slot1.lineCount

	return {
		EquipDecomposeView.New(),
		LuaListScrollViewWithAnimator.New(EquipDecomposeListModel.instance, slot1, slot0.getDelayTimeArray(slot1.lineCount)),
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function slot0.getDelayTimeArray(slot0)
	slot1 = {}

	setmetatable(slot1, slot1)

	function slot1.__index(slot0, slot1)
		if math.floor((slot1 - 1) / uv0) > 4 then
			return nil
		end

		return slot2 * 0.03
	end

	return slot1
end

function slot0.getLineCount(slot0)
	return math.floor(recthelper.getWidth(gohelper.findChildComponent(slot0.viewGO, "left_container/#go_scrollcontainer", gohelper.Type_Transform)) / 200)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

function slot0.playCloseTransition(slot0)
	slot0:onPlayCloseTransitionFinish()
end

function slot0.onContainerCloseFinish(slot0)
	EquipDecomposeListModel.instance:clear()
end

return slot0
