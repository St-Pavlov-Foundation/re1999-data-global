module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessStoryViewContainer", package.seeall)

local var_0_0 = class("Activity1_3ChessStoryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_ChapterList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = Activity1_3ChessStoryViewItem.prefabPath
	var_1_1.cellClass = Activity1_3ChessStoryViewItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 500
	var_1_1.cellHeight = 720
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(Activity122StoryListModel.instance, var_1_1))
	table.insert(var_1_0, Activity1_3ChessStoryView.New())

	arg_1_0._storyReviewScene = Va3ChessStoryReviewScene.New()

	table.insert(var_1_0, arg_1_0._storyReviewScene)

	return var_1_0
end

function var_0_0.onContainerInit(arg_2_0)
	Activity1_3ChessController.instance:setReviewStory(true)
end

function var_0_0.onContainerClose(arg_3_0)
	Activity1_3ChessController.instance:setReviewStory(false)
end

function var_0_0.onContainerClickModalMask(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_4_0:closeThis()
end

function var_0_0.buildTabViews(arg_5_0, arg_5_1)
	if arg_5_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function var_0_0._setVisible(arg_6_0, arg_6_1)
	var_0_0.super._setVisible(arg_6_0, arg_6_1)

	if arg_6_0._storyReviewScene and arg_6_0._storyReviewSceneVisible ~= arg_6_1 then
		arg_6_0._storyReviewSceneVisible = arg_6_1

		if arg_6_1 then
			arg_6_0._storyReviewScene:resetOpenAnim()
		end
	end
end

return var_0_0
