module("modules.logic.versionactivity1_3.armpipe.view.ArmMainView", package.seeall)

local var_0_0 = class("ArmMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageCircleDec = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_CircleDec")
	arg_1_0._simageArmUnFixed = gohelper.findChildSingleImage(arg_1_0.viewGO, "UnFixed/#simage_ArmUnFixed")
	arg_1_0._imageAllFixedTxt = gohelper.findChildImage(arg_1_0.viewGO, "Fixed/image_AllFixedTxt")
	arg_1_0._txtAllFixed = gohelper.findChildText(arg_1_0.viewGO, "Fixed/txt_AllFixed")
	arg_1_0._btnRewardBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "LeftBottom/#btn_RewardBtn")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "RightTop/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "RightTop/LimitTime/#txt_LimitTime")
	arg_1_0._btnInVisibleBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightBottom/#btn_InVisibleBtn")
	arg_1_0._btnshowAllUI = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_showAllUI")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnRewardBtn:AddClickListener(arg_2_0._btnRewardBtnOnClick, arg_2_0)
	arg_2_0._btnInVisibleBtn:AddClickListener(arg_2_0._btnInVisibleBtnOnClick, arg_2_0)
	arg_2_0._btnshowAllUI:AddClickListener(arg_2_0._btnshowAllUIOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnRewardBtn:RemoveClickListener()
	arg_3_0._btnInVisibleBtn:RemoveClickListener()
	arg_3_0._btnshowAllUI:RemoveClickListener()
end

function var_0_0._btnRewardBtnOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.ArmRewardView)
end

function var_0_0._btnInVisibleBtnOnClick(arg_5_0)
	local var_5_0 = arg_5_0._isTouchInVisibleBtn

	arg_5_0._isTouchInVisibleBtn = true

	if not var_5_0 then
		arg_5_0:refreshUI()
	end

	arg_5_0:_setIsHidUI(true)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_button_display)
end

function var_0_0._btnshowAllUIOnClick(arg_6_0)
	arg_6_0:_setIsHidUI(false)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_repair_complete)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simageFullBG:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_fullbg"))
	arg_7_0._simageCircleDec:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_bgcircledec3"))
	arg_7_0._simageArmUnFixed:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_unfixedarm"))
	gohelper.setActive(arg_7_0._btnshowAllUI, false)

	arg_7_0._isTouchInVisibleBtn = false
	arg_7_0._partItemTbList = {}

	local var_7_0 = gohelper.findChild(arg_7_0.viewGO, "Fixed")

	arg_7_0._viewAnimator = arg_7_0.viewGO:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	arg_7_0._fixedAnimator = var_7_0:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)

	local var_7_1 = Activity124Config.instance:getEpisodeList(VersionActivity1_3Enum.ActivityId.Act305)

	arg_7_0._cfgList = var_7_1
	arg_7_0._lockPartEndTime = 0

	for iter_7_0 = 1, 6 do
		local var_7_2 = gohelper.findChild(arg_7_0.viewGO, string.format("Part/Part%s", iter_7_0))
		local var_7_3 = arg_7_0:_createPartItemTb(var_7_2, var_7_1[iter_7_0])

		table.insert(arg_7_0._partItemTbList, var_7_3)
	end
end

function var_0_0._createPartItemTb(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.go = arg_8_1
	var_8_0.goState = gohelper.findChild(arg_8_1, "State")
	var_8_0.goLocked = gohelper.findChild(arg_8_1, "State/Locked")
	var_8_0.goUnFixed = gohelper.findChild(arg_8_1, "State/UnFixed")
	var_8_0.goFixed = gohelper.findChild(arg_8_1, "State/Fixed")
	var_8_0.btnLocked = gohelper.findChildButtonWithAudio(arg_8_1, "State/Locked/btn_locked")
	var_8_0.btnFixed = gohelper.findChildButtonWithAudio(arg_8_1, "State/Fixed/btn_fiexd")
	var_8_0.goUnlockTips = gohelper.findChild(arg_8_1, "State/image_UnlockTips")
	var_8_0.btnUnFixed = gohelper.findChildButtonWithAudio(arg_8_1, "State/UnFixed")
	var_8_0.txtUnlockTxt = gohelper.findChildText(arg_8_1, "State/image_UnlockTips/#txt_UnlockTxt")
	var_8_0.txtLockedName = gohelper.findChildText(arg_8_1, "State/Locked/txt_Fixed")
	var_8_0.txtUnLockedName = gohelper.findChildText(arg_8_1, "State/UnFixed/txt_Fixed")
	var_8_0.stateAnimator = var_8_0.goState:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	var_8_0.episodeCo = arg_8_2
	var_8_0.id = arg_8_2 and arg_8_2.episodeId or 0
	var_8_0.preId = arg_8_2 and arg_8_2.preEpisode or 0

	if arg_8_2 then
		var_8_0.txtLockedName.text = arg_8_2.name
		var_8_0.txtUnLockedName.text = arg_8_2.name
	end

	var_8_0.btnFixed:AddClickListener(arg_8_0._btnPartItemOnClick, arg_8_0, var_8_0)
	var_8_0.btnUnFixed:AddClickListener(arg_8_0._btnPartItemOnClick, arg_8_0, var_8_0)
	var_8_0.btnLocked:AddClickListener(arg_8_0._btnPartItemOnClick, arg_8_0, var_8_0)

	return var_8_0
end

function var_0_0._updateStatePartItemTb(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:_isEpisodeClear(arg_9_1.id)
	local var_9_1 = true
	local var_9_2 = 0

	if not var_9_0 then
		var_9_1, var_9_2 = ArmPuzzleHelper.isOpenDay(arg_9_1.id)
	end

	arg_9_1.isClear = var_9_0
	arg_9_1.isOpen = var_9_1
	arg_9_1.cdTime = var_9_2

	arg_9_0:_refreshPartItemUIByParams(arg_9_1, var_9_0, var_9_1, var_9_2, arg_9_2)

	return arg_9_1
end

function var_0_0._playStatePartItemTbAnim(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3 or arg_10_2 ~= arg_10_1.lastAnimName then
		arg_10_1.lastAnimName = arg_10_2

		arg_10_1.stateAnimator:Play(arg_10_2, 0, arg_10_3 and 0 or 1)
	end
end

function var_0_0._refreshPartItemUIByParams(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = not arg_11_2 and arg_11_4 and arg_11_4 > 0

	gohelper.setActive(arg_11_1.goLocked, not arg_11_3)
	gohelper.setActive(arg_11_1.goUnlockTips, var_11_0)
	gohelper.setActive(arg_11_1.goFixed, arg_11_3 and arg_11_2)
	gohelper.setActive(arg_11_1.goUnFixed, arg_11_3 and not arg_11_2)

	if var_11_0 then
		arg_11_1.txtUnlockTxt.text = ArmPuzzleHelper.formatCdLock(arg_11_4)
	end

	local var_11_1 = arg_11_2 and "fixed" or arg_11_3 and "unfixed" or "locked"

	arg_11_0:_playStatePartItemTbAnim(arg_11_1, var_11_1, arg_11_5)
end

function var_0_0._lockPartItemTb(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:_refreshPartItemUIByParams(arg_12_1, false, false, arg_12_1.cdTime, arg_12_2)
end

function var_0_0._unlockPartItemTb(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:_refreshPartItemUIByParams(arg_13_1, false, true, 0, arg_13_2)
end

function var_0_0._isEpisodeClear(arg_14_0, arg_14_1)
	return Activity124Model.instance:isEpisodeClear(VersionActivity1_3Enum.ActivityId.Act305, arg_14_1)
end

function var_0_0._checkAutoReward(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._cfgList) do
		if Activity124Model.instance:isHasReard(iter_15_1.activityId, iter_15_1.episodeId) then
			Activity124Rpc.instance:sendReceiveAct124RewardRequest(iter_15_1.activityId, iter_15_1.episodeId)
		end
	end
end

function var_0_0._getFixedAnimName(arg_16_0)
	local var_16_0 = 0

	for iter_16_0 = 1, #arg_16_0._cfgList do
		if arg_16_0:_isEpisodeClear(arg_16_0._cfgList[iter_16_0].episodeId) then
			var_16_0 = var_16_0 + 1
		else
			break
		end
	end

	if var_16_0 > 0 then
		return "unlock" .. var_16_0
	end

	return "idle"
end

function var_0_0._setIsHidUI(arg_17_0, arg_17_1)
	arg_17_0._viewAnimator:Play(arg_17_1 and "go" or "back")
	gohelper.setActive(arg_17_0._btnshowAllUI, arg_17_1)
end

function var_0_0._setLockPartTime(arg_18_0, arg_18_1)
	arg_18_0._lockPartEndTime = Time.time + math.min(arg_18_1, 3)
end

function var_0_0._btnPartItemOnClick(arg_19_0, arg_19_1)
	if arg_19_0._lockPartEndTime > Time.time then
		return
	end

	local var_19_0 = VersionActivity1_3Enum.ActivityId.Act305

	if arg_19_1.isClear or arg_19_1.isOpen then
		local var_19_1 = Activity124Config.instance:getEpisodeCo(var_19_0, arg_19_1.id)

		ArmPuzzlePipeController.instance:openGame(var_19_1)
	else
		local var_19_2, var_19_3 = ArmPuzzleHelper.isOpenDay(arg_19_1.id)

		if var_19_3 and var_19_3 > 0 then
			GameFacade.showToast(ToastEnum.Va3Act124EpisodeNotOpenTime, ArmPuzzleHelper.formatCdTime(var_19_3))
		else
			local var_19_4 = Activity124Config.instance:getEpisodeCo(var_19_0, arg_19_1.preId)

			GameFacade.showToast(ToastEnum.Va3Act124PreEpisodeNotOpen, var_19_4 and var_19_4.name or arg_19_1.preId)
		end
	end
end

function var_0_0.onUpdateParam(arg_20_0)
	return
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0:addEventCb(Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshMapData, arg_21_0.refreshUI, arg_21_0)
	arg_21_0:addEventCb(Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshEpisode, arg_21_0._onRefreshEpisode, arg_21_0)
	arg_21_0:addEventCb(Activity124Controller.instance, ArmPuzzlePipeEvent.EpisodeFiexdAnim, arg_21_0._onEpisodeFiexdAnim, arg_21_0)
	arg_21_0._fixedAnimator:Play(arg_21_0:_getFixedAnimName())
	arg_21_0:refreshUI()
	arg_21_0:_refreshCDTime()
	TaskDispatcher.runRepeat(arg_21_0._refreshCDTime, arg_21_0, 60)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_lefthand_open)
	arg_21_0:_setLockPartTime(ArmPuzzlePipeEnum.AnimatorTime.OpenView)

	local var_21_0 = arg_21_0:_fineNewUnLockItem()

	if var_21_0 then
		arg_21_0:_lockPartItemTb(var_21_0)

		arg_21_0._delayFiexdEpisodeId = var_21_0.id

		arg_21_0:_setLockPartTime(ArmPuzzlePipeEnum.AnimatorTime.OpenView + ArmPuzzlePipeEnum.AnimatorTime.UnFixedTime)
		TaskDispatcher.runDelay(arg_21_0._onFiexdAnimAfter, arg_21_0, ArmPuzzlePipeEnum.AnimatorTime.OpenView)
	end

	TaskDispatcher.runDelay(arg_21_0._checkAutoReward, arg_21_0, 1)
end

function var_0_0.onClose(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._refreshCDTime, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._onFiexdAnimAfter, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._checkAutoReward, arg_22_0)
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0._simageFullBG:UnLoadImage()
	arg_23_0._simageCircleDec:UnLoadImage()
	arg_23_0._simageArmUnFixed:UnLoadImage()

	if arg_23_0._partItemTbList then
		for iter_23_0 = 1, #arg_23_0._partItemTbList do
			local var_23_0 = arg_23_0._partItemTbList[iter_23_0]

			var_23_0.btnUnFixed:RemoveClickListener()
			var_23_0.btnFixed:RemoveClickListener()
			var_23_0.btnLocked:RemoveClickListener()
		end

		arg_23_0._partItemTbList = nil
	end
end

function var_0_0._onRefreshEpisode(arg_24_0)
	arg_24_0:refreshUI()
end

function var_0_0._onEpisodeFiexdAnim(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:_getItemTbById(arg_25_1)

	if var_25_0 then
		arg_25_0:_updateStatePartItemTb(var_25_0, true)
		arg_25_0._fixedAnimator:Play(arg_25_0:_getFixedAnimName(), 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_inking_preference_open)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_arm_repair)

		local var_25_1 = arg_25_0:_getItemTbById(arg_25_1, true)

		if var_25_1 then
			arg_25_0._delayFiexdEpisodeId = var_25_1.id

			arg_25_0:_setLockPartTime(ArmPuzzlePipeEnum.AnimatorTime.WaitUnFixedTime + ArmPuzzlePipeEnum.AnimatorTime.UnFixedTime)
			TaskDispatcher.cancelTask(arg_25_0._onFiexdAnimAfter, arg_25_0)
			TaskDispatcher.runDelay(arg_25_0._onFiexdAnimAfter, arg_25_0, ArmPuzzlePipeEnum.AnimatorTime.WaitUnFixedTime)
		end
	end
end

function var_0_0._onFiexdAnimAfter(arg_26_0)
	local var_26_0 = arg_26_0._delayFiexdEpisodeId

	arg_26_0._delayFiexdEpisodeId = nil

	arg_26_0:_refreshFinishAllUI()

	local var_26_1 = arg_26_0:_getItemTbById(var_26_0)

	if var_26_1 then
		local var_26_2, var_26_3 = ArmPuzzleHelper.isOpenDay(var_26_1.id)

		if var_26_2 then
			arg_26_0:_updateStatePartItemTb(var_26_1, true)
			AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_checkpoint_unlock)
			arg_26_0:_setUnLockAnim(var_26_1.id)
		end
	end
end

function var_0_0._getItemTbById(arg_27_0, arg_27_1, arg_27_2)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0._partItemTbList) do
		if arg_27_2 then
			if arg_27_1 == iter_27_1.preId then
				return iter_27_1
			end
		elseif arg_27_1 == iter_27_1.id then
			return iter_27_1
		end
	end
end

function var_0_0._fineNewUnLockItem(arg_28_0)
	if not arg_28_0._partItemTbList then
		return
	end

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._partItemTbList) do
		if not iter_28_1.isClear and iter_28_1.isOpen and not arg_28_0:_isPlayedUnLock(iter_28_1.id) then
			return iter_28_1
		end
	end
end

function var_0_0.refreshUI(arg_29_0)
	if arg_29_0._partItemTbList then
		for iter_29_0, iter_29_1 in ipairs(arg_29_0._partItemTbList) do
			arg_29_0:_updateStatePartItemTb(iter_29_1)
		end
	end

	arg_29_0:_refreshFinishAllUI()
end

function var_0_0._refreshFinishAllUI(arg_30_0)
	local var_30_0 = arg_30_0:_isFinishAll()

	gohelper.setActive(arg_30_0._btnInVisibleBtn, var_30_0)
	gohelper.setActive(arg_30_0._imageAllFixedTxt, var_30_0 and arg_30_0._isTouchInVisibleBtn)
	gohelper.setActive(arg_30_0._txtAllFixed, var_30_0 and arg_30_0._isTouchInVisibleBtn)
end

function var_0_0._isFinishAll(arg_31_0)
	if not arg_31_0._partItemTbList then
		return false
	end

	for iter_31_0, iter_31_1 in ipairs(arg_31_0._partItemTbList) do
		if not iter_31_1.isClear then
			return false
		end
	end

	return true
end

function var_0_0._refreshCDTime(arg_32_0)
	local var_32_0 = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act305)

	if not var_32_0 then
		return
	end

	local var_32_1 = var_32_0:getRealEndTimeStamp() - ServerTime.now()

	arg_32_0._txtLimitTime.text = string.format(luaLang("remain"), ArmPuzzleHelper.formatCdTime(var_32_1))

	if arg_32_0._partItemTbList then
		local var_32_2 = false

		for iter_32_0, iter_32_1 in ipairs(arg_32_0._partItemTbList) do
			if not iter_32_1.isClear and not iter_32_1.isOpen and arg_32_0._delayFiexdEpisodeId ~= iter_32_1.preId then
				arg_32_0:_updateStatePartItemTb(iter_32_1)

				if iter_32_1.isOpen then
					var_32_2 = true

					arg_32_0:_playStatePartItemTbAnim(iter_32_1, true)
					AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_checkpoint_unlock)
					arg_32_0:_setUnLockAnim(iter_32_1.id)
				end
			end
		end

		if var_32_2 then
			Activity124Rpc.instance:sendGetAct124InfosRequest(VersionActivity1_3Enum.ActivityId.Act305)
		end
	end
end

function var_0_0._isPlayedUnLock(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:_getLockAnimKey(arg_33_1)

	return PlayerPrefsHelper.getNumber(var_33_0, 0) == 1
end

function var_0_0._getLockAnimKey(arg_34_0, arg_34_1)
	local var_34_0 = PlayerModel.instance:getPlayinfo().userId
	local var_34_1 = VersionActivity1_3Enum.ActivityId.Act305

	return string.format("ArmMainView_PLAY_UNLOCK_ANIM_KEY_%s_%s_%s", var_34_0, var_34_1, arg_34_1)
end

function var_0_0._setUnLockAnim(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:_getLockAnimKey(arg_35_1)

	return PlayerPrefsHelper.setNumber(var_35_0, 1)
end

return var_0_0
