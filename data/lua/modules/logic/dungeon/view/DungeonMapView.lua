module("modules.logic.dungeon.view.DungeonMapView", package.seeall)

slot0 = class("DungeonMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._gobgcontainerold = gohelper.findChild(slot0.viewGO, "bgcanvas/#go_bgcontainerold")
	slot0._gobgcontainer = gohelper.findChild(slot0.viewGO, "bgcanvas/#go_bgcontainer")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_content")
	slot0._gochaptercontentitem = gohelper.findChild(slot0.viewGO, "#scroll_content/#go_chaptercontentitem")
	slot0._gomain = gohelper.findChild(slot0.viewGO, "#go_main")
	slot0._btngifts = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/#go_rightbtns/#btn_gifts")
	slot0._btneliminate = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/#go_dungeontips/#btn_eliminate")
	slot0._btnteach = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/#go_rightbtns/#btn_teach")
	slot0._gobaoxiang1 = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_teach/baoxiang/#go_baoxiang1")
	slot0._gobaoxiang2 = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_teach/baoxiang/#go_baoxiang2")
	slot0._goteachredpoint = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_teach/#go_teachredpoint")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/#txt_progress")
	slot0._gotoptipsbg = gohelper.findChild(slot0.viewGO, "#go_main/#go_toptipsbg")
	slot0._txtposition = gohelper.findChildText(slot0.viewGO, "#go_main/#go_toptipsbg/#txt_position")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#go_main/#go_toptipsbg/#txt_position/#txt_time")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "#go_main/#go_toptipsbg/#txt_remaintime")
	slot0._godungeontips = gohelper.findChild(slot0.viewGO, "#go_main/#go_dungeontips")
	slot0._gotipepisode = gohelper.findChild(slot0.viewGO, "#go_main/#go_dungeontips/#go_tipepisode")
	slot0._btngotoEpisode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/#go_dungeontips/#go_tipepisode/#btn_gotoEpisode")
	slot0._gotipmap = gohelper.findChild(slot0.viewGO, "#go_main/#go_dungeontips/#go_tipmap")
	slot0._btngotoMap = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/#go_dungeontips/#go_tipmap/#btn_gotoMap")
	slot0._gores = gohelper.findChild(slot0.viewGO, "#go_res")
	slot0._goentryItem = gohelper.findChild(slot0.viewGO, "#go_res/entry/#go_entryItem")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_res/entry/#go_entryItem/#simage_icon")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_res/entry/#go_entryItem/#txt_num")
	slot0._imagefull = gohelper.findChildImage(slot0.viewGO, "#go_res/entry/#go_entryItem/progress/#image_full")
	slot0._txtprogressNum = gohelper.findChildText(slot0.viewGO, "#go_res/entry/#go_entryItem/progress/#txt_progressNum")
	slot0._gochapterlist = gohelper.findChild(slot0.viewGO, "#go_res/chapter/#go_chapterlist")
	slot0._gochapterlineItem = gohelper.findChild(slot0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem")
	slot0._gochoiceicon = gohelper.findChild(slot0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_choiceicon")
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_choiceicon/#simage_icon1")
	slot0._gonormalicon = gohelper.findChild(slot0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_normalicon")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_normalicon/#simage_icon2")
	slot0._golockicon = gohelper.findChild(slot0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_lockicon")
	slot0._simageicon3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_lockicon/#simage_icon3")
	slot0._goitemline = gohelper.findChild(slot0.viewGO, "#go_res/chapter/#go_chapterlist/#go_itemline")
	slot0._gotasklist = gohelper.findChild(slot0.viewGO, "#go_tasklist")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_taskitem")
	slot0._gogiftredpoint = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/#go_giftredpoint")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngifts:AddClickListener(slot0._btngiftsOnClick, slot0)
	slot0._btneliminate:AddClickListener(slot0._btneliminateOnClick, slot0)
	slot0._btnteach:AddClickListener(slot0._btnteachOnClick, slot0)
	slot0._btngotoEpisode:AddClickListener(slot0._btngotoEpisodeOnClick, slot0)
	slot0._btngotoMap:AddClickListener(slot0._btngotoMapOnClick, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngifts:RemoveClickListener()
	slot0._btneliminate:RemoveClickListener()
	slot0._btnteach:RemoveClickListener()
	slot0._btngotoEpisode:RemoveClickListener()
	slot0._btngotoMap:RemoveClickListener()
	slot0._btncloseview:RemoveClickListener()
end

function slot0._btncloseviewOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function slot0._btngotoEpisodeOnClick(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, slot0._hardEpisode)
end

function slot0._btngotoMapOnClick(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, slot0._mapEpisode)
end

function slot0._btnteachOnClick(slot0)
	TeachNoteController.instance:enterTeachNoteView()
end

function slot0._btneliminateOnClick(slot0)
	EliminateMapController.instance:openEliminateMapView()
end

function slot0._btngiftsOnClick(slot0)
	DungeonController.instance:openDungeonCumulativeRewardsView(slot0.viewParam)
end

function slot0._editableInitView(slot0)
	slot0._playAudioCheck = {}
	slot0._topLeftGo = gohelper.findChild(slot0.viewGO, "top_left")
	slot0._topLeftElementGo = gohelper.findChild(slot0.viewGO, "top_left_element")
	slot0._tipDefaultX = recthelper.getAnchorX(slot0._godungeontips.transform)
	slot1 = slot0._btngifts.gameObject
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._teachAnim = slot0._btnteach.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._baoxiang = gohelper.findChild(slot1, "baoxiang")
	slot0._addtxtprogress = gohelper.findChildText(slot0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/txt_progress_effect")
	slot0._addGo = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/obtain")
	slot0._addtxtnum = gohelper.findChildText(slot0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/obtain/zengjiatxt")
	slot0._goreceive = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/gifts_receive")

	gohelper.addUIClickAudio(slot0._btngifts.gameObject, AudioEnum.UI.play_ui_checkpoint_swath_open)
	slot0:_setEffectAudio()
	gohelper.setActive(slot0._btngifts.gameObject, slot0:_isShowBtnGift())
	gohelper.removeUIClickAudio(slot0._btncloseview.gameObject)

	slot0._rectmask2D = slot0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
end

function slot0._setEffectAudio(slot0)
	slot0._tiggerCount = 9
	slot0._audioCount = 7

	slot0._btngifts:GetComponent(typeof(ZProj.AnimationEventWrap)):AddEventListener("audio", slot0._onEffectAudio, slot0)
end

function slot0._onEffectAudio(slot0)
	slot0._audioCount = slot0._audioCount + 1

	if slot0:_needAudio() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_rewardgain)
	end
end

function slot0._needAudio(slot0)
	if not slot0._progressPoint then
		return false
	end

	if slot0._playAudioCheck[slot0._progressPoint] then
		return false
	end

	slot0._playAudioCheck[slot0._progressPoint] = true

	return true
end

function slot0._endShowRewardView(slot0)
	if slot0._isNormalChapter then
		-- Nothing
	end
end

function slot0._refreshPointReward(slot0, slot1)
	transformhelper.setLocalScale(slot0._baoxiang.transform, 1, 1, 1)

	slot0._anim.enabled = false

	if not DungeonConfig.instance:getChapterPointReward(slot0._chapterId) and not slot0._isNormalChapter then
		gohelper.setActive(slot0._btngifts.gameObject, false)

		return
	end

	slot0._txtprogress.text = string.format("%s/%s", DungeonMapModel.instance:getRewardPointInfo().rewardPoint, DungeonMapModel.instance:getUnfinishedTargetReward().rewardPointNum)

	gohelper.setActive(slot0._gogiftredpoint, DungeonMapModel.instance:canGetAllRewardsList() and #slot5 > 0)

	if not slot1 and slot5 and #slot5 > 0 then
		slot0._anim.enabled = true

		slot0._anim:Play("dungeonmap_gifts_receive")

		slot0._progressPoint = slot3.rewardPoint

		return
	end

	gohelper.setActive(slot0._goreceive, false)
end

function slot0._OnAddRewardPoint(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._obtainFinished, slot0)

	slot0._anim.enabled = false

	if not DungeonConfig.instance:getChapterPointReward(slot0._chapterId) then
		return
	end

	slot3 = DungeonMapModel.instance:getRewardPointInfo(slot0._chapterId)
	slot5 = DungeonMapModel.instance:getUnfinishedTargetReward().rewardPointNum
	slot0._addtxtnum.text = "+" .. tostring(slot1)

	gohelper.setActive(slot0._addGo, true)
	TaskDispatcher.runDelay(slot0._obtainFinished, slot0, 1.5)

	if DungeonMapModel.instance:canGetAllRewardsList() and #slot6 > 0 then
		slot0:_refreshPointReward()

		return
	end

	if slot5 <= slot3.rewardPoint then
		return
	end

	slot7 = string.format("%s/%s", math.min(slot3.rewardPoint, slot5), slot5)
	slot0._addtxtprogress.text = slot7
	slot0._txtprogress.text = slot7
	slot0._anim.enabled = true

	slot0._anim:Play("dungeonmap_gifts_obtain")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_rewardgain)

	slot0._audioCount = 0
end

function slot0._obtainFinished(slot0)
	gohelper.setActive(slot0._addGo, false)
end

function slot0.onUpdateParam(slot0)
	slot0.viewContainer:refreshHelp()
	slot0:refreshUI()
end

function slot0._OnCheckVision(slot0, slot1)
	slot0._hardEpisode = slot1[1]
	slot0._mapEpisode = slot1[2]

	gohelper.setActive(slot0._gotipepisode, false)
end

function slot0._onEscBtnClick(slot0)
	if slot0._topLeftGo.activeInHierarchy then
		slot0.viewContainer:overrideClose()
	elseif slot0._topLeftElementGo.activeInHierarchy then
		slot0.viewContainer:overrideCloseElement()
	end
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.onOpenFinish(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, slot0.viewParam.chapterId)
end

function slot0.refreshUI(slot0)
	slot0._chapterId = slot0.viewParam.chapterId
	slot0._isNormalChapter = DungeonConfig.instance:getChapterCO(slot0._chapterId).type == DungeonEnum.ChapterType.Normal

	DungeonModel.instance:clearUnlockNewChapterId(slot0._chapterId)
	slot0:setGiftIn()
	slot0:_setTeachBtn()
	gohelper.setActive(slot0._btneliminate.gameObject, slot0:_isShowBtnEliminate())
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnGetPointReward, slot0._refreshPointReward, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0._endShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnAddRewardPoint, slot0._OnAddRewardPoint, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnCheckVision, slot0._OnCheckVision, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0._setEpisodeListVisible, slot0)
	slot0:addEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, slot0._setTeachBtn, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0._onFuncUnlockRefresh, slot0)
	slot0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0.viewContainer.refreshHelp, slot0.viewContainer)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, slot0._OnChangeMap, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, slot0._onOpenFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapView, slot0._onEscBtnClick, slot0)
	gohelper.setActive(slot0._gomain, slot0._isNormalChapter)
	gohelper.setActive(slot0._gores, not slot0._isNormalChapter)

	if slot0._isNormalChapter then
		DungeonController.instance:OnOpenNormalMapView()
	end

	if DungeonConfig.instance:getChapterPointReward(slot0._chapterId) and ViewMgr.instance:isOpen(ViewName.MainView) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_point)
	end

	gohelper.setActive(slot0._btncloseview, ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView))
end

function slot0._OnChangeMap(slot0)
end

function slot0._setEpisodeListVisible(slot0, slot1, slot2)
	if slot2 == DungeonEnum.EpisodeListVisibleSource.ToughBattle then
		return
	end

	gohelper.setActive(slot0._gofullscreen, slot1)
	slot0:_clearTipTween()

	if slot1 then
		slot0._tipTweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._godungeontips.transform, slot0._tipDefaultX, 0.2)

		slot0:_onCloseHandler()
	else
		slot0._tipTweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._godungeontips.transform, -140, slot3)

		slot0:_onOpenHandler()
	end
end

function slot0._clearTipTween(slot0)
	if slot0._tipTweenId then
		ZProj.TweenHelper.KillById(slot0._tipTweenId)

		slot0._tipTweenId = nil
	end
end

function slot0._isShowBtnGift(slot0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ChapterReward) and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)
end

function slot0._isShowBtnEliminate(slot0)
	return slot0._chapterId == DungeonEnum.ChapterId.Main1_8 and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Eliminate) and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)
end

function slot0._onFuncUnlockRefresh(slot0)
	gohelper.setActive(slot0._btngifts.gameObject, slot0:_isShowBtnGift())
	gohelper.setActive(slot0._btneliminate.gameObject, slot0:_isShowBtnEliminate())
end

function slot0._onOpenHandler(slot0)
	gohelper.setActive(slot0._btngifts.gameObject, false)
	gohelper.setActive(slot0._btneliminate.gameObject, false)
	gohelper.setActive(slot0._btnteach.gameObject, false)
	gohelper.setActive(slot0._topLeftGo.gameObject, false)
	gohelper.setActive(slot0._topLeftElementGo.gameObject, true)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView or slot1 == ViewName.DungeonMapTaskView or slot1 == ViewName.TeachNoteDetailView then
		slot0:_onOpenHandler()
	end

	if slot1 == ViewName.DungeonMapLevelView then
		gohelper.setActive(slot0._btncloseview, true)

		slot0._rectmask2D.padding = Vector4(0, 0, 600, 0)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView or slot1 == ViewName.DungeonMapTaskView then
		slot0:_onCloseHandler(false)
	end

	if slot1 == ViewName.TeachNoteDetailView then
		slot0:_onCloseHandler(true)
	end

	if slot1 == ViewName.DungeonMapLevelView then
		gohelper.setActive(slot0._btncloseview, false)

		slot0._rectmask2D.padding = Vector4(0, 0, 0, 0)
	end
end

function slot0._onCloseHandler(slot0, slot1)
	gohelper.setActive(slot0._btngifts.gameObject, slot0:_isShowBtnGift())
	gohelper.setActive(slot0._btneliminate.gameObject, slot0:_isShowBtnEliminate())
	gohelper.setActive(slot0._topLeftGo.gameObject, true)
	gohelper.setActive(slot0._topLeftElementGo.gameObject, false)
	slot0:_setTeachBtn()
	slot0:setGiftIn()
end

function slot0.setGiftIn(slot0)
	TaskDispatcher.cancelTask(slot0._refreshPointReward, slot0)
	slot0:_refreshPointReward(true)

	slot0._anim.enabled = true

	slot0._anim:Play("dungeonmap_gifts_in")
	gohelper.setActive(slot0._gogiftredpoint, false)
	TaskDispatcher.runDelay(slot0._refreshPointReward, slot0, 1)
end

function slot0._setTeachBtn(slot0)
	if not TeachNoteModel.instance:isTeachNoteUnlock() or ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		gohelper.setActive(slot0._btnteach.gameObject, false)

		return
	end

	gohelper.setActive(slot0._btnteach.gameObject, true)

	slot0._teachAnim.enabled = true
	slot1 = TeachNoteModel.instance:hasRewardCouldGet()
	slot2 = #TeachNoteModel.instance:getNewOpenTopics() > 0

	gohelper.setActive(slot0._goteachredpoint, slot1)
	gohelper.setActive(slot0._gobaoxiang1, not slot2 and not slot1)
	gohelper.setActive(slot0._gobaoxiang2, slot2 or slot1)
	slot0._teachAnim:SetBool("unlock", slot1)
	slot0._teachAnim:Play(UIAnimationName.Open, 0, 0)
end

function slot0._onOpenFullView(slot0, slot1)
	if slot1 == ViewName.EliminateLevelView then
		gohelper.setActive(slot0.viewGO, false)
	end
end

function slot0._onCloseFullView(slot0, slot1)
	if slot1 == ViewName.EliminateLevelView then
		gohelper.setActive(slot0.viewGO, true)
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._obtainFinished, slot0)
	TaskDispatcher.cancelTask(slot0._refreshPointReward, slot0)
end

return slot0
