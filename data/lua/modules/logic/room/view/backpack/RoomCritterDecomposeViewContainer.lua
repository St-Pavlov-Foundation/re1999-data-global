module("modules.logic.room.view.backpack.RoomCritterDecomposeViewContainer", package.seeall)

slot0 = class("RoomCritterDecomposeViewContainer", BaseViewContainer)
slot1 = 4
slot2 = 0.03

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "left_container/#go_scrollcontainer/#scroll_critter"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "left_container/#go_scrollcontainer/#scroll_critter/Viewport/Content/#go_critterItem"
	slot2.cellClass = RoomCritterDecomposeItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = slot0:getLineCount()
	slot2.cellWidth = 200
	slot2.cellHeight = 200
	slot2.frameUpdateMs = 0
	slot2.minUpdateCountInFrame = slot2.lineCount

	table.insert(slot1, LuaListScrollViewWithAnimator.New(RoomCritterDecomposeListModel.instance, slot2, slot0.getDelayTimeArray(slot2.lineCount)))
	table.insert(slot1, RoomCritterDecomposeView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttopbtns"))

	return slot1
end

function slot0.getLineCount(slot0)
	return math.floor(recthelper.getWidth(gohelper.findChildComponent(slot0.viewGO, "left_container/#go_scrollcontainer", gohelper.Type_Transform)) / 200)
end

function slot0.getDelayTimeArray(slot0)
	slot1 = {}

	setmetatable(slot1, slot1)

	function slot1.__index(slot0, slot1)
		if uv1 < math.floor((slot1 - 1) / uv0) then
			return
		end

		return slot2 * uv2
	end

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
	end
end

function slot0.playCloseTransition(slot0)
	slot0:onPlayCloseTransitionFinish()
end

function slot0.onContainerCloseFinish(slot0)
	RoomCritterDecomposeListModel.instance:onInit()
end

return slot0
