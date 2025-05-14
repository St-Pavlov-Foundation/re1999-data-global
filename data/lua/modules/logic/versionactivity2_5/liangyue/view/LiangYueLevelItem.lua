module("modules.logic.versionactivity2_5.liangyue.view.LiangYueLevelItem", package.seeall)

local var_0_0 = class("LiangYueLevelItem", LuaCompBase)

function var_0_0.onInit(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goGet = gohelper.findChild(arg_1_0._go, "unlock/#go_afterPuzzleEpisode/#go_Get")
	arg_1_0._gostagenormal = gohelper.findChild(arg_1_0._go, "unlock/#go_stagenormal")
	arg_1_0._gostagefinished = gohelper.findChild(arg_1_0._go, "unlock/#go_stagefinished")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0._go, "unlock/#btn_click")
	arg_1_0._gostagelock = gohelper.findChild(arg_1_0._go, "unlock/#go_stagelock")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0._go, "unlock/#txt_stagename")
	arg_1_0._txtstageNum = gohelper.findChildText(arg_1_0._go, "unlock/#txt_stageNum")
	arg_1_0._goAfterPuzzleItem = gohelper.findChild(arg_1_0._go, "unlock/#go_afterPuzzleEpisode")
	arg_1_0._btnAfterPuzzle = gohelper.findChildButton(arg_1_0._go, "unlock/#go_afterPuzzleEpisode/#btn_puzzle")
	arg_1_0._goStarFinish1 = gohelper.findChild(arg_1_0._go, "unlock/star1/#go_star")
	arg_1_0._goStarFinish2 = gohelper.findChild(arg_1_0._go, "unlock/star2/#go_star")
	arg_1_0._episodeAnim = gohelper.findChildAnim(arg_1_0._go, "")
	arg_1_0._episodeGameAnim = gohelper.findChildAnim(arg_1_0._go, "unlock/#go_afterPuzzleEpisode")
	arg_1_0._episodeGameFinishAnim = gohelper.findChildAnim(arg_1_0._go, "unlock/#go_afterPuzzleEpisode/#go_Get/go_hasget")
end

function var_0_0.setInfo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.index = arg_2_1
	arg_2_0.actId = arg_2_2.activityId
	arg_2_0.episodeId = arg_2_2.episodeId
	arg_2_0.config = arg_2_2
	arg_2_0.preEpisodeId = arg_2_2.preEpisodeId
	arg_2_0.gameEpisodeId = LiangYueConfig.instance:getAfterGameEpisodeId(arg_2_0.actId, arg_2_2.episodeId)

	arg_2_0:refreshUI()
	arg_2_0:refreshStoryState(true)
	arg_2_0:refreshGameState(true)
end

function var_0_0.refreshUI(arg_3_0)
	local var_3_0 = arg_3_0.config
	local var_3_1 = arg_3_0.actId

	arg_3_0._txtstagename.text = var_3_0.name
	arg_3_0._txtstageNum.text = string.format("0%s", arg_3_0.index)
	arg_3_0.isPreFinish, arg_3_0.isFinish = var_3_0.preEpisodeId == 0 or LiangYueModel.instance:isEpisodeFinish(var_3_1, var_3_0.preEpisodeId), LiangYueModel.instance:isEpisodeFinish(var_3_1, var_3_0.episodeId)
end

function var_0_0.refreshStoryState(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.isFinish
	local var_4_1 = arg_4_0.isPreFinish

	gohelper.setActive(arg_4_0._gostagelock, not var_4_1)
	gohelper.setActive(arg_4_0._gostagenormal, var_4_1 and not var_4_0)
	gohelper.setActive(arg_4_0._gostagefinished, var_4_0)
	gohelper.setActive(arg_4_0._goStarFinish1, var_4_0)
	gohelper.setActive(arg_4_0._goStarFinish2, var_4_0)

	if not arg_4_1 then
		return
	end

	local var_4_2 = 1

	if var_4_0 then
		arg_4_0:playEpisodeAnim(LiangYueEnum.EpisodeAnim.FinishIdle, var_4_2)
	elseif var_4_1 then
		arg_4_0:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Unlock, var_4_2)
	else
		arg_4_0:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Empty, var_4_2)
	end
end

function var_0_0.setLockState(arg_5_0)
	gohelper.setActive(arg_5_0._gostagelock, true)
	gohelper.setActive(arg_5_0._gostagenormal, false)
	gohelper.setActive(arg_5_0._gostagefinished, false)
	gohelper.setActive(arg_5_0._goStarFinish1, false)
	gohelper.setActive(arg_5_0._goStarFinish2, false)
end

function var_0_0.refreshGameState(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.isFinish
	local var_6_1 = arg_6_0.gameEpisodeId ~= nil

	gohelper.setActive(arg_6_0._goAfterPuzzleItem, var_6_1 and var_6_0)

	local var_6_2 = LiangYueModel.instance:isEpisodeFinish(arg_6_0.actId, arg_6_0.gameEpisodeId)

	gohelper.setActive(arg_6_0._goGet, var_6_2)

	local var_6_3 = 1

	if not var_6_1 or not arg_6_1 then
		return
	end

	arg_6_0:playGameEpisodeRewardAnim(LiangYueEnum.EpisodeGameFinishAnim.Idle, var_6_3)

	if var_6_2 then
		arg_6_0:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.FinishIdle, var_6_3)
	elseif var_6_0 then
		arg_6_0:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.Open, var_6_3)
	else
		arg_6_0:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.Idle, var_6_3)
	end
end

function var_0_0.playGameEpisodeAnim(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._episodeGameAnim:Play(arg_7_1, 0, arg_7_2)
end

function var_0_0.playEpisodeAnim(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._episodeAnim:Play(arg_8_1, 0, arg_8_2)
end

function var_0_0.playGameEpisodeRewardAnim(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._episodeGameFinishAnim:Play(arg_9_1, 0, arg_9_2)
end

function var_0_0.addEventListeners(arg_10_0)
	arg_10_0._btnclick:AddClickListener(arg_10_0._btnclickOnClick, arg_10_0)
	arg_10_0._btnAfterPuzzle:AddClickListener(arg_10_0._btnafterPuzzleOnClick, arg_10_0)
end

function var_0_0.removeEventListeners(arg_11_0)
	arg_11_0._btnclick:RemoveClickListener()
	arg_11_0._btnAfterPuzzle:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_12_0)
	local var_12_0 = arg_12_0.actId
	local var_12_1 = ActivityModel.instance:getActMO(var_12_0)

	if var_12_1 == nil then
		logError("not such activity id: " .. var_12_0)

		return
	end

	if not var_12_1:isOpen() or var_12_1:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if arg_12_0.config.preEpisodeId ~= 0 and not LiangYueModel.instance:isEpisodeFinish(var_12_0, arg_12_0.config.preEpisodeId) then
		GameFacade.showToast(ToastEnum.Act184PuzzleNotOpen)

		return
	end

	local var_12_2 = arg_12_0.config.episodeId

	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnClickStoryItem, arg_12_0.index, var_12_2, false)
end

function var_0_0._btnafterPuzzleOnClick(arg_13_0)
	local var_13_0 = arg_13_0.actId
	local var_13_1 = ActivityModel.instance:getActMO(var_13_0)

	if var_13_1 == nil then
		logError("not such activity id: " .. var_13_0)

		return
	end

	if not var_13_1:isOpen() or var_13_1:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if not arg_13_0.gameEpisodeId then
		logError("have no gameEpisodeId")

		return
	end

	if not LiangYueModel.instance:isEpisodeFinish(var_13_0, arg_13_0.config.episodeId) then
		GameFacade.showToast(ToastEnum.Act184PuzzleNotOpen)

		return
	end

	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnClickStoryItem, arg_13_0.index, arg_13_0.gameEpisodeId, true)
end

function var_0_0.onDestroy(arg_14_0)
	return
end

return var_0_0
