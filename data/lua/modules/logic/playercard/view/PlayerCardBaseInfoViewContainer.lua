module("modules.logic.playercard.view.PlayerCardBaseInfoViewContainer", package.seeall)

local var_0_0 = class("PlayerCardBaseInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, PlayerCardBaseInfoView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_base"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#scroll_base/Viewport/Content/#go_baseInfoitem"
	var_1_1.cellClass = PlayerCardBaseInfoItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 528
	var_1_1.cellHeight = 112
	var_1_1.cellSpaceV = 19
	arg_1_0._scrollView = LuaListScrollView.New(PlayerCardBaseInfoModel.instance, var_1_1)

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
	if not PlayerCardBaseInfoModel.instance:checkDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, var_0_0.yesCallback, var_0_0.cancel)
	else
		arg_4_0:closeFunc()
	end
end

function var_0_0.yesCallback()
	PlayerCardBaseInfoModel.instance:confirmData()
	ViewMgr.instance:closeView(ViewName.PlayerCardBaseInfoView, nil, true)
end

function var_0_0.cancel()
	PlayerCardBaseInfoModel.instance:reselectData()
	ViewMgr.instance:closeView(ViewName.PlayerCardBaseInfoView, nil, true)
end

function var_0_0.closeFunc(arg_7_0)
	ViewMgr.instance:closeView(ViewName.PlayerCardBaseInfoView, nil, true)
end

return var_0_0
