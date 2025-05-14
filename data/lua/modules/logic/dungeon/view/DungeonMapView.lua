module("modules.logic.dungeon.view.DungeonMapView", package.seeall)

local var_0_0 = class("DungeonMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._gobgcontainerold = gohelper.findChild(arg_1_0.viewGO, "bgcanvas/#go_bgcontainerold")
	arg_1_0._gobgcontainer = gohelper.findChild(arg_1_0.viewGO, "bgcanvas/#go_bgcontainer")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_content")
	arg_1_0._gochaptercontentitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_content/#go_chaptercontentitem")
	arg_1_0._gomain = gohelper.findChild(arg_1_0.viewGO, "#go_main")
	arg_1_0._btngifts = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_gifts")
	arg_1_0._btneliminate = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/#go_dungeontips/#btn_eliminate")
	arg_1_0._btnteach = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_teach")
	arg_1_0._gobaoxiang1 = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_teach/baoxiang/#go_baoxiang1")
	arg_1_0._gobaoxiang2 = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_teach/baoxiang/#go_baoxiang2")
	arg_1_0._goteachredpoint = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_teach/#go_teachredpoint")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/#txt_progress")
	arg_1_0._gotoptipsbg = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_toptipsbg")
	arg_1_0._txtposition = gohelper.findChildText(arg_1_0.viewGO, "#go_main/#go_toptipsbg/#txt_position")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_main/#go_toptipsbg/#txt_position/#txt_time")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "#go_main/#go_toptipsbg/#txt_remaintime")
	arg_1_0._godungeontips = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_dungeontips")
	arg_1_0._gotipepisode = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_dungeontips/#go_tipepisode")
	arg_1_0._btngotoEpisode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/#go_dungeontips/#go_tipepisode/#btn_gotoEpisode")
	arg_1_0._gotipmap = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_dungeontips/#go_tipmap")
	arg_1_0._btngotoMap = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/#go_dungeontips/#go_tipmap/#btn_gotoMap")
	arg_1_0._gores = gohelper.findChild(arg_1_0.viewGO, "#go_res")
	arg_1_0._goentryItem = gohelper.findChild(arg_1_0.viewGO, "#go_res/entry/#go_entryItem")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_res/entry/#go_entryItem/#simage_icon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_res/entry/#go_entryItem/#txt_num")
	arg_1_0._imagefull = gohelper.findChildImage(arg_1_0.viewGO, "#go_res/entry/#go_entryItem/progress/#image_full")
	arg_1_0._txtprogressNum = gohelper.findChildText(arg_1_0.viewGO, "#go_res/entry/#go_entryItem/progress/#txt_progressNum")
	arg_1_0._gochapterlist = gohelper.findChild(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist")
	arg_1_0._gochapterlineItem = gohelper.findChild(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem")
	arg_1_0._gochoiceicon = gohelper.findChild(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_choiceicon")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_choiceicon/#simage_icon1")
	arg_1_0._gonormalicon = gohelper.findChild(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_normalicon")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_normalicon/#simage_icon2")
	arg_1_0._golockicon = gohelper.findChild(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_lockicon")
	arg_1_0._simageicon3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem/#go_lockicon/#simage_icon3")
	arg_1_0._goitemline = gohelper.findChild(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist/#go_itemline")
	arg_1_0._gotasklist = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist/#go_taskitem")
	arg_1_0._gogiftredpoint = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/#go_giftredpoint")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngifts:AddClickListener(arg_2_0._btngiftsOnClick, arg_2_0)
	arg_2_0._btneliminate:AddClickListener(arg_2_0._btneliminateOnClick, arg_2_0)
	arg_2_0._btnteach:AddClickListener(arg_2_0._btnteachOnClick, arg_2_0)
	arg_2_0._btngotoEpisode:AddClickListener(arg_2_0._btngotoEpisodeOnClick, arg_2_0)
	arg_2_0._btngotoMap:AddClickListener(arg_2_0._btngotoMapOnClick, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngifts:RemoveClickListener()
	arg_3_0._btneliminate:RemoveClickListener()
	arg_3_0._btnteach:RemoveClickListener()
	arg_3_0._btngotoEpisode:RemoveClickListener()
	arg_3_0._btngotoMap:RemoveClickListener()
	arg_3_0._btncloseview:RemoveClickListener()
end

function var_0_0._btncloseviewOnClick(arg_4_0)
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function var_0_0._btngotoEpisodeOnClick(arg_5_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, arg_5_0._hardEpisode)
end

function var_0_0._btngotoMapOnClick(arg_6_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, arg_6_0._mapEpisode)
end

function var_0_0._btnteachOnClick(arg_7_0)
	TeachNoteController.instance:enterTeachNoteView()
end

function var_0_0._btneliminateOnClick(arg_8_0)
	EliminateMapController.instance:openEliminateMapView()
end

function var_0_0._btngiftsOnClick(arg_9_0)
	DungeonController.instance:openDungeonCumulativeRewardsView(arg_9_0.viewParam)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._playAudioCheck = {}
	arg_10_0._topLeftGo = gohelper.findChild(arg_10_0.viewGO, "top_left")
	arg_10_0._topLeftElementGo = gohelper.findChild(arg_10_0.viewGO, "top_left_element")
	arg_10_0._tipDefaultX = recthelper.getAnchorX(arg_10_0._godungeontips.transform)

	local var_10_0 = arg_10_0._btngifts.gameObject

	arg_10_0._anim = var_10_0:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0._teachAnim = arg_10_0._btnteach.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0._baoxiang = gohelper.findChild(var_10_0, "baoxiang")
	arg_10_0._addtxtprogress = gohelper.findChildText(arg_10_0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/txt_progress_effect")
	arg_10_0._addGo = gohelper.findChild(arg_10_0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/obtain")
	arg_10_0._addtxtnum = gohelper.findChildText(arg_10_0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/obtain/zengjiatxt")
	arg_10_0._goreceive = gohelper.findChild(arg_10_0.viewGO, "#go_main/#go_rightbtns/#btn_gifts/gifts_receive")

	gohelper.addUIClickAudio(arg_10_0._btngifts.gameObject, AudioEnum.UI.play_ui_checkpoint_swath_open)
	arg_10_0:_setEffectAudio()
	gohelper.setActive(arg_10_0._btngifts.gameObject, arg_10_0:_isShowBtnGift())
	gohelper.removeUIClickAudio(arg_10_0._btncloseview.gameObject)

	arg_10_0._rectmask2D = arg_10_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
end

function var_0_0._setEffectAudio(arg_11_0)
	arg_11_0._tiggerCount = 9
	arg_11_0._audioCount = 7

	arg_11_0._btngifts:GetComponent(typeof(ZProj.AnimationEventWrap)):AddEventListener("audio", arg_11_0._onEffectAudio, arg_11_0)
end

function var_0_0._onEffectAudio(arg_12_0)
	arg_12_0._audioCount = arg_12_0._audioCount + 1

	if arg_12_0:_needAudio() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_rewardgain)
	end
end

function var_0_0._needAudio(arg_13_0)
	if not arg_13_0._progressPoint then
		return false
	end

	if arg_13_0._playAudioCheck[arg_13_0._progressPoint] then
		return false
	end

	arg_13_0._playAudioCheck[arg_13_0._progressPoint] = true

	return true
end

function var_0_0._endShowRewardView(arg_14_0)
	if arg_14_0._isNormalChapter then
		-- block empty
	end
end

function var_0_0._refreshPointReward(arg_15_0, arg_15_1)
	transformhelper.setLocalScale(arg_15_0._baoxiang.transform, 1, 1, 1)

	arg_15_0._anim.enabled = false

	if not DungeonConfig.instance:getChapterPointReward(arg_15_0._chapterId) and not arg_15_0._isNormalChapter then
		gohelper.setActive(arg_15_0._btngifts.gameObject, false)

		return
	end

	local var_15_0 = DungeonMapModel.instance:getRewardPointInfo()
	local var_15_1 = DungeonMapModel.instance:getUnfinishedTargetReward()

	arg_15_0._txtprogress.text = string.format("%s/%s", var_15_0.rewardPoint, var_15_1.rewardPointNum)

	local var_15_2 = DungeonMapModel.instance:canGetAllRewardsList()

	gohelper.setActive(arg_15_0._gogiftredpoint, var_15_2 and #var_15_2 > 0)

	if not arg_15_1 and var_15_2 and #var_15_2 > 0 then
		arg_15_0._anim.enabled = true

		arg_15_0._anim:Play("dungeonmap_gifts_receive")

		arg_15_0._progressPoint = var_15_0.rewardPoint

		return
	end

	gohelper.setActive(arg_15_0._goreceive, false)
end

function var_0_0._OnAddRewardPoint(arg_16_0, arg_16_1)
	TaskDispatcher.cancelTask(arg_16_0._obtainFinished, arg_16_0)

	arg_16_0._anim.enabled = false

	if not DungeonConfig.instance:getChapterPointReward(arg_16_0._chapterId) then
		return
	end

	local var_16_0 = DungeonMapModel.instance:getRewardPointInfo(arg_16_0._chapterId)
	local var_16_1 = DungeonMapModel.instance:getUnfinishedTargetReward().rewardPointNum

	arg_16_0._addtxtnum.text = "+" .. tostring(arg_16_1)

	gohelper.setActive(arg_16_0._addGo, true)
	TaskDispatcher.runDelay(arg_16_0._obtainFinished, arg_16_0, 1.5)

	local var_16_2 = DungeonMapModel.instance:canGetAllRewardsList()

	if var_16_2 and #var_16_2 > 0 then
		arg_16_0:_refreshPointReward()

		return
	end

	if var_16_1 <= var_16_0.rewardPoint then
		return
	end

	local var_16_3 = string.format("%s/%s", math.min(var_16_0.rewardPoint, var_16_1), var_16_1)

	arg_16_0._addtxtprogress.text = var_16_3
	arg_16_0._txtprogress.text = var_16_3
	arg_16_0._anim.enabled = true

	arg_16_0._anim:Play("dungeonmap_gifts_obtain")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_rewardgain)

	arg_16_0._audioCount = 0
end

function var_0_0._obtainFinished(arg_17_0)
	gohelper.setActive(arg_17_0._addGo, false)
end

function var_0_0.onUpdateParam(arg_18_0)
	arg_18_0.viewContainer:refreshHelp()
	arg_18_0:refreshUI()
end

function var_0_0._OnCheckVision(arg_19_0, arg_19_1)
	arg_19_0._hardEpisode = arg_19_1[1]
	arg_19_0._mapEpisode = arg_19_1[2]

	gohelper.setActive(arg_19_0._gotipepisode, false)
end

function var_0_0._onEscBtnClick(arg_20_0)
	if arg_20_0._topLeftGo.activeInHierarchy then
		arg_20_0.viewContainer:overrideClose()
	elseif arg_20_0._topLeftElementGo.activeInHierarchy then
		arg_20_0.viewContainer:overrideCloseElement()
	end
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0:refreshUI()
end

function var_0_0.onOpenFinish(arg_22_0)
	local var_22_0 = arg_22_0.viewParam.chapterId

	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonMapView, var_22_0)
end

function var_0_0.refreshUI(arg_23_0)
	arg_23_0._chapterId = arg_23_0.viewParam.chapterId
	arg_23_0._isNormalChapter = DungeonConfig.instance:getChapterCO(arg_23_0._chapterId).type == DungeonEnum.ChapterType.Normal

	DungeonModel.instance:clearUnlockNewChapterId(arg_23_0._chapterId)
	arg_23_0:setGiftIn()
	arg_23_0:_setTeachBtn()
	gohelper.setActive(arg_23_0._btneliminate.gameObject, arg_23_0:_isShowBtnEliminate())
	arg_23_0:addEventCb(DungeonController.instance, DungeonEvent.OnGetPointReward, arg_23_0._refreshPointReward, arg_23_0)
	arg_23_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_23_0._endShowRewardView, arg_23_0)
	arg_23_0:addEventCb(DungeonController.instance, DungeonEvent.OnAddRewardPoint, arg_23_0._OnAddRewardPoint, arg_23_0)
	arg_23_0:addEventCb(DungeonController.instance, DungeonEvent.OnCheckVision, arg_23_0._OnCheckVision, arg_23_0)
	arg_23_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_23_0._setEpisodeListVisible, arg_23_0)
	arg_23_0:addEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, arg_23_0._setTeachBtn, arg_23_0)
	arg_23_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_23_0._onFuncUnlockRefresh, arg_23_0)
	arg_23_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_23_0.viewContainer.refreshHelp, arg_23_0.viewContainer)
	arg_23_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, arg_23_0._OnChangeMap, arg_23_0)
	arg_23_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_23_0._onOpenFullView, arg_23_0)
	arg_23_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_23_0._onCloseFullView, arg_23_0)
	arg_23_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_23_0._onOpenView, arg_23_0)
	arg_23_0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_23_0._onOpenView, arg_23_0)
	arg_23_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_23_0._onCloseView, arg_23_0)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapView, arg_23_0._onEscBtnClick, arg_23_0)
	gohelper.setActive(arg_23_0._gomain, arg_23_0._isNormalChapter)
	gohelper.setActive(arg_23_0._gores, not arg_23_0._isNormalChapter)

	if arg_23_0._isNormalChapter then
		DungeonController.instance:OnOpenNormalMapView()
	end

	if DungeonConfig.instance:getChapterPointReward(arg_23_0._chapterId) and ViewMgr.instance:isOpen(ViewName.MainView) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_point)
	end

	gohelper.setActive(arg_23_0._btncloseview, ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView))
end

function var_0_0._OnChangeMap(arg_24_0)
	return
end

function var_0_0._setEpisodeListVisible(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 == DungeonEnum.EpisodeListVisibleSource.ToughBattle then
		return
	end

	gohelper.setActive(arg_25_0._gofullscreen, arg_25_1)
	arg_25_0:_clearTipTween()

	local var_25_0 = 0.2

	if arg_25_1 then
		arg_25_0._tipTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_25_0._godungeontips.transform, arg_25_0._tipDefaultX, var_25_0)

		arg_25_0:_onCloseHandler()
	else
		arg_25_0._tipTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_25_0._godungeontips.transform, -140, var_25_0)

		arg_25_0:_onOpenHandler()
	end
end

function var_0_0._clearTipTween(arg_26_0)
	if arg_26_0._tipTweenId then
		ZProj.TweenHelper.KillById(arg_26_0._tipTweenId)

		arg_26_0._tipTweenId = nil
	end
end

function var_0_0._isShowBtnGift(arg_27_0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ChapterReward) and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)
end

function var_0_0._isShowBtnEliminate(arg_28_0)
	return arg_28_0._chapterId == DungeonEnum.ChapterId.Main1_8 and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Eliminate) and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)
end

function var_0_0._onFuncUnlockRefresh(arg_29_0)
	gohelper.setActive(arg_29_0._btngifts.gameObject, arg_29_0:_isShowBtnGift())
	gohelper.setActive(arg_29_0._btneliminate.gameObject, arg_29_0:_isShowBtnEliminate())
end

function var_0_0._onOpenHandler(arg_30_0)
	gohelper.setActive(arg_30_0._btngifts.gameObject, false)
	gohelper.setActive(arg_30_0._btneliminate.gameObject, false)
	gohelper.setActive(arg_30_0._btnteach.gameObject, false)
	gohelper.setActive(arg_30_0._topLeftGo.gameObject, false)
	gohelper.setActive(arg_30_0._topLeftElementGo.gameObject, true)
end

function var_0_0._onOpenView(arg_31_0, arg_31_1)
	if arg_31_1 == ViewName.DungeonMapLevelView or arg_31_1 == ViewName.DungeonMapTaskView or arg_31_1 == ViewName.TeachNoteDetailView then
		arg_31_0:_onOpenHandler()
	end

	if arg_31_1 == ViewName.DungeonMapLevelView then
		gohelper.setActive(arg_31_0._btncloseview, true)

		arg_31_0._rectmask2D.padding = Vector4(0, 0, 600, 0)
	end
end

function var_0_0._onCloseView(arg_32_0, arg_32_1)
	if arg_32_1 == ViewName.DungeonMapLevelView or arg_32_1 == ViewName.DungeonMapTaskView then
		arg_32_0:_onCloseHandler(false)
	end

	if arg_32_1 == ViewName.TeachNoteDetailView then
		arg_32_0:_onCloseHandler(true)
	end

	if arg_32_1 == ViewName.DungeonMapLevelView then
		gohelper.setActive(arg_32_0._btncloseview, false)

		arg_32_0._rectmask2D.padding = Vector4(0, 0, 0, 0)
	end
end

function var_0_0._onCloseHandler(arg_33_0, arg_33_1)
	gohelper.setActive(arg_33_0._btngifts.gameObject, arg_33_0:_isShowBtnGift())
	gohelper.setActive(arg_33_0._btneliminate.gameObject, arg_33_0:_isShowBtnEliminate())
	gohelper.setActive(arg_33_0._topLeftGo.gameObject, true)
	gohelper.setActive(arg_33_0._topLeftElementGo.gameObject, false)
	arg_33_0:_setTeachBtn()
	arg_33_0:setGiftIn()
end

function var_0_0.setGiftIn(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._refreshPointReward, arg_34_0)
	arg_34_0:_refreshPointReward(true)

	arg_34_0._anim.enabled = true

	arg_34_0._anim:Play("dungeonmap_gifts_in")
	gohelper.setActive(arg_34_0._gogiftredpoint, false)
	TaskDispatcher.runDelay(arg_34_0._refreshPointReward, arg_34_0, 1)
end

function var_0_0._setTeachBtn(arg_35_0)
	if not TeachNoteModel.instance:isTeachNoteUnlock() or ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		gohelper.setActive(arg_35_0._btnteach.gameObject, false)

		return
	end

	gohelper.setActive(arg_35_0._btnteach.gameObject, true)

	arg_35_0._teachAnim.enabled = true

	local var_35_0 = TeachNoteModel.instance:hasRewardCouldGet()
	local var_35_1 = #TeachNoteModel.instance:getNewOpenTopics() > 0

	gohelper.setActive(arg_35_0._goteachredpoint, var_35_0)
	gohelper.setActive(arg_35_0._gobaoxiang1, not var_35_1 and not var_35_0)
	gohelper.setActive(arg_35_0._gobaoxiang2, var_35_1 or var_35_0)
	arg_35_0._teachAnim:SetBool("unlock", var_35_0)
	arg_35_0._teachAnim:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0._onOpenFullView(arg_36_0, arg_36_1)
	if arg_36_1 == ViewName.EliminateLevelView then
		gohelper.setActive(arg_36_0.viewGO, false)
	end
end

function var_0_0._onCloseFullView(arg_37_0, arg_37_1)
	if arg_37_1 == ViewName.EliminateLevelView then
		gohelper.setActive(arg_37_0.viewGO, true)
	end
end

function var_0_0.onClose(arg_38_0)
	arg_38_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_38_0._onCloseView, arg_38_0)
end

function var_0_0.onDestroyView(arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0._obtainFinished, arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0._refreshPointReward, arg_39_0)
end

return var_0_0
