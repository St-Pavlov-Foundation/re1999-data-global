module("modules.logic.playercard.view.PlayerCardProgressViewContainer", package.seeall)

local var_0_0 = class("PlayerCardProgressViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, PlayerCardProgressView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_progress"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#scroll_progress/Viewport/Content/#go_progressitem"
	var_1_1.cellClass = PlayerCardProgressItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 2
	var_1_1.cellWidth = 260
	var_1_1.cellHeight = 224
	var_1_1.cellSpaceH = 11
	var_1_1.cellSpaceV = 11
	arg_1_0._scrollView = LuaListScrollView.New(PlayerCardProgressModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0._scrollView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._overrideClose(arg_3_0)
	arg_3_0:checkCloseFunc()
end

function var_0_0.checkCloseFunc(arg_4_0)
	if PlayerCardProgressModel.instance:checkDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, var_0_0.yesCallback, var_0_0.cancel)
	else
		arg_4_0:closeFunc()
	end
end

function var_0_0.yesCallback()
	PlayerCardProgressModel.instance:confirmData()
	ViewMgr.instance:closeView(ViewName.PlayerCardProgressView, nil, true)
end

function var_0_0.cancel()
	PlayerCardProgressModel.instance:reselectData()
	ViewMgr.instance:closeView(ViewName.PlayerCardProgressView, nil, true)
end

function var_0_0.closeFunc(arg_7_0)
	ViewMgr.instance:closeView(ViewName.PlayerCardProgressView, nil, true)
end

return var_0_0
