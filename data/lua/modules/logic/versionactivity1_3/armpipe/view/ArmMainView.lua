module("modules.logic.versionactivity1_3.armpipe.view.ArmMainView", package.seeall)

slot0 = class("ArmMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageCircleDec = gohelper.findChildSingleImage(slot0.viewGO, "#simage_CircleDec")
	slot0._simageArmUnFixed = gohelper.findChildSingleImage(slot0.viewGO, "UnFixed/#simage_ArmUnFixed")
	slot0._imageAllFixedTxt = gohelper.findChildImage(slot0.viewGO, "Fixed/image_AllFixedTxt")
	slot0._txtAllFixed = gohelper.findChildText(slot0.viewGO, "Fixed/txt_AllFixed")
	slot0._btnRewardBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "LeftBottom/#btn_RewardBtn")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "RightTop/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "RightTop/LimitTime/#txt_LimitTime")
	slot0._btnInVisibleBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightBottom/#btn_InVisibleBtn")
	slot0._btnshowAllUI = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_showAllUI")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnRewardBtn:AddClickListener(slot0._btnRewardBtnOnClick, slot0)
	slot0._btnInVisibleBtn:AddClickListener(slot0._btnInVisibleBtnOnClick, slot0)
	slot0._btnshowAllUI:AddClickListener(slot0._btnshowAllUIOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnRewardBtn:RemoveClickListener()
	slot0._btnInVisibleBtn:RemoveClickListener()
	slot0._btnshowAllUI:RemoveClickListener()
end

function slot0._btnRewardBtnOnClick(slot0)
	ViewMgr.instance:openView(ViewName.ArmRewardView)
end

function slot0._btnInVisibleBtnOnClick(slot0)
	slot0._isTouchInVisibleBtn = true

	if not slot0._isTouchInVisibleBtn then
		slot0:refreshUI()
	end

	slot0:_setIsHidUI(true)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_button_display)
end

function slot0._btnshowAllUIOnClick(slot0)
	slot0:_setIsHidUI(false)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_repair_complete)
end

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_fullbg"))
	slot0._simageCircleDec:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_bgcircledec3"))
	slot0._simageArmUnFixed:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_unfixedarm"))
	gohelper.setActive(slot0._btnshowAllUI, false)

	slot0._isTouchInVisibleBtn = false
	slot0._partItemTbList = {}
	slot0._viewAnimator = slot0.viewGO:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	slot0._fixedAnimator = gohelper.findChild(slot0.viewGO, "Fixed"):GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	slot0._cfgList = Activity124Config.instance:getEpisodeList(VersionActivity1_3Enum.ActivityId.Act305)
	slot0._lockPartEndTime = 0

	for slot6 = 1, 6 do
		table.insert(slot0._partItemTbList, slot0:_createPartItemTb(gohelper.findChild(slot0.viewGO, string.format("Part/Part%s", slot6)), slot2[slot6]))
	end
end

function slot0._createPartItemTb(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.go = slot1
	slot3.goState = gohelper.findChild(slot1, "State")
	slot3.goLocked = gohelper.findChild(slot1, "State/Locked")
	slot3.goUnFixed = gohelper.findChild(slot1, "State/UnFixed")
	slot3.goFixed = gohelper.findChild(slot1, "State/Fixed")
	slot3.btnLocked = gohelper.findChildButtonWithAudio(slot1, "State/Locked/btn_locked")
	slot3.btnFixed = gohelper.findChildButtonWithAudio(slot1, "State/Fixed/btn_fiexd")
	slot3.goUnlockTips = gohelper.findChild(slot1, "State/image_UnlockTips")
	slot3.btnUnFixed = gohelper.findChildButtonWithAudio(slot1, "State/UnFixed")
	slot3.txtUnlockTxt = gohelper.findChildText(slot1, "State/image_UnlockTips/#txt_UnlockTxt")
	slot3.txtLockedName = gohelper.findChildText(slot1, "State/Locked/txt_Fixed")
	slot3.txtUnLockedName = gohelper.findChildText(slot1, "State/UnFixed/txt_Fixed")
	slot3.stateAnimator = slot3.goState:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	slot3.episodeCo = slot2
	slot3.id = slot2 and slot2.episodeId or 0
	slot3.preId = slot2 and slot2.preEpisode or 0

	if slot2 then
		slot3.txtLockedName.text = slot2.name
		slot3.txtUnLockedName.text = slot2.name
	end

	slot3.btnFixed:AddClickListener(slot0._btnPartItemOnClick, slot0, slot3)
	slot3.btnUnFixed:AddClickListener(slot0._btnPartItemOnClick, slot0, slot3)
	slot3.btnLocked:AddClickListener(slot0._btnPartItemOnClick, slot0, slot3)

	return slot3
end

function slot0._updateStatePartItemTb(slot0, slot1, slot2)
	slot4 = true
	slot5 = 0

	if not slot0:_isEpisodeClear(slot1.id) then
		slot4, slot5 = ArmPuzzleHelper.isOpenDay(slot1.id)
	end

	slot1.isClear = slot3
	slot1.isOpen = slot4
	slot1.cdTime = slot5

	slot0:_refreshPartItemUIByParams(slot1, slot3, slot4, slot5, slot2)

	return slot1
end

function slot0._playStatePartItemTbAnim(slot0, slot1, slot2, slot3)
	if slot3 or slot2 ~= slot1.lastAnimName then
		slot1.lastAnimName = slot2

		slot1.stateAnimator:Play(slot2, 0, slot3 and 0 or 1)
	end
end

function slot0._refreshPartItemUIByParams(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = not slot2 and slot4 and slot4 > 0

	gohelper.setActive(slot1.goLocked, not slot3)
	gohelper.setActive(slot1.goUnlockTips, slot6)
	gohelper.setActive(slot1.goFixed, slot3 and slot2)
	gohelper.setActive(slot1.goUnFixed, slot3 and not slot2)

	if slot6 then
		slot1.txtUnlockTxt.text = ArmPuzzleHelper.formatCdLock(slot4)
	end

	slot0:_playStatePartItemTbAnim(slot1, slot2 and "fixed" or slot3 and "unfixed" or "locked", slot5)
end

function slot0._lockPartItemTb(slot0, slot1, slot2)
	slot0:_refreshPartItemUIByParams(slot1, false, false, slot1.cdTime, slot2)
end

function slot0._unlockPartItemTb(slot0, slot1, slot2)
	slot0:_refreshPartItemUIByParams(slot1, false, true, 0, slot2)
end

function slot0._isEpisodeClear(slot0, slot1)
	return Activity124Model.instance:isEpisodeClear(VersionActivity1_3Enum.ActivityId.Act305, slot1)
end

function slot0._checkAutoReward(slot0)
	for slot4, slot5 in ipairs(slot0._cfgList) do
		if Activity124Model.instance:isHasReard(slot5.activityId, slot5.episodeId) then
			Activity124Rpc.instance:sendReceiveAct124RewardRequest(slot5.activityId, slot5.episodeId)
		end
	end
end

function slot0._getFixedAnimName(slot0)
	for slot5 = 1, #slot0._cfgList do
		if slot0:_isEpisodeClear(slot0._cfgList[slot5].episodeId) then
			slot1 = 0 + 1
		else
			break
		end
	end

	if slot1 > 0 then
		return "unlock" .. slot1
	end

	return "idle"
end

function slot0._setIsHidUI(slot0, slot1)
	slot0._viewAnimator:Play(slot1 and "go" or "back")
	gohelper.setActive(slot0._btnshowAllUI, slot1)
end

function slot0._setLockPartTime(slot0, slot1)
	slot0._lockPartEndTime = Time.time + math.min(slot1, 3)
end

function slot0._btnPartItemOnClick(slot0, slot1)
	if Time.time < slot0._lockPartEndTime then
		return
	end

	if slot1.isClear or slot1.isOpen then
		ArmPuzzlePipeController.instance:openGame(Activity124Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act305, slot1.id))
	else
		slot3, slot4 = ArmPuzzleHelper.isOpenDay(slot1.id)

		if slot4 and slot4 > 0 then
			GameFacade.showToast(ToastEnum.Va3Act124EpisodeNotOpenTime, ArmPuzzleHelper.formatCdTime(slot4))
		else
			GameFacade.showToast(ToastEnum.Va3Act124PreEpisodeNotOpen, Activity124Config.instance:getEpisodeCo(slot2, slot1.preId) and slot5.name or slot1.preId)
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshMapData, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshEpisode, slot0._onRefreshEpisode, slot0)
	slot0:addEventCb(Activity124Controller.instance, ArmPuzzlePipeEvent.EpisodeFiexdAnim, slot0._onEpisodeFiexdAnim, slot0)
	slot0._fixedAnimator:Play(slot0:_getFixedAnimName())
	slot0:refreshUI()
	slot0:_refreshCDTime()
	TaskDispatcher.runRepeat(slot0._refreshCDTime, slot0, 60)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_lefthand_open)
	slot0:_setLockPartTime(ArmPuzzlePipeEnum.AnimatorTime.OpenView)

	if slot0:_fineNewUnLockItem() then
		slot0:_lockPartItemTb(slot1)

		slot0._delayFiexdEpisodeId = slot1.id

		slot0:_setLockPartTime(ArmPuzzlePipeEnum.AnimatorTime.OpenView + ArmPuzzlePipeEnum.AnimatorTime.UnFixedTime)
		TaskDispatcher.runDelay(slot0._onFiexdAnimAfter, slot0, ArmPuzzlePipeEnum.AnimatorTime.OpenView)
	end

	TaskDispatcher.runDelay(slot0._checkAutoReward, slot0, 1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshCDTime, slot0)
	TaskDispatcher.cancelTask(slot0._onFiexdAnimAfter, slot0)
	TaskDispatcher.cancelTask(slot0._checkAutoReward, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simageCircleDec:UnLoadImage()
	slot0._simageArmUnFixed:UnLoadImage()

	if slot0._partItemTbList then
		for slot4 = 1, #slot0._partItemTbList do
			slot5 = slot0._partItemTbList[slot4]

			slot5.btnUnFixed:RemoveClickListener()
			slot5.btnFixed:RemoveClickListener()
			slot5.btnLocked:RemoveClickListener()
		end

		slot0._partItemTbList = nil
	end
end

function slot0._onRefreshEpisode(slot0)
	slot0:refreshUI()
end

function slot0._onEpisodeFiexdAnim(slot0, slot1)
	if slot0:_getItemTbById(slot1) then
		slot0:_updateStatePartItemTb(slot2, true)
		slot0._fixedAnimator:Play(slot0:_getFixedAnimName(), 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_inking_preference_open)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_arm_repair)

		if slot0:_getItemTbById(slot1, true) then
			slot0._delayFiexdEpisodeId = slot3.id

			slot0:_setLockPartTime(ArmPuzzlePipeEnum.AnimatorTime.WaitUnFixedTime + ArmPuzzlePipeEnum.AnimatorTime.UnFixedTime)
			TaskDispatcher.cancelTask(slot0._onFiexdAnimAfter, slot0)
			TaskDispatcher.runDelay(slot0._onFiexdAnimAfter, slot0, ArmPuzzlePipeEnum.AnimatorTime.WaitUnFixedTime)
		end
	end
end

function slot0._onFiexdAnimAfter(slot0)
	slot0._delayFiexdEpisodeId = nil

	slot0:_refreshFinishAllUI()

	if slot0:_getItemTbById(slot0._delayFiexdEpisodeId) then
		slot3, slot4 = ArmPuzzleHelper.isOpenDay(slot2.id)

		if slot3 then
			slot0:_updateStatePartItemTb(slot2, true)
			AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_checkpoint_unlock)
			slot0:_setUnLockAnim(slot2.id)
		end
	end
end

function slot0._getItemTbById(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._partItemTbList) do
		if slot2 then
			if slot1 == slot7.preId then
				return slot7
			end
		elseif slot1 == slot7.id then
			return slot7
		end
	end
end

function slot0._fineNewUnLockItem(slot0)
	if not slot0._partItemTbList then
		return
	end

	for slot4, slot5 in ipairs(slot0._partItemTbList) do
		if not slot5.isClear and slot5.isOpen and not slot0:_isPlayedUnLock(slot5.id) then
			return slot5
		end
	end
end

function slot0.refreshUI(slot0)
	if slot0._partItemTbList then
		for slot4, slot5 in ipairs(slot0._partItemTbList) do
			slot0:_updateStatePartItemTb(slot5)
		end
	end

	slot0:_refreshFinishAllUI()
end

function slot0._refreshFinishAllUI(slot0)
	slot1 = slot0:_isFinishAll()

	gohelper.setActive(slot0._btnInVisibleBtn, slot1)
	gohelper.setActive(slot0._imageAllFixedTxt, slot1 and slot0._isTouchInVisibleBtn)
	gohelper.setActive(slot0._txtAllFixed, slot1 and slot0._isTouchInVisibleBtn)
end

function slot0._isFinishAll(slot0)
	if not slot0._partItemTbList then
		return false
	end

	for slot4, slot5 in ipairs(slot0._partItemTbList) do
		if not slot5.isClear then
			return false
		end
	end

	return true
end

function slot0._refreshCDTime(slot0)
	if not ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act305) then
		return
	end

	slot0._txtLimitTime.text = string.format(luaLang("remain"), ArmPuzzleHelper.formatCdTime(slot1:getRealEndTimeStamp() - ServerTime.now()))

	if slot0._partItemTbList then
		slot3 = false

		for slot7, slot8 in ipairs(slot0._partItemTbList) do
			if not slot8.isClear and not slot8.isOpen and slot0._delayFiexdEpisodeId ~= slot8.preId then
				slot0:_updateStatePartItemTb(slot8)

				if slot8.isOpen then
					slot3 = true

					slot0:_playStatePartItemTbAnim(slot8, true)
					AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_checkpoint_unlock)
					slot0:_setUnLockAnim(slot8.id)
				end
			end
		end

		if slot3 then
			Activity124Rpc.instance:sendGetAct124InfosRequest(VersionActivity1_3Enum.ActivityId.Act305)
		end
	end
end

function slot0._isPlayedUnLock(slot0, slot1)
	return PlayerPrefsHelper.getNumber(slot0:_getLockAnimKey(slot1), 0) == 1
end

function slot0._getLockAnimKey(slot0, slot1)
	return string.format("ArmMainView_PLAY_UNLOCK_ANIM_KEY_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, VersionActivity1_3Enum.ActivityId.Act305, slot1)
end

function slot0._setUnLockAnim(slot0, slot1)
	return PlayerPrefsHelper.setNumber(slot0:_getLockAnimKey(slot1), 1)
end

return slot0
