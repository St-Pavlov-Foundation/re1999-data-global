module("modules.logic.teach.view.TeachNoteViewContainer", package.seeall)

local var_0_0 = class("TeachNoteViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_reward/#scroll_rewarditem"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = TeachNoteRewardListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 620
	var_1_1.cellHeight = 81
	var_1_1.cellSpaceH = 50
	var_1_1.cellSpaceV = 0
	var_1_1.minUpdateCountInFrame = 10

	table.insert(var_1_0, LuaListScrollView.New(TeachNoteRewardListModel.instance, var_1_1))
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))
	table.insert(var_1_0, TeachNoteView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigationView = NavigateButtonsView.New({
		true,
		false,
		true
	}, 116, arg_2_0._closeCallback, nil, nil, arg_2_0)

	return {
		arg_2_0.navigationView
	}
end

function var_0_0._closeCallback(arg_3_0)
	TeachNoteModel.instance:setJumpEpisodeId(nil)

	JumpModel.instance.jumpFromFightSceneParam = nil

	TeachNoteModel.instance:setJumpEnter(false)
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0.navigationView:resetOnCloseViewAudio(AudioEnum.TeachNote.play_ui_closehouse)
end

return var_0_0
