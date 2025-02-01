module("modules.logic.seasonver.act123.view1_9.Season123_1_9EpisodeListView", package.seeall)

slot0 = class("Season123_1_9EpisodeListView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnheroes = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_heroes")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._btndetails = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_details")
	slot0._gostageitem = gohelper.findChild(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")
	slot0._btntipreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_tipreward")
	slot0._gorewardRedDot = gohelper.findChild(slot0.viewGO, "#btn_tipreward/#go_rewardredpoint")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_rewards")
	slot0._goscrollstory = gohelper.findChild(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter")
	slot0._btnadditionruledetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_additionruletips/tips/#btn_additionruledetail")
	slot0._goentranceitem = gohelper.findChild(slot0.viewGO, "#go_entrance_item")
	slot0._goframe = gohelper.findChild(slot0.viewGO, "selectframe")
	slot0._animTipReward = slot0._btntipreward:GetComponent(gohelper.Type_Animation)
	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._btnmask = gohelper.findChildButtonWithAudio(slot0.viewGO, "mask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnheroes:AddClickListener(slot0._btnheroesOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btndetails:AddClickListener(slot0._btndetailsOnClick, slot0)
	slot0._btntipreward:AddClickListener(slot0._btntiprewardOnClick, slot0)
	slot0._btnadditionruledetail:AddClickListener(slot0._btnadditionruleDetailOnClick, slot0)
	slot0._btnmask:AddClickListener(slot0._btnMaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnheroes:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btndetails:RemoveClickListener()
	slot0._btntipreward:RemoveClickListener()
	slot0._btnadditionruledetail:RemoveClickListener()
	slot0._btnmask:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._stageItems = {}
	slot0._scrollCanvasGroup = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))
	slot0._scrollStory = gohelper.findChildScrollRect(slot0._goscrollstory, "")
	slot0._goScroll = gohelper.findChild(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content")
	slot0._rectScroll = slot0._goScroll.transform
	slot0._heightScroll = recthelper.getHeight(slot0._scrollStory.transform)
	slot0._heightItem = recthelper.getHeight(slot0._gostageitem.transform)
	slot0._heightSpace = 24
	slot0._goempty3 = gohelper.findChild(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty3")
	slot0._goempty4 = gohelper.findChild(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty4")

	gohelper.setActive(slot0._gorewards, false)
	gohelper.setActive(slot0._goframe, false)
	TaskDispatcher.runDelay(slot0.delayAddScrollAudio, slot0, 0.6)
end

function slot0.onDestroyView(slot0)
	if slot0._stageItems then
		for slot4, slot5 in pairs(slot0._stageItems) do
			slot5.btnSelf:RemoveClickListener()
			slot5.simagechaptericon:UnLoadImage()
		end

		slot0._stageItems = nil
	end

	Season123EpisodeListController.instance:onCloseView()
	UIBlockMgr.instance:endBlock(uv0.SCROLL_ANIM_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)

	if slot0._tweenIdScroll then
		ZProj.TweenHelper.KillById(slot0._tweenIdScroll)

		slot0._tweenIdScroll = nil
	end

	TaskDispatcher.cancelTask(slot0.handlePlayScrollAnimCompleted, slot0)

	if slot0._centerItem then
		slot0._centerItem:dispose()

		slot0._centerItem = nil
	end

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end

	if slot0._touch then
		slot0._touch:RemoveClickDownListener()

		slot0._touch = nil
	end

	TaskDispatcher.cancelTask(slot0.delayAddScrollAudio, slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam.actId
	slot2 = slot0.viewParam.stage

	logNormal(string.format("episode actId=%s, stage=%s", slot1, slot2))
	Season123EpisodeListController.instance:onOpenView(slot1, slot2)
	slot0:addEventCb(Season123Controller.instance, Season123Event.GetActInfo, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.EpisodeViewRefresh, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.StageInfoChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.TaskUpdated, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.ResetCloseEpisodeList, slot0.closeThis, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.OnDotChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)

	if not ActivityModel.instance:getActMO(slot1) or not slot3:isOpen() or slot3:isExpired() then
		return
	end

	slot0:initCenter()
	slot0:refreshUI()

	for slot8, slot9 in ipairs(Season123EpisodeListModel.instance:getList()) do
		if slot9.id == Season123EpisodeListModel.instance:getCurrentChallengeLayer() then
			recthelper.setAnchorY(slot0._rectScroll, slot0:getScrollToIndexY(slot8))
		end
	end

	Season123EpisodeListController.instance:processJumpParam(slot0.viewParam)
	RedDotController.instance:addRedDot(slot0._gorewardRedDot, RedDotEnum.DotNode.Season123StageReward, slot0.viewParam.stage)
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshStageList()
	slot0:refreshCenter()
	gohelper.setActive(slot0._btnreset, Season123EpisodeListModel.instance:inCurrentStage() or Season123ProgressUtils.checkStageIsFinish(Season123EpisodeListModel.instance.activityId, Season123EpisodeListModel.instance.stage))
end

function slot0.refreshStageList(slot0)
	slot2 = {
		[slot8] = true
	}

	for slot6, slot7 in ipairs(Season123EpisodeListModel.instance:getList()) do
		slot0:refreshSingleItem(slot6, slot0:getOrCreateLayerItem(slot6), slot7)
	end

	for slot6, slot7 in pairs(slot0._stageItems) do
		gohelper.setActive(slot7.go, slot2[slot7])
	end

	gohelper.setAsLastSibling(slot0._goempty3)
	gohelper.setAsLastSibling(slot0._goempty4)
end

function slot0.getOrCreateLayerItem(slot0, slot1)
	if not slot0._stageItems[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._gostageitem, "stage_item" .. slot1)
		slot2 = slot0:getUserDataTb_()
		slot2.go = slot3
		slot2.txtName = gohelper.findChildText(slot3, "#txt_name")
		slot2.gofinish = gohelper.findChild(slot3, "#go_done")
		slot2.goUnfinish = gohelper.findChild(slot3, "#go_unfinished")
		slot2.txtPassRound = gohelper.findChildText(slot3, "#go_done/#txt_num")
		slot2.goMark = gohelper.findChild(slot3, "#go_mark")
		slot2.golock = gohelper.findChild(slot3, "#go_locked")
		slot2.simagechaptericon = gohelper.findChildSingleImage(slot3, "#simage_chapterIcon")
		slot2.goselected = gohelper.findChild(slot3, "selectframe")
		slot2.goEnemyList = gohelper.findChild(slot3, "enemyList")
		slot2.goEnemyItem = gohelper.findChild(slot3, "enemyList/#go_enemyteam/enemyList/go_enemyitem")
		slot2.txtchapter = gohelper.findChildText(slot3, "#go_chpt/#txt_chpt")
		slot2.btnSelf = gohelper.findChildButtonWithAudio(slot3, "#btn_self")

		slot2.btnSelf:AddClickListener(slot0.onItemClick, slot0, slot1)
		gohelper.setActive(slot2.go, true)

		slot0._stageItems[slot1] = slot2
	end

	return slot2
end

function slot0.refreshSingleItem(slot0, slot1, slot2, slot3)
	slot2.txtchapter.text = string.format("%02d", slot3.cfg.layer)

	if not string.nilorempty(Season123Model.instance:getSingleBgFolder()) then
		slot2.simagechaptericon:LoadImage(ResUrl.getSeason123EpisodeIcon(slot4, slot3.cfg.stagePicture))
	end

	slot0:refreshSingleItemLock(slot1, slot2, slot3)
	slot0:refreshSingleItemFinished(slot1, slot2, slot3)

	slot5 = slot3.cfg.layer == Season123EpisodeListModel.instance.curSelectLayer

	gohelper.setActive(slot2.goselected, slot5)

	if slot5 then
		slot0._gocurrentselected = slot2.goselected
	end

	gohelper.setActive(slot2.goMark, slot3.cfg.displayMark == Activity123Enum.DisplayMark)
end

function slot0.refreshSingleItemLock(slot0, slot1, slot2, slot3)
	slot4 = Season123EpisodeListModel.instance:isEpisodeUnlock(slot3.cfg.layer)

	gohelper.setActive(slot2.golock, not slot4)
	SLFramework.UGUI.GuiHelper.SetColor(slot2.txtchapter, slot4 and "#FFFFFF" or "#FFFFFF")
end

function slot0.refreshSingleItemFinished(slot0, slot1, slot2, slot3)
	slot5 = slot3.isFinished

	gohelper.setActive(slot2.gofinish, slot5)
	gohelper.setActive(slot2.txtPassRound, slot5)
	gohelper.setActive(slot2.goUnfinish, not slot5 and Season123EpisodeListModel.instance:isEpisodeUnlock(slot3.cfg.layer))

	if slot5 then
		slot2.txtPassRound.text = string.format(Season123Controller.instance:isReduceRound(slot0.viewParam.actId, slot0.viewParam.stage, slot3.cfg.layer) and "<color=#eecd8c>%s</color>" or "%s", tostring(slot3.round))
	end
end

function slot0.refreshCenter(slot0)
	if slot0._centerItem then
		slot0._centerItem:refreshUI()
	end
end

function slot0.initCenter(slot0)
	slot0._centerItem = Season123_1_9EpisodeListCenter.New()

	slot0._centerItem:init(slot0._goentranceitem)
	slot0._centerItem:initData(slot0.viewParam.actId, slot0.viewParam.stage)
end

slot0.OutOfBoundOffset = 280
slot0.DelayEnterEpisodeTime = 0.2
slot0.SCROLL_ANIM_BLOCK_KEY = "Season123_1_9EpisodeListView_scrollanim"

function slot0.playScrollAnim(slot0, slot1)
	UIBlockMgr.instance:startBlock(uv0.SCROLL_ANIM_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(false)

	slot0._scrollCanvasGroup.interactable = false
	slot0._scrollCanvasGroup.blocksRaycasts = false
	slot0._scrollStory.movementType = 0

	if slot0._tweenIdScroll then
		ZProj.TweenHelper.KillById(slot0._tweenIdScroll)
	end

	TaskDispatcher.cancelTask(slot0.handlePlayScrollAnimCompleted, slot0)

	if uv0.OutOfBoundOffset < recthelper.getAnchorY(slot0._rectScroll) - slot0:getScrollToIndexY(slot1) then
		slot0._tweenIdScroll = ZProj.TweenHelper.DOAnchorPosY(slot0._rectScroll, slot2 + uv0.OutOfBoundOffset, uv0.DelayEnterEpisodeTime, slot0.handlePlayScrollAnimCompleted, slot0)
	elseif slot4 < -uv0.OutOfBoundOffset then
		slot0._tweenIdScroll = ZProj.TweenHelper.DOAnchorPosY(slot0._rectScroll, slot2 - uv0.OutOfBoundOffset, uv0.DelayEnterEpisodeTime, slot0.handlePlayScrollAnimCompleted, slot0)
	else
		slot0._viewAnimator:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(slot0.handlePlayScrollAnimCompleted, slot0, uv0.DelayEnterEpisodeTime)
	end
end

function slot0.handlePlayScrollAnimCompleted(slot0)
	slot0._scrollCanvasGroup.interactable = true
	slot0._scrollCanvasGroup.blocksRaycasts = true

	UIBlockMgr.instance:endBlock(uv0.SCROLL_ANIM_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)
	Season123EpisodeListController.instance:enterEpisode(true)

	slot0._scrollStory.movementType = 1
end

function slot0.getScrollToIndexY(slot0, slot1)
	slot2 = 1

	return (slot1 - 0.5 + slot2) * slot0._heightItem + (slot1 - 1 + slot2) * slot0._heightSpace - slot0._heightScroll * 0.5
end

function slot0.onItemClick(slot0, slot1)
	if not Season123EpisodeListModel.instance:getByIndex(slot1) then
		return
	end

	if Season123EpisodeListModel.instance:isEpisodeUnlock(slot2.cfg.layer) then
		slot4 = slot2.cfg.layer

		if slot0._gocurrentselected then
			gohelper.setActive(slot0._gocurrentselected, false)
		end

		Season123EpisodeListController.instance:setSelectLayer(slot4)
		slot0:playScrollAnim(slot1)
	else
		GameFacade.showToast(ToastEnum.SeasonEpisodeIsLock)

		return
	end
end

function slot0._btnheroesOnClick(slot0)
	if not Season123Model.instance:getActInfo(slot0.viewParam.actId) then
		return
	end

	if Season123EpisodeListModel.instance.curSelectLayer == 0 then
		return
	end

	ViewMgr.instance:openView(Season123Controller.instance:getShowHeroViewName(), {
		actId = slot1,
		stage = Season123EpisodeListModel.instance.stage,
		layer = slot3
	})
end

function slot0._btnresetOnClick(slot0)
	Season123Controller.instance:openResetView({
		actId = Season123EpisodeListModel.instance.activityId,
		stage = Season123EpisodeListModel.instance.stage,
		layer = Season123ResetModel.EmptySelect
	})
end

function slot0._btndetailsOnClick(slot0)
	if Season123EpisodeListModel.instance:getCurrentChallengeLayer() == 0 then
		return
	end

	Season123EpisodeListController.instance:openDetails()
end

function slot0._btntiprewardOnClick(slot0)
	Season123Controller.instance:openSeasonTaskView({
		actId = Season123EpisodeListModel.instance.activityId,
		stage = Season123EpisodeListModel.instance.stage
	})
end

function slot0._btnadditionruleDetailOnClick(slot0)
	Season123Controller.instance:openSeasonAdditionRuleTipView({
		actId = Season123EpisodeListModel.instance.activityId,
		stage = Season123EpisodeListModel.instance.stage
	})
end

function slot0._btnMaskOnClick(slot0)
	slot0.viewContainer:_overrideCloseFunc()
end

function slot0.OnDotChange(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Season123StageReward, slot0.viewParam.stage) then
		slot0._animTipReward:Play("btn_tipreward_loop")
	else
		slot0._animTipReward:Play("btn_tipreward")
	end
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.Season123_1_9EpisodeDetailView then
		slot0:refreshStageList()
		slot0._viewAnimator:Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0.delayAddScrollAudio(slot0)
	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._goscrollstory, Season123_1_9EpisodeListScrollAudio, slot0._scrollStory)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._goscrollstory)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)

	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._goscrollstory)

	slot0._touch:AddClickDownListener(slot0._onClickDown, slot0)
end

function slot0._onDragBegin(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEnd(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onClickDown(slot0)
	slot0._audioScroll:onClickDown()
end

return slot0
