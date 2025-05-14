module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleViewContainer", package.seeall)

local var_0_0 = class("Role37PuzzleViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Record/#scroll_record"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "Record/#scroll_record/Viewport/Content/RecordItem"
	var_1_1.cellClass = PuzzleRecordItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV

	table.insert(var_1_0, Role37PuzzleView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0.overrideCloseFunc, arg_2_0)
		arg_2_0._navigateButtonView:setHelpId(HelpEnum.HelpId.Role37PuzzleViewHelp)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.overrideCloseFunc(arg_3_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, arg_3_0.closeFunc, nil, nil, arg_3_0)
end

function var_0_0.closeFunc(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onContainerInit(arg_5_0)
	Activity130Rpc.instance:addGameChallengeNum(Activity130Model.instance:getCurEpisodeId())
end

return var_0_0
