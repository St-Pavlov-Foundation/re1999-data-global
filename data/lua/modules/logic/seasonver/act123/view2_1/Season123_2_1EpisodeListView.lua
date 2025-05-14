module("modules.logic.seasonver.act123.view2_1.Season123_2_1EpisodeListView", package.seeall)

local var_0_0 = class("Season123_2_1EpisodeListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnheroes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_heroes")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._btndetails = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_details")
	arg_1_0._gostageitem = gohelper.findChild(arg_1_0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")
	arg_1_0._btntipreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_tipreward")
	arg_1_0._gorewardRedDot = gohelper.findChild(arg_1_0.viewGO, "#btn_tipreward/#go_rewardredpoint")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_rewards")
	arg_1_0._goscrollstory = gohelper.findChild(arg_1_0.viewGO, "#go_story/chapterlist/#scroll_chapter")
	arg_1_0._btnadditionruledetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_additionruletips/tips/#btn_additionruledetail")
	arg_1_0._goentranceitem = gohelper.findChild(arg_1_0.viewGO, "#go_entrance_item")
	arg_1_0._goframe = gohelper.findChild(arg_1_0.viewGO, "selectframe")
	arg_1_0._animTipReward = arg_1_0._btntipreward:GetComponent(gohelper.Type_Animation)
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnmask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "mask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnheroes:AddClickListener(arg_2_0._btnheroesOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btndetails:AddClickListener(arg_2_0._btndetailsOnClick, arg_2_0)
	arg_2_0._btntipreward:AddClickListener(arg_2_0._btntiprewardOnClick, arg_2_0)
	arg_2_0._btnadditionruledetail:AddClickListener(arg_2_0._btnadditionruleDetailOnClick, arg_2_0)
	arg_2_0._btnmask:AddClickListener(arg_2_0._btnMaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnheroes:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btndetails:RemoveClickListener()
	arg_3_0._btntipreward:RemoveClickListener()
	arg_3_0._btnadditionruledetail:RemoveClickListener()
	arg_3_0._btnmask:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._stageItems = {}
	arg_4_0._scrollCanvasGroup = gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.CanvasGroup))
	arg_4_0._scrollStory = gohelper.findChildScrollRect(arg_4_0._goscrollstory, "")
	arg_4_0._goScroll = gohelper.findChild(arg_4_0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content")
	arg_4_0._rectScroll = arg_4_0._goScroll.transform
	arg_4_0._heightScroll = recthelper.getHeight(arg_4_0._scrollStory.transform)
	arg_4_0._heightItem = recthelper.getHeight(arg_4_0._gostageitem.transform)
	arg_4_0._heightSpace = 24
	arg_4_0._goempty3 = gohelper.findChild(arg_4_0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty3")
	arg_4_0._goempty4 = gohelper.findChild(arg_4_0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty4")

	gohelper.setActive(arg_4_0._gorewards, false)
	gohelper.setActive(arg_4_0._goframe, false)
	TaskDispatcher.runDelay(arg_4_0.delayAddScrollAudio, arg_4_0, 0.6)
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._stageItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._stageItems) do
			iter_5_1.btnSelf:RemoveClickListener()
			iter_5_1.simagechaptericon:UnLoadImage()
		end

		arg_5_0._stageItems = nil
	end

	Season123EpisodeListController.instance:onCloseView()
	UIBlockMgr.instance:endBlock(var_0_0.SCROLL_ANIM_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)

	if arg_5_0._tweenIdScroll then
		ZProj.TweenHelper.KillById(arg_5_0._tweenIdScroll)

		arg_5_0._tweenIdScroll = nil
	end

	TaskDispatcher.cancelTask(arg_5_0.handlePlayScrollAnimCompleted, arg_5_0)

	if arg_5_0._centerItem then
		arg_5_0._centerItem:dispose()

		arg_5_0._centerItem = nil
	end

	if arg_5_0._drag then
		arg_5_0._drag:RemoveDragBeginListener()
		arg_5_0._drag:RemoveDragEndListener()

		arg_5_0._drag = nil
	end

	if arg_5_0._touch then
		arg_5_0._touch:RemoveClickDownListener()

		arg_5_0._touch = nil
	end

	TaskDispatcher.cancelTask(arg_5_0.delayAddScrollAudio, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.actId
	local var_6_1 = arg_6_0.viewParam.stage

	logNormal(string.format("episode actId=%s, stage=%s", var_6_0, var_6_1))
	Season123EpisodeListController.instance:onOpenView(var_6_0, var_6_1)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.GetActInfo, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.EpisodeViewRefresh, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.StageInfoChanged, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.TaskUpdated, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.ResetCloseEpisodeList, arg_6_0.closeThis, arg_6_0)
	arg_6_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_6_0.OnDotChange, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0.onCloseView, arg_6_0)

	local var_6_2 = ActivityModel.instance:getActMO(var_6_0)

	if not var_6_2 or not var_6_2:isOpen() or var_6_2:isExpired() then
		return
	end

	arg_6_0:initCenter()
	arg_6_0:refreshUI()

	local var_6_3 = Season123EpisodeListModel.instance:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_3) do
		if iter_6_1.id == Season123EpisodeListModel.instance:getCurrentChallengeLayer() then
			local var_6_4 = arg_6_0:getScrollToIndexY(iter_6_0)

			recthelper.setAnchorY(arg_6_0._rectScroll, var_6_4)
		end
	end

	Season123EpisodeListController.instance:processJumpParam(arg_6_0.viewParam)
	RedDotController.instance:addRedDot(arg_6_0._gorewardRedDot, RedDotEnum.DotNode.Season123StageReward, arg_6_0.viewParam.stage)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshStageList()
	arg_8_0:refreshCenter()

	local var_8_0 = Season123EpisodeListModel.instance:inCurrentStage() or Season123ProgressUtils.checkStageIsFinish(Season123EpisodeListModel.instance.activityId, Season123EpisodeListModel.instance.stage)

	gohelper.setActive(arg_8_0._btnreset, var_8_0)
end

function var_0_0.refreshStageList(arg_9_0)
	local var_9_0 = Season123EpisodeListModel.instance:getList()
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_2 = arg_9_0:getOrCreateLayerItem(iter_9_0)

		arg_9_0:refreshSingleItem(iter_9_0, var_9_2, iter_9_1)

		var_9_1[var_9_2] = true
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0._stageItems) do
		gohelper.setActive(iter_9_3.go, var_9_1[iter_9_3])
	end

	gohelper.setAsLastSibling(arg_9_0._goempty3)
	gohelper.setAsLastSibling(arg_9_0._goempty4)
end

function var_0_0.getOrCreateLayerItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._stageItems[arg_10_1]

	if not var_10_0 then
		local var_10_1 = gohelper.cloneInPlace(arg_10_0._gostageitem, "stage_item" .. arg_10_1)

		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.go = var_10_1
		var_10_0.txtName = gohelper.findChildText(var_10_1, "#txt_name")
		var_10_0.gofinish = gohelper.findChild(var_10_1, "#go_done")
		var_10_0.goUnfinish = gohelper.findChild(var_10_1, "#go_unfinished")
		var_10_0.txtPassRound = gohelper.findChildText(var_10_1, "#go_done/#txt_num")
		var_10_0.goMark = gohelper.findChild(var_10_1, "#go_mark")
		var_10_0.golock = gohelper.findChild(var_10_1, "#go_locked")
		var_10_0.simagechaptericon = gohelper.findChildSingleImage(var_10_1, "#simage_chapterIcon")
		var_10_0.goselected = gohelper.findChild(var_10_1, "selectframe")
		var_10_0.goEnemyList = gohelper.findChild(var_10_1, "enemyList")
		var_10_0.goEnemyItem = gohelper.findChild(var_10_1, "enemyList/#go_enemyteam/enemyList/go_enemyitem")
		var_10_0.txtchapter = gohelper.findChildText(var_10_1, "#go_chpt/#txt_chpt")
		var_10_0.btnSelf = gohelper.findChildButtonWithAudio(var_10_1, "#btn_self")

		var_10_0.btnSelf:AddClickListener(arg_10_0.onItemClick, arg_10_0, arg_10_1)
		gohelper.setActive(var_10_0.go, true)

		arg_10_0._stageItems[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0.refreshSingleItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_2.txtchapter.text = string.format("%02d", arg_11_3.cfg.layer)

	local var_11_0 = Season123Model.instance:getSingleBgFolder()

	if not string.nilorempty(var_11_0) then
		arg_11_2.simagechaptericon:LoadImage(ResUrl.getSeason123EpisodeIcon(var_11_0, arg_11_3.cfg.stagePicture))
	end

	arg_11_0:refreshSingleItemLock(arg_11_1, arg_11_2, arg_11_3)
	arg_11_0:refreshSingleItemFinished(arg_11_1, arg_11_2, arg_11_3)

	local var_11_1 = arg_11_3.cfg.layer == Season123EpisodeListModel.instance.curSelectLayer

	gohelper.setActive(arg_11_2.goselected, var_11_1)

	if var_11_1 then
		arg_11_0._gocurrentselected = arg_11_2.goselected
	end

	gohelper.setActive(arg_11_2.goMark, arg_11_3.cfg.displayMark == Activity123Enum.DisplayMark)
end

function var_0_0.refreshSingleItemLock(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = Season123EpisodeListModel.instance:isEpisodeUnlock(arg_12_3.cfg.layer)

	gohelper.setActive(arg_12_2.golock, not var_12_0)

	local var_12_1 = var_12_0 and "#FFFFFF" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(arg_12_2.txtchapter, var_12_1)
end

function var_0_0.refreshSingleItemFinished(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = Season123EpisodeListModel.instance:isEpisodeUnlock(arg_13_3.cfg.layer)
	local var_13_1 = arg_13_3.isFinished

	gohelper.setActive(arg_13_2.gofinish, var_13_1)
	gohelper.setActive(arg_13_2.txtPassRound, var_13_1)
	gohelper.setActive(arg_13_2.goUnfinish, not var_13_1 and var_13_0)

	if var_13_1 then
		local var_13_2 = Season123Controller.instance:isReduceRound(arg_13_0.viewParam.actId, arg_13_0.viewParam.stage, arg_13_3.cfg.layer) and "<color=#eecd8c>%s</color>" or "%s"

		arg_13_2.txtPassRound.text = string.format(var_13_2, tostring(arg_13_3.round))
	end
end

function var_0_0.refreshCenter(arg_14_0)
	if arg_14_0._centerItem then
		arg_14_0._centerItem:refreshUI()
	end
end

function var_0_0.initCenter(arg_15_0)
	arg_15_0._centerItem = Season123_2_1EpisodeListCenter.New()

	arg_15_0._centerItem:init(arg_15_0._goentranceitem)
	arg_15_0._centerItem:initData(arg_15_0.viewParam.actId, arg_15_0.viewParam.stage)
end

var_0_0.OutOfBoundOffset = 280
var_0_0.DelayEnterEpisodeTime = 0.2
var_0_0.SCROLL_ANIM_BLOCK_KEY = "Season123_2_1EpisodeListView_scrollanim"

function var_0_0.playScrollAnim(arg_16_0, arg_16_1)
	UIBlockMgr.instance:startBlock(var_0_0.SCROLL_ANIM_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(false)

	arg_16_0._scrollCanvasGroup.interactable = false
	arg_16_0._scrollCanvasGroup.blocksRaycasts = false
	arg_16_0._scrollStory.movementType = 0

	if arg_16_0._tweenIdScroll then
		ZProj.TweenHelper.KillById(arg_16_0._tweenIdScroll)
	end

	TaskDispatcher.cancelTask(arg_16_0.handlePlayScrollAnimCompleted, arg_16_0)

	local var_16_0 = arg_16_0:getScrollToIndexY(arg_16_1)
	local var_16_1 = recthelper.getAnchorY(arg_16_0._rectScroll) - var_16_0

	if var_16_1 > var_0_0.OutOfBoundOffset then
		arg_16_0._tweenIdScroll = ZProj.TweenHelper.DOAnchorPosY(arg_16_0._rectScroll, var_16_0 + var_0_0.OutOfBoundOffset, var_0_0.DelayEnterEpisodeTime, arg_16_0.handlePlayScrollAnimCompleted, arg_16_0)
	elseif var_16_1 < -var_0_0.OutOfBoundOffset then
		arg_16_0._tweenIdScroll = ZProj.TweenHelper.DOAnchorPosY(arg_16_0._rectScroll, var_16_0 - var_0_0.OutOfBoundOffset, var_0_0.DelayEnterEpisodeTime, arg_16_0.handlePlayScrollAnimCompleted, arg_16_0)
	else
		arg_16_0._viewAnimator:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(arg_16_0.handlePlayScrollAnimCompleted, arg_16_0, var_0_0.DelayEnterEpisodeTime)
	end
end

function var_0_0.handlePlayScrollAnimCompleted(arg_17_0)
	arg_17_0._scrollCanvasGroup.interactable = true
	arg_17_0._scrollCanvasGroup.blocksRaycasts = true

	UIBlockMgr.instance:endBlock(var_0_0.SCROLL_ANIM_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)
	Season123EpisodeListController.instance:enterEpisode(true)

	arg_17_0._scrollStory.movementType = 1
end

function var_0_0.getScrollToIndexY(arg_18_0, arg_18_1)
	local var_18_0 = 1

	return (arg_18_1 - 0.5 + var_18_0) * arg_18_0._heightItem + (arg_18_1 - 1 + var_18_0) * arg_18_0._heightSpace - arg_18_0._heightScroll * 0.5
end

function var_0_0.onItemClick(arg_19_0, arg_19_1)
	local var_19_0 = Season123EpisodeListModel.instance:getByIndex(arg_19_1)

	if not var_19_0 then
		return
	end

	if Season123EpisodeListModel.instance:isEpisodeUnlock(var_19_0.cfg.layer) then
		local var_19_1 = var_19_0.cfg.layer

		if arg_19_0._gocurrentselected then
			gohelper.setActive(arg_19_0._gocurrentselected, false)
		end

		Season123EpisodeListController.instance:setSelectLayer(var_19_1)
		arg_19_0:playScrollAnim(arg_19_1)
	else
		GameFacade.showToast(ToastEnum.SeasonEpisodeIsLock)

		return
	end
end

function var_0_0._btnheroesOnClick(arg_20_0)
	local var_20_0 = arg_20_0.viewParam.actId

	if not Season123Model.instance:getActInfo(var_20_0) then
		return
	end

	local var_20_1 = Season123EpisodeListModel.instance.curSelectLayer

	if var_20_1 == 0 then
		return
	end

	ViewMgr.instance:openView(Season123Controller.instance:getShowHeroViewName(), {
		actId = var_20_0,
		stage = Season123EpisodeListModel.instance.stage,
		layer = var_20_1
	})
end

function var_0_0._btnresetOnClick(arg_21_0)
	Season123Controller.instance:openResetView({
		actId = Season123EpisodeListModel.instance.activityId,
		stage = Season123EpisodeListModel.instance.stage,
		layer = Season123ResetModel.EmptySelect
	})
end

function var_0_0._btndetailsOnClick(arg_22_0)
	if Season123EpisodeListModel.instance:getCurrentChallengeLayer() == 0 then
		return
	end

	Season123EpisodeListController.instance:openDetails()
end

function var_0_0._btntiprewardOnClick(arg_23_0)
	Season123Controller.instance:openSeasonTaskView({
		actId = Season123EpisodeListModel.instance.activityId,
		stage = Season123EpisodeListModel.instance.stage
	})
end

function var_0_0._btnadditionruleDetailOnClick(arg_24_0)
	local var_24_0 = Season123EpisodeListModel.instance.activityId
	local var_24_1 = Season123EpisodeListModel.instance.stage
	local var_24_2 = {
		actId = var_24_0,
		stage = var_24_1
	}

	Season123Controller.instance:openSeasonAdditionRuleTipView(var_24_2)
end

function var_0_0._btnMaskOnClick(arg_25_0)
	arg_25_0.viewContainer:_overrideCloseFunc()
end

function var_0_0.OnDotChange(arg_26_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Season123StageReward, arg_26_0.viewParam.stage) then
		arg_26_0._animTipReward:Play("btn_tipreward_loop")
	else
		arg_26_0._animTipReward:Play("btn_tipreward")
	end
end

function var_0_0.onCloseView(arg_27_0, arg_27_1)
	if arg_27_1 == ViewName.Season123_2_1EpisodeDetailView then
		arg_27_0:refreshStageList()
		arg_27_0._viewAnimator:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0.delayAddScrollAudio(arg_28_0)
	arg_28_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_28_0._goscrollstory, Season123_2_1EpisodeListScrollAudio, arg_28_0._scrollStory)
	arg_28_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_28_0._goscrollstory)

	arg_28_0._drag:AddDragBeginListener(arg_28_0._onDragBegin, arg_28_0)
	arg_28_0._drag:AddDragEndListener(arg_28_0._onDragEnd, arg_28_0)

	arg_28_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_28_0._goscrollstory)

	arg_28_0._touch:AddClickDownListener(arg_28_0._onClickDown, arg_28_0)
end

function var_0_0._onDragBegin(arg_29_0)
	arg_29_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEnd(arg_30_0)
	arg_30_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDown(arg_31_0)
	arg_31_0._audioScroll:onClickDown()
end

return var_0_0
