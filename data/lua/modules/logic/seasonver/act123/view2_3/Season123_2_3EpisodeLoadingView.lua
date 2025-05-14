module("modules.logic.seasonver.act123.view2_3.Season123_2_3EpisodeLoadingView", package.seeall)

local var_0_0 = class("Season123_2_3EpisodeLoadingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gostageitem = gohelper.findChild(arg_1_0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")
	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._btnskipAnim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skipAnim")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskipAnim:AddClickListener(arg_2_0._btnSkilAnimOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskipAnim:RemoveClickListener()
end

function var_0_0._btnSkilAnimOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._btnskipAnim.gameObject, false)
	arg_4_0._viewAnim:Play("season123episodeloadingview_open", 0, 0.7)
	TaskDispatcher.cancelTask(arg_4_0.handleDelayAnimTransition, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0.handleDelayAnimTransition, arg_4_0, 0.2)

	if arg_4_0.audioId then
		AudioMgr.instance:stopPlayingID(arg_4_0.audioId)

		arg_4_0.audioId = nil
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._stageItems = {}
end

function var_0_0.onDestroyView(arg_6_0)
	if arg_6_0._stageItems then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._stageItems) do
			iter_6_1.simagechaptericon:UnLoadImage()
		end

		arg_6_0._stageItems = nil
	end

	Season123EpisodeLoadingController.instance:onCloseView()
	TaskDispatcher.cancelTask(arg_6_0.closeThis, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.handleDelayAnimTransition, arg_6_0)
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.actId
	local var_7_1 = arg_7_0.viewParam.stage
	local var_7_2 = arg_7_0.viewParam.layer

	logNormal(string.format("Season123_2_3EpisodeLoadingView actId=%s, stage=%s", var_7_0, var_7_1))
	Season123EpisodeLoadingController.instance:onOpenView(var_7_0, var_7_1, var_7_2)

	arg_7_0.audioId = AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_film_slide)

	arg_7_0:refreshUI()
	TaskDispatcher.runDelay(arg_7_0.handleDelayAnimTransition, arg_7_0, 3)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshStageList()
end

function var_0_0.refreshStageList(arg_10_0)
	local var_10_0 = Season123EpisodeLoadingModel.instance:getList()
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_2 = arg_10_0:getOrCreateStageItem(iter_10_0)

		arg_10_0:refreshSingleItem(iter_10_0, var_10_2, iter_10_1)

		var_10_1[var_10_2] = true
	end

	for iter_10_2, iter_10_3 in pairs(arg_10_0._stageItems) do
		gohelper.setActive(iter_10_3.go, var_10_1[iter_10_3])
	end
end

function var_0_0.getOrCreateStageItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._stageItems[arg_11_1]

	if not var_11_0 then
		local var_11_1 = gohelper.cloneInPlace(arg_11_0._gostageitem, "stage_item")

		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.go = var_11_1
		var_11_0.txtName = gohelper.findChildText(var_11_1, "#txt_name")
		var_11_0.imageicon = gohelper.findChildImage(var_11_1, "#simage_chapterIcon")
		var_11_0.simagechaptericon = gohelper.findChildSingleImage(var_11_1, "#simage_chapterIcon")
		var_11_0.gofinish = gohelper.findChild(var_11_1, "#go_done")
		var_11_0.gounfinish = gohelper.findChild(var_11_1, "#go_unfinished")
		var_11_0.txtPassRound = gohelper.findChildText(var_11_1, "#go_done/#txt_num")
		var_11_0.golock = gohelper.findChild(var_11_1, "#go_locked")
		var_11_0.gounlocklight = gohelper.findChild(var_11_1, "#go_chpt/light")
		var_11_0.goEnemyList = gohelper.findChild(var_11_1, "enemyList")
		var_11_0.goEnemyItem = gohelper.findChild(var_11_1, "enemyList/#go_enemyteam/enemyList/go_enemyitem")
		var_11_0.txtchapter = gohelper.findChildText(var_11_1, "#go_chpt/#txt_chpt")
		var_11_0.goselected = gohelper.findChild(var_11_1, "selectframe")

		gohelper.setActive(var_11_0.go, true)

		arg_11_0._stageItems[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.refreshSingleItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.emptyIndex then
		arg_12_2.txtchapter.text = ""
	else
		arg_12_2.txtchapter.text = string.format("%02d", arg_12_3.cfg.layer)

		local var_12_0 = Season123Model.instance:getSingleBgFolder()

		arg_12_2.simagechaptericon:LoadImage(ResUrl.getSeason123EpisodeIcon(var_12_0, arg_12_3.cfg.stagePicture))
	end

	arg_12_0:refreshSingleItemLock(arg_12_1, arg_12_2, arg_12_3)
	arg_12_0:refreshSingleItemFinished(arg_12_1, arg_12_2, arg_12_3)

	if arg_12_3.emptyIndex then
		UISpriteSetMgr.instance:setSeason123Sprite(arg_12_2.imageicon, Season123ProgressUtils.getEmptyLayerName(arg_12_3.emptyIndex))
	end
end

function var_0_0.refreshSingleItemLock(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3.emptyIndex then
		gohelper.setActive(arg_13_2.golock, false)
	else
		local var_13_0 = not Season123EpisodeLoadingModel.instance:isEpisodeUnlock(arg_13_3.cfg.layer)

		gohelper.setActive(arg_13_2.golock, var_13_0)
		gohelper.setActive(arg_13_2.gounlocklight, not arg_13_2.gounlocklight)

		local var_13_1 = var_13_0 and "#FFFFFF" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(arg_13_2.txtchapter, var_13_1)
	end
end

function var_0_0.refreshSingleItemFinished(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_3.emptyIndex then
		gohelper.setActive(arg_14_2.gofinish, false)
		gohelper.setActive(arg_14_2.txtPassRound, false)
		gohelper.setActive(arg_14_2.gounfinish, false)

		arg_14_2.txtPassRound.text = ""
	else
		local var_14_0 = arg_14_3.isFinished

		gohelper.setActive(arg_14_2.gofinish, var_14_0)
		gohelper.setActive(arg_14_2.txtPassRound, var_14_0)

		local var_14_1 = not Season123EpisodeLoadingModel.instance:isEpisodeUnlock(arg_14_3.cfg.layer)

		gohelper.setActive(arg_14_2.gounfinish, not var_14_0 and not var_14_1)

		if var_14_0 then
			arg_14_2.txtPassRound.text = tostring(arg_14_3.round)
		end
	end
end

function var_0_0.handleDelayAnimTransition(arg_15_0)
	Season123EpisodeLoadingController.instance:openEpisodeDetailView()
	TaskDispatcher.runDelay(arg_15_0.closeThis, arg_15_0, 1.5)
end

return var_0_0
