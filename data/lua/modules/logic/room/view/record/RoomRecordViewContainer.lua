module("modules.logic.room.view.record.RoomRecordViewContainer", package.seeall)

slot0 = class("RoomRecordViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomRecordView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, TabViewGroup.New(2, "root/view"))

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
		slot2 = ListScrollParam.New()
		slot2.scrollGOPath = "left/#scroll_view"
		slot2.prefabType = ScrollEnum.ScrollPrefabFromView
		slot2.prefabUrl = "left/#scroll_view/Viewport/Content/item"
		slot2.cellClass = RoomCritterHandBookItem
		slot2.scrollDir = ScrollEnum.ScrollDirV
		slot2.cellWidth = 240
		slot2.cellHeight = 300
		slot2.startSpace = 10
		slot2.cellSpaceH = 10
		slot2.lineCount = 3
		slot3 = ListScrollParam.New()
		slot3.scrollGOPath = "left/#scroll_view"
		slot3.prefabType = ScrollEnum.ScrollPrefabFromView
		slot3.prefabUrl = "bg/#scroll_view/Viewport/Content/item"
		slot3.cellClass = RoomCritterHandBookBackItem
		slot3.scrollDir = ScrollEnum.ScrollDirV
		slot3.cellWidth = 100
		slot3.cellHeight = 100
		slot3.cellSpaceV = 20
		slot3.cellSpaceH = 20
		slot3.lineCount = 4
		slot0._taskView = RoomTradeTaskView.New()
		slot0._handbookScrollView = LuaListScrollView.New(RoomHandBookListModel.instance, slot2)
		slot0._handbookbackScrollView = LuaListScrollView.New(RoomHandBookBackListModel.instance, slot3)
		slot0._handbookView = RoomCritterHandBookView.New()
		slot0._logview = RoomLogView.New()
		slot0._handbookbackView = RoomCritterHandBookBackView.New()

		return {
			MultiView.New({
				slot0._taskView
			}),
			MultiView.New({
				slot0._logview
			}),
			MultiView.New({
				slot0._handbookView,
				slot0._handbookScrollView
			}),
			MultiView.New({
				slot0._handbookbackView,
				slot0._handbookbackScrollView
			})
		}
	end
end

function slot0.getTabView(slot0, slot1)
	if slot1 == RoomRecordEnum.View.Task then
		return slot0._taskView
	elseif slot1 == RoomRecordEnum.View.Log then
		return slot0._logview
	elseif slot1 == RoomRecordEnum.View.HandBook then
		return slot0._handbookView
	end
end

function slot0.selectTabView(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.getHandBookScrollView(slot0)
	return slot0._handbookScrollView
end

function slot0.playOpenTransition(slot0)
	if slot0.viewParam then
		slot0:selectTabView(slot0.viewParam)

		if slot0.viewParam == RoomRecordEnum.View.Log then
			SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play("to2", slot0.afterOpenAnim, slot0)
		elseif slot0.viewParam == RoomRecordEnum.View.HandBook then
			slot1:Play("to3", slot0.afterOpenAnim, slot0)
		end
	end
end

function slot0.afterOpenAnim(slot0)
end

return slot0
