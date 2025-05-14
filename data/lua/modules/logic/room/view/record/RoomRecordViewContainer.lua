module("modules.logic.room.view.record.RoomRecordViewContainer", package.seeall)

local var_0_0 = class("RoomRecordViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomRecordView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "root/view"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	elseif arg_2_1 == 2 then
		local var_2_0 = ListScrollParam.New()

		var_2_0.scrollGOPath = "left/#scroll_view"
		var_2_0.prefabType = ScrollEnum.ScrollPrefabFromView
		var_2_0.prefabUrl = "left/#scroll_view/Viewport/Content/item"
		var_2_0.cellClass = RoomCritterHandBookItem
		var_2_0.scrollDir = ScrollEnum.ScrollDirV
		var_2_0.cellWidth = 240
		var_2_0.cellHeight = 300
		var_2_0.startSpace = 10
		var_2_0.cellSpaceH = 10
		var_2_0.lineCount = 3

		local var_2_1 = ListScrollParam.New()

		var_2_1.scrollGOPath = "left/#scroll_view"
		var_2_1.prefabType = ScrollEnum.ScrollPrefabFromView
		var_2_1.prefabUrl = "bg/#scroll_view/Viewport/Content/item"
		var_2_1.cellClass = RoomCritterHandBookBackItem
		var_2_1.scrollDir = ScrollEnum.ScrollDirV
		var_2_1.cellWidth = 100
		var_2_1.cellHeight = 100
		var_2_1.cellSpaceV = 20
		var_2_1.cellSpaceH = 20
		var_2_1.lineCount = 4
		arg_2_0._taskView = RoomTradeTaskView.New()
		arg_2_0._handbookScrollView = LuaListScrollView.New(RoomHandBookListModel.instance, var_2_0)
		arg_2_0._handbookbackScrollView = LuaListScrollView.New(RoomHandBookBackListModel.instance, var_2_1)
		arg_2_0._handbookView = RoomCritterHandBookView.New()
		arg_2_0._logview = RoomLogView.New()
		arg_2_0._handbookbackView = RoomCritterHandBookBackView.New()

		return {
			MultiView.New({
				arg_2_0._taskView
			}),
			MultiView.New({
				arg_2_0._logview
			}),
			MultiView.New({
				arg_2_0._handbookView,
				arg_2_0._handbookScrollView
			}),
			MultiView.New({
				arg_2_0._handbookbackView,
				arg_2_0._handbookbackScrollView
			})
		}
	end
end

function var_0_0.getTabView(arg_3_0, arg_3_1)
	if arg_3_1 == RoomRecordEnum.View.Task then
		return arg_3_0._taskView
	elseif arg_3_1 == RoomRecordEnum.View.Log then
		return arg_3_0._logview
	elseif arg_3_1 == RoomRecordEnum.View.HandBook then
		return arg_3_0._handbookView
	end
end

function var_0_0.selectTabView(arg_4_0, arg_4_1)
	arg_4_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_4_1)
end

function var_0_0.getHandBookScrollView(arg_5_0)
	return arg_5_0._handbookScrollView
end

function var_0_0.playOpenTransition(arg_6_0)
	local var_6_0 = SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO)

	if arg_6_0.viewParam then
		arg_6_0:selectTabView(arg_6_0.viewParam)

		if arg_6_0.viewParam == RoomRecordEnum.View.Log then
			local var_6_1 = "to2"

			var_6_0:Play(var_6_1, arg_6_0.afterOpenAnim, arg_6_0)
		elseif arg_6_0.viewParam == RoomRecordEnum.View.HandBook then
			local var_6_2 = "to3"

			var_6_0:Play(var_6_2, arg_6_0.afterOpenAnim, arg_6_0)
		end
	end
end

function var_0_0.afterOpenAnim(arg_7_0)
	return
end

return var_0_0
