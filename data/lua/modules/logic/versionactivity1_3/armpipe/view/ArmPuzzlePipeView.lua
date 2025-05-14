module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipeView", package.seeall)

local var_0_0 = class("ArmPuzzlePipeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagepaperlower = gohelper.findChildSingleImage(arg_1_0.viewGO, "Paper/#simage_PaperLower")
	arg_1_0._simagephoto = gohelper.findChildSingleImage(arg_1_0.viewGO, "Paper/#simage_Photo")
	arg_1_0._simagepaperupper = gohelper.findChildSingleImage(arg_1_0.viewGO, "Paper/#simage_PaperUpper")
	arg_1_0._simagepaperupper3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Paper/#simage_PaperUpper3")
	arg_1_0._simagepaperupper4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Paper/#simage_PaperUpper4")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#txt_Tips")
	arg_1_0._goopMask = gohelper.findChild(arg_1_0.viewGO, "#go_opMask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gofinish, false)
	gohelper.setActive(arg_4_0._goopMask, false)
	arg_4_0._simagepaperlower:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper2"))
	arg_4_0._simagephoto:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzle_photo"))
	arg_4_0._simagepaperupper:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper1"))
	arg_4_0._simagepaperupper3:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper3"))
	arg_4_0._simagepaperupper4:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper4"))
	NavigateMgr.instance:addEscape(arg_4_0.viewName, arg_4_0._onEscape, arg_4_0)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PipeGameClear, arg_6_0._onGameClear, arg_6_0)
	arg_6_0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.ResetGameRefresh, arg_6_0._onResetGame, arg_6_0)
	arg_6_0:_refreshUI()
end

function var_0_0._onResetGame(arg_7_0)
	gohelper.setActive(arg_7_0._gofinish, false)
end

function var_0_0._onGameClear(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(arg_8_0._gofinish, true)

	local var_8_0 = ArmPuzzlePipeModel.instance:getEpisodeCo()

	if not Activity124Model.instance:isEpisodeClear(var_8_0.activityId, var_8_0.episodeId) then
		arg_8_0._isFristClear = true
		arg_8_0._fristClearEpisodeIdId = var_8_0.episodeId
		arg_8_0._fristClearActivityId = var_8_0.activityId

		gohelper.setActive(arg_8_0._goopMask, true)
		Activity124Rpc.instance:sendFinishAct124EpisodeRequest(var_8_0.activityId, var_8_0.episodeId)

		arg_8_0._escapeUseTime = Time.time + ArmPuzzlePipeEnum.AnimatorTime.GameFinish + 0.3

		TaskDispatcher.runDelay(arg_8_0._onRewardRequest, arg_8_0, ArmPuzzlePipeEnum.AnimatorTime.GameFinish)
	end
end

function var_0_0._onRewardRequest(arg_9_0)
	gohelper.setActive(arg_9_0._goopMask, false)
	Activity124Rpc.instance:sendReceiveAct124RewardRequest(arg_9_0._fristClearActivityId, arg_9_0._fristClearEpisodeIdId)
end

function var_0_0._refreshUI(arg_10_0)
	local var_10_0 = ArmPuzzlePipeModel.instance:getEpisodeCo()

	if var_10_0 then
		local var_10_1 = Activity124Config.instance:getMapCo(var_10_0.activityId, var_10_0.mapId)

		arg_10_0._txtTips.text = var_10_1 and var_10_1.desc or ""
	end
end

function var_0_0.onClose(arg_11_0)
	if arg_11_0._isFristClear then
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.EpisodeFiexdAnim, arg_11_0._fristClearEpisodeIdId)
	end
end

function var_0_0._onEscape(arg_12_0)
	if arg_12_0._escapeUseTime == nil or arg_12_0._escapeUseTime < Time.time then
		Stat1_3Controller.instance:puzzleStatAbort()
		arg_12_0:closeThis()
	end
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simagepaperlower:UnLoadImage()
	arg_13_0._simagephoto:UnLoadImage()
	arg_13_0._simagepaperupper:UnLoadImage()
	arg_13_0._simagepaperupper3:UnLoadImage()
	arg_13_0._simagepaperupper4:UnLoadImage()
	NavigateMgr.instance:removeEscape(arg_13_0.viewName, arg_13_0._onEscape, arg_13_0)
end

return var_0_0
