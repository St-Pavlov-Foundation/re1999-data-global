module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaStoryViewContainer", package.seeall)

local var_0_0 = class("JiaLaBoNaStoryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_ChapterList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = JiaLaBoNaStoryViewItem.prefabPath
	var_1_1.cellClass = JiaLaBoNaStoryViewItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 500
	var_1_1.cellHeight = 720
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(JiaLaBoNaStoryListModel.instance, var_1_1))
	table.insert(var_1_0, JiaLaBoNaStoryView.New())

	arg_1_0._storyReviewScene = Va3ChessStoryReviewScene.New()

	table.insert(var_1_0, arg_1_0._storyReviewScene)

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function var_0_0._setVisible(arg_4_0, arg_4_1)
	var_0_0.super._setVisible(arg_4_0, arg_4_1)

	if arg_4_0._storyReviewScene and arg_4_0._storyReviewSceneVisible ~= arg_4_1 then
		arg_4_0._storyReviewSceneVisible = arg_4_1

		if arg_4_1 then
			arg_4_0._storyReviewScene:resetOpenAnim()
		end
	end
end

return var_0_0
