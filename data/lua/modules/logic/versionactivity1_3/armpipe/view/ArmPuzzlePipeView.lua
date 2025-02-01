module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipeView", package.seeall)

slot0 = class("ArmPuzzlePipeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagepaperlower = gohelper.findChildSingleImage(slot0.viewGO, "Paper/#simage_PaperLower")
	slot0._simagephoto = gohelper.findChildSingleImage(slot0.viewGO, "Paper/#simage_Photo")
	slot0._simagepaperupper = gohelper.findChildSingleImage(slot0.viewGO, "Paper/#simage_PaperUpper")
	slot0._simagepaperupper3 = gohelper.findChildSingleImage(slot0.viewGO, "Paper/#simage_PaperUpper3")
	slot0._simagepaperupper4 = gohelper.findChildSingleImage(slot0.viewGO, "Paper/#simage_PaperUpper4")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gomap = gohelper.findChild(slot0.viewGO, "#go_map")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "#txt_Tips")
	slot0._goopMask = gohelper.findChild(slot0.viewGO, "#go_opMask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gofinish, false)
	gohelper.setActive(slot0._goopMask, false)
	slot0._simagepaperlower:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper2"))
	slot0._simagephoto:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzle_photo"))
	slot0._simagepaperupper:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper1"))
	slot0._simagepaperupper3:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper3"))
	slot0._simagepaperupper4:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_puzzlepaper4"))
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscape, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PipeGameClear, slot0._onGameClear, slot0)
	slot0:addEventCb(ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.ResetGameRefresh, slot0._onResetGame, slot0)
	slot0:_refreshUI()
end

function slot0._onResetGame(slot0)
	gohelper.setActive(slot0._gofinish, false)
end

function slot0._onGameClear(slot0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(slot0._gofinish, true)

	slot1 = ArmPuzzlePipeModel.instance:getEpisodeCo()

	if not Activity124Model.instance:isEpisodeClear(slot1.activityId, slot1.episodeId) then
		slot0._isFristClear = true
		slot0._fristClearEpisodeIdId = slot1.episodeId
		slot0._fristClearActivityId = slot1.activityId

		gohelper.setActive(slot0._goopMask, true)
		Activity124Rpc.instance:sendFinishAct124EpisodeRequest(slot1.activityId, slot1.episodeId)

		slot0._escapeUseTime = Time.time + ArmPuzzlePipeEnum.AnimatorTime.GameFinish + 0.3

		TaskDispatcher.runDelay(slot0._onRewardRequest, slot0, ArmPuzzlePipeEnum.AnimatorTime.GameFinish)
	end
end

function slot0._onRewardRequest(slot0)
	gohelper.setActive(slot0._goopMask, false)
	Activity124Rpc.instance:sendReceiveAct124RewardRequest(slot0._fristClearActivityId, slot0._fristClearEpisodeIdId)
end

function slot0._refreshUI(slot0)
	if ArmPuzzlePipeModel.instance:getEpisodeCo() then
		slot0._txtTips.text = Activity124Config.instance:getMapCo(slot1.activityId, slot1.mapId) and slot2.desc or ""
	end
end

function slot0.onClose(slot0)
	if slot0._isFristClear then
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.EpisodeFiexdAnim, slot0._fristClearEpisodeIdId)
	end
end

function slot0._onEscape(slot0)
	if slot0._escapeUseTime == nil or slot0._escapeUseTime < Time.time then
		Stat1_3Controller.instance:puzzleStatAbort()
		slot0:closeThis()
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagepaperlower:UnLoadImage()
	slot0._simagephoto:UnLoadImage()
	slot0._simagepaperupper:UnLoadImage()
	slot0._simagepaperupper3:UnLoadImage()
	slot0._simagepaperupper4:UnLoadImage()
	NavigateMgr.instance:removeEscape(slot0.viewName, slot0._onEscape, slot0)
end

return slot0
