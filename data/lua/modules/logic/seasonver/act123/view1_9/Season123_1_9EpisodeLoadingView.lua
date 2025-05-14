module("modules.logic.seasonver.act123.view1_9.Season123_1_9EpisodeLoadingView", package.seeall)

local var_0_0 = class("Season123_1_9EpisodeLoadingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gostageitem = gohelper.findChild(arg_1_0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")

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
	arg_4_0._stageItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._stageItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._stageItems) do
			iter_5_1.simagechaptericon:UnLoadImage()
		end

		arg_5_0._stageItems = nil
	end

	Season123EpisodeLoadingController.instance:onCloseView()
	TaskDispatcher.cancelTask(arg_5_0.closeThis, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.handleDelayAnimTransition, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.actId
	local var_6_1 = arg_6_0.viewParam.stage
	local var_6_2 = arg_6_0.viewParam.layer

	logNormal(string.format("Season123_1_9EpisodeLoadingView actId=%s, stage=%s", var_6_0, var_6_1))
	Season123EpisodeLoadingController.instance:onOpenView(var_6_0, var_6_1, var_6_2)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_film_slide)
	arg_6_0:refreshUI()
	TaskDispatcher.runDelay(arg_6_0.handleDelayAnimTransition, arg_6_0, 3)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshStageList()
end

function var_0_0.refreshStageList(arg_9_0)
	local var_9_0 = Season123EpisodeLoadingModel.instance:getList()
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_2 = arg_9_0:getOrCreateStageItem(iter_9_0)

		arg_9_0:refreshSingleItem(iter_9_0, var_9_2, iter_9_1)

		var_9_1[var_9_2] = true
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0._stageItems) do
		gohelper.setActive(iter_9_3.go, var_9_1[iter_9_3])
	end
end

function var_0_0.getOrCreateStageItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._stageItems[arg_10_1]

	if not var_10_0 then
		local var_10_1 = gohelper.cloneInPlace(arg_10_0._gostageitem, "stage_item")

		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.go = var_10_1
		var_10_0.txtName = gohelper.findChildText(var_10_1, "#txt_name")
		var_10_0.imageicon = gohelper.findChildImage(var_10_1, "#simage_chapterIcon")
		var_10_0.simagechaptericon = gohelper.findChildSingleImage(var_10_1, "#simage_chapterIcon")
		var_10_0.gofinish = gohelper.findChild(var_10_1, "#go_done")
		var_10_0.gounfinish = gohelper.findChild(var_10_1, "#go_unfinished")
		var_10_0.txtPassRound = gohelper.findChildText(var_10_1, "#go_done/#txt_num")
		var_10_0.golock = gohelper.findChild(var_10_1, "#go_locked")
		var_10_0.gounlocklight = gohelper.findChild(var_10_1, "#go_chpt/light")
		var_10_0.goEnemyList = gohelper.findChild(var_10_1, "enemyList")
		var_10_0.goEnemyItem = gohelper.findChild(var_10_1, "enemyList/#go_enemyteam/enemyList/go_enemyitem")
		var_10_0.txtchapter = gohelper.findChildText(var_10_1, "#go_chpt/#txt_chpt")
		var_10_0.goselected = gohelper.findChild(var_10_1, "selectframe")

		gohelper.setActive(var_10_0.go, true)

		arg_10_0._stageItems[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0.refreshSingleItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3.emptyIndex then
		arg_11_2.txtchapter.text = ""
	else
		arg_11_2.txtchapter.text = string.format("%02d", arg_11_3.cfg.layer)

		local var_11_0 = Season123Model.instance:getSingleBgFolder()

		arg_11_2.simagechaptericon:LoadImage(ResUrl.getSeason123EpisodeIcon(var_11_0, arg_11_3.cfg.stagePicture))
	end

	arg_11_0:refreshSingleItemLock(arg_11_1, arg_11_2, arg_11_3)
	arg_11_0:refreshSingleItemFinished(arg_11_1, arg_11_2, arg_11_3)

	if arg_11_3.emptyIndex then
		UISpriteSetMgr.instance:setSeason123Sprite(arg_11_2.imageicon, Season123ProgressUtils.getEmptyLayerName(arg_11_3.emptyIndex))
	end
end

function var_0_0.refreshSingleItemLock(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.emptyIndex then
		gohelper.setActive(arg_12_2.golock, false)
	else
		local var_12_0 = not Season123EpisodeLoadingModel.instance:isEpisodeUnlock(arg_12_3.cfg.layer)

		gohelper.setActive(arg_12_2.golock, var_12_0)
		gohelper.setActive(arg_12_2.gounlocklight, not arg_12_2.gounlocklight)

		local var_12_1 = var_12_0 and "#FFFFFF" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(arg_12_2.txtchapter, var_12_1)
	end
end

function var_0_0.refreshSingleItemFinished(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3.emptyIndex then
		gohelper.setActive(arg_13_2.gofinish, false)
		gohelper.setActive(arg_13_2.txtPassRound, false)
		gohelper.setActive(arg_13_2.gounfinish, false)

		arg_13_2.txtPassRound.text = ""
	else
		local var_13_0 = arg_13_3.isFinished

		gohelper.setActive(arg_13_2.gofinish, var_13_0)
		gohelper.setActive(arg_13_2.txtPassRound, var_13_0)

		local var_13_1 = not Season123EpisodeLoadingModel.instance:isEpisodeUnlock(arg_13_3.cfg.layer)

		gohelper.setActive(arg_13_2.gounfinish, not var_13_0 and not var_13_1)

		if var_13_0 then
			arg_13_2.txtPassRound.text = tostring(arg_13_3.round)
		end
	end
end

function var_0_0.handleDelayAnimTransition(arg_14_0)
	Season123EpisodeLoadingController.instance:openEpisodeDetailView()
	TaskDispatcher.runDelay(arg_14_0.closeThis, arg_14_0, 1.5)
end

return var_0_0
