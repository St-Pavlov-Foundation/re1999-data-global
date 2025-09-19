module("modules.logic.versionactivity2_8.act200.view.Activity2ndTakePhotosView", package.seeall)

local var_0_0 = class("Activity2ndTakePhotosView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "#go_category")
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_category/#scroll_category")
	arg_1_0._gocategorycontent = gohelper.findChild(arg_1_0.viewGO, "#go_category/#scroll_category/viewport/content")
	arg_1_0._gocategoryitem = gohelper.findChild(arg_1_0.viewGO, "#go_category/#scroll_category/viewport/content/#go_categoryitem")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "#txt_LimitTime")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "Bottom/txt_dec")
	arg_1_0._simagephoto = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_photo")
	arg_1_0._btnshot = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_shot")
	arg_1_0._simageframe = gohelper.findChildSingleImage(arg_1_0.viewGO, "Success/#simage_frame")
	arg_1_0._simagesuccessphoto = gohelper.findChildSingleImage(arg_1_0.viewGO, "Success/#simage_photo")
	arg_1_0._goshoted = gohelper.findChild(arg_1_0.viewGO, "Success/#go_shoted")
	arg_1_0._simagephotoSmall = gohelper.findChildSingleImage(arg_1_0.viewGO, "Bottom/#simage_photoSmall")
	arg_1_0._gorewardicon = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_rewarditem/go_icon")
	arg_1_0._gorewardreceive = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_rewarditem/go_receive")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_rewarditem")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "Success")
	arg_1_0._goerror = gohelper.findChild(arg_1_0.viewGO, "Fail")
	arg_1_0._goshotframe = gohelper.findChild(arg_1_0.viewGO, "#simage_photo/shotFrame")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#simage_photo/shotFrame/normal")
	arg_1_0._gowrong = gohelper.findChild(arg_1_0.viewGO, "#simage_photo/shotFrame/wrong")
	arg_1_0._btnclickphoto = gohelper.findChildButton(arg_1_0.viewGO, "#simage_photo/#btn_clickpoto")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._shotAnimator = arg_1_0._gonormal:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._successAnimator = arg_1_0._gosuccess:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_1_0._gocategoryitem, false)

	arg_1_0._categoryitemList = {}
	arg_1_0._showErrorTime = 2
	arg_1_0._switchAnimTime = 0.5
	arg_1_0._shotFocusTime = 0.25
	arg_1_0._successTime = 1.5
	arg_1_0._isError = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshot:AddClickListener(arg_2_0._btnshotOnClick, arg_2_0)
	arg_2_0._btnclickphoto:AddClickListener(arg_2_0._clickPhoto, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onRewardRefresh, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivity, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshot:RemoveClickListener()
	arg_3_0._btnclickphoto:RemoveClickListener()
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onRewardRefresh, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0._btnshotOnClick(arg_4_0)
	local var_4_0 = false
	local var_4_1 = not string.nilorempty(arg_4_0.config.position) and string.splitToNumber(arg_4_0.config.position, "#")
	local var_4_2 = {
		x = var_4_1[1],
		y = var_4_1[2]
	}

	if Activity2ndTakePhotosHelper.checkPhotoAreaMoreGoal(arg_4_0.rectshotframe, var_4_2) then
		gohelper.setActive(arg_4_0._gosuccess, true)
		arg_4_0._successAnimator:Play("open", 0, 0)
		arg_4_0:_refreshPhotoPanel(true)
		TaskDispatcher.runDelay(arg_4_0._showSuccess, arg_4_0, arg_4_0._successTime)
		Activity2ndController.instance:statTakePhotos(arg_4_0._currentIndex, true)
		AudioMgr.instance:trigger(AudioEnum2_8.TakePhotosActivity.play_ui_diqiu_yure_success_20249043)
	else
		arg_4_0._isError = true

		gohelper.setActive(arg_4_0._goerror, true)
		gohelper.setActive(arg_4_0._gonormal, false)
		gohelper.setActive(arg_4_0._gowrong, true)
		TaskDispatcher.runDelay(arg_4_0._showError, arg_4_0, arg_4_0._showErrorTime)
		Activity2ndController.instance:statTakePhotos(arg_4_0._currentIndex, false)
		AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_wrong)
	end
end

function var_0_0._showSuccess(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._showSuccess, arg_5_0)
	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(arg_5_0._actId, arg_5_0._currentIndex, 0)
end

function var_0_0._showError(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._showError, arg_6_0)

	arg_6_0._isError = false

	gohelper.setActive(arg_6_0._goerror, false)
	gohelper.setActive(arg_6_0._gonormal, true)
	gohelper.setActive(arg_6_0._gowrong, false)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.rectSimagePhoto = arg_7_0._simagephoto.transform
	arg_7_0.rectshotframe = arg_7_0._goshotframe.transform

	recthelper.setAnchor(arg_7_0.rectshotframe, 0, 0)
end

function var_0_0._initCategoryItem(arg_8_0)
	local var_8_0 = Activity2ndConfig.instance:getAct200ConfigList()

	if not var_8_0 then
		return logError("没有拍照活动配置")
	end

	local var_8_1 = 30
	local var_8_2 = 50
	local var_8_3 = 46

	arg_8_0.scrollHeight = recthelper.getHeight(arg_8_0._scrollcategory.transform)
	arg_8_0._itemHeight = 120
	arg_8_0._selectItemHeight = 132

	local var_8_4 = #var_8_0

	arg_8_0._contentHeight = arg_8_0._selectItemHeight + arg_8_0._itemHeight * (var_8_4 - 1) + (var_8_4 - 1) * var_8_3 + var_8_1 + var_8_2
	arg_8_0._canMoveHeight = math.max(0, arg_8_0._contentHeight - arg_8_0.scrollHeight)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not arg_8_0._categoryitemList[iter_8_0] then
			local var_8_5 = arg_8_0:getUserDataTb_()

			var_8_5.co = iter_8_1
			var_8_5.index = iter_8_0
			var_8_5.go = gohelper.clone(arg_8_0._gocategoryitem, arg_8_0._gocategorycontent, "categoryitem" .. iter_8_0)
			var_8_5.goselect = gohelper.findChild(var_8_5.go, "#go_select")
			var_8_5.txtselect = gohelper.findChildText(var_8_5.go, "#go_select/#txt_select")
			var_8_5.gounselect = gohelper.findChild(var_8_5.go, "#txt_unselect")
			var_8_5.txtunselect = gohelper.findChildText(var_8_5.go, "#txt_unselect")
			var_8_5.golocked = gohelper.findChild(var_8_5.go, "#txt_locked")
			var_8_5.txtlocked = gohelper.findChildText(var_8_5.go, "#txt_locked")
			var_8_5.btnclick = gohelper.findChildButtonWithAudio(var_8_5.go, "#btn_click")

			var_8_5.btnclick:AddClickListener(arg_8_0._clickCategoryItem, arg_8_0, var_8_5)
			gohelper.setActive(var_8_5.go, true)
			table.insert(arg_8_0._categoryitemList, var_8_5)
		end
	end

	arg_8_0:_autoSelectTab()
end

function var_0_0._clickCategoryItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.index
	local var_9_1 = arg_9_0:getCurSelectedEpisode()
	local var_9_2, var_9_3, var_9_4 = Activity125Model.instance:isEpisodeDayOpen(arg_9_0._actId, var_9_0)

	if not var_9_2 then
		if var_9_3 < 1 then
			local var_9_5, var_9_6 = TimeUtil.secondToRoughTime2(var_9_4)
			local var_9_7 = var_9_5 .. var_9_6

			GameFacade.showToastString(formatLuaLang("season123_overview_unlocktime_custom", var_9_7))
		else
			GameFacade.showToast(ToastEnum.TakePhotoUnlockDay, var_9_3)
		end

		return
	end

	if not Activity125Model.instance:isEpisodeUnLock(arg_9_0._actId, var_9_0) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	if var_9_1 ~= var_9_0 then
		Activity125Model.instance:setSelectEpisodeId(arg_9_0._actId, var_9_0)

		arg_9_0._currentIndex = var_9_0

		arg_9_0._animator:Play("switch", 0, 0)
		arg_9_0:_refreshItemList()
		arg_9_0:_initPanelState()
		TaskDispatcher.runDelay(arg_9_0._onSwitchFinish, arg_9_0, arg_9_0._switchAnimTime)
		AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)
	end
end

function var_0_0._onSwitchFinish(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onSwitchFinish, arg_10_0)
	arg_10_0:_refreshUI()
	TaskDispatcher.runDelay(arg_10_0._onOpenFinish, arg_10_0, arg_10_0._shotFocusTime)
	recthelper.setAnchor(arg_10_0.rectshotframe, 0, 0)
end

function var_0_0._initPanelState(arg_11_0)
	gohelper.setActive(arg_11_0._gosuccess, false)
end

function var_0_0._refreshCategoryItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.index == arg_12_0:getCurSelectedEpisode()
	local var_12_1, var_12_2, var_12_3 = Activity125Model.instance:isEpisodeDayOpen(arg_12_0._actId, arg_12_1.index)
	local var_12_4 = Activity125Model.instance:isEpisodeFinished(arg_12_0._actId, arg_12_1.index)

	gohelper.setActive(arg_12_1.goselect, var_12_0 and var_12_1)
	gohelper.setActive(arg_12_1.gounselect, not var_12_0 and var_12_1)
	gohelper.setActive(arg_12_1.golocked, not var_12_1)

	local var_12_5 = var_12_4 and "#c66030" or "D7D7D7"

	arg_12_1.txtselect.color = GameUtil.parseColor(var_12_5)
	arg_12_1.txtselect.text = arg_12_1.co.name
	arg_12_1.txtunselect.text = arg_12_1.co.name
	arg_12_1.txtunselect.color = GameUtil.parseColor(var_12_5)

	if not var_12_1 then
		arg_12_1.txtlocked.text = formatLuaLang("versionactivity_1_2_119_unlock", var_12_2)

		if var_12_2 < 1 then
			local var_12_6, var_12_7 = TimeUtil.secondToRoughTime2(var_12_3)
			local var_12_8 = var_12_6 .. var_12_7

			arg_12_1.txtlocked.text = formatLuaLang("season123_overview_unlocktime_custom", var_12_8)
		end
	end
end

function var_0_0._refreshItemList(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._categoryitemList) do
		arg_13_0:_refreshCategoryItem(iter_13_1)
	end
end

function var_0_0._refreshPhotoPanel(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 and true or Activity125Model.instance:isEpisodeFinished(arg_14_0._actId, arg_14_0:getCurSelectedEpisode())

	gohelper.setActive(arg_14_0._gosuccess, var_14_0)
	gohelper.setActive(arg_14_0._btnshot.gameObject, not var_14_0)
	gohelper.setActive(arg_14_0._goshotframe, not var_14_0)

	local var_14_1 = "v2a8_gift_photo_"
	local var_14_2 = "v2a8_gift_smallphoto_"

	var_14_1 = var_14_0 and var_14_1 .. arg_14_0._currentIndex .. "_1" .. ".jpg" or var_14_1 .. arg_14_0._currentIndex .. ".jpg"
	var_14_2 = var_14_0 and var_14_2 .. arg_14_0._currentIndex .. "_1" .. ".png" or var_14_2 .. arg_14_0._currentIndex .. ".png"

	if var_14_0 then
		arg_14_0._simagesuccessphoto:LoadImage(ResUrl.getActivity2ndTakePhotoSingleBg(var_14_1))
	end

	arg_14_0._simagephoto:LoadImage(ResUrl.getActivity2ndTakePhotoSingleBg(var_14_1))
	arg_14_0._simagephotoSmall:LoadImage(ResUrl.getActivity2ndTakePhotoSingleBg(var_14_2))

	arg_14_0._txtdesc.text = var_14_0 and arg_14_0.config.text or luaLang("p_v2a8_gift_fullview_txt_dec")
end

function var_0_0._refreshReward(arg_15_0)
	local var_15_0 = Activity125Model.instance:isEpisodeFinished(arg_15_0._actId, arg_15_0:getCurSelectedEpisode())

	arg_15_0.rewardcomp = arg_15_0.rewardcomp or IconMgr.instance:getCommonPropItemIcon(arg_15_0._gorewardicon)

	local var_15_1 = arg_15_0.config and arg_15_0.config.bonus

	if var_15_1 and not string.nilorempty(var_15_1) then
		local var_15_2 = string.splitToNumber(var_15_1, "#")

		arg_15_0.rewardcomp:setMOValue(var_15_2[1], var_15_2[2], var_15_2[3], nil, true)
	end

	gohelper.setActive(arg_15_0._gorewardreceive, var_15_0)
end

function var_0_0._refreshUI(arg_16_0)
	arg_16_0.config = Activity2ndConfig.instance:getAct200ConfigById(arg_16_0._currentIndex)
	arg_16_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_16_0._actId)

	arg_16_0:_refreshPhotoPanel()
	arg_16_0:_refreshItemList()
	arg_16_0:_refreshReward()

	if not arg_16_0.config then
		logError("没有关卡" .. arg_16_0._currentIndex .. "的配置")
	end
end

function var_0_0._onRewardRefresh(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.CommonPropView then
		gohelper.setActive(arg_17_0._gorewardreceive, true)
		arg_17_0:_refreshItemList()
		arg_17_0:_checkLastOpenIndexHeight()
	end
end

function var_0_0._checkLastOpenIndexHeight(arg_18_0)
	local var_18_0 = Activity125Model.instance:getById(arg_18_0._actId)
	local var_18_1 = recthelper.getAnchorY(arg_18_0._gocategorycontent.transform)
	local var_18_2 = var_18_0:getFirstRewardEpisode()
	local var_18_3 = 30
	local var_18_4 = 46
	local var_18_5 = 0

	if var_18_2 > 1 then
		var_18_5 = arg_18_0._selectItemHeight + arg_18_0._itemHeight * (var_18_2 - 2) + (var_18_2 - 1) * var_18_4 + var_18_3
	end

	if var_18_1 + var_18_5 > arg_18_0.scrollHeight then
		local var_18_6 = var_18_5 - arg_18_0.scrollHeight + var_18_1 + arg_18_0._itemHeight

		recthelper.setAnchorY(arg_18_0._gocategorycontent.transform, var_18_6)
	end
end

function var_0_0._clickPhoto(arg_19_0)
	arg_19_0._shotAnimator:Play("open", 0, 0)

	local var_19_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_19_0.rectSimagePhoto)

	arg_19_0:_checkShotFramePosAvailable(var_19_0)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_choose)
end

function var_0_0._checkShotFramePosAvailable(arg_20_0, arg_20_1)
	local var_20_0 = Activity2ndTakePhotosHelper.ClampPosition(arg_20_0.rectSimagePhoto, arg_20_0.rectshotframe, arg_20_1)

	recthelper.setAnchor(arg_20_0.rectshotframe, var_20_0.x, var_20_0.y)
end

function var_0_0._onDailyRefresh(arg_21_0)
	if arg_21_0._actId then
		Activity125Controller.instance:getAct125InfoFromServer(arg_21_0._actId)
	end
end

function var_0_0.getCurSelectedEpisode(arg_22_0)
	return Activity125Model.instance:getSelectEpisodeId(arg_22_0._actId) or 1
end

function var_0_0.onUpdateParam(arg_23_0)
	return
end

function var_0_0.onOpen(arg_24_0)
	arg_24_0._actId = arg_24_0.viewParam.actId

	arg_24_0:_initCategoryItem()

	arg_24_0._currentIndex = Activity125Model.instance:getById(arg_24_0._actId):getFirstRewardEpisode()

	Activity125Model.instance:setSelectEpisodeId(arg_24_0._actId, arg_24_0._currentIndex)
	gohelper.setActive(arg_24_0._gonormal, true)
	gohelper.setActive(arg_24_0._gowrong, false)
	TaskDispatcher.runDelay(arg_24_0._onOpenFinish, arg_24_0, arg_24_0._shotFocusTime)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Enter.play_ui_jinye_unfold)
	arg_24_0:_refreshUI()
end

function var_0_0._onOpenFinish(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._onOpenFinish, arg_25_0)
	arg_25_0._shotAnimator:Play("open", 0, 0)
end

function var_0_0.onClose(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._onSwitchFinish, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._onOpenFinish, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._showError, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._showSuccess, arg_26_0)

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._categoryitemList) do
		iter_26_1.btnclick:RemoveClickListener()
	end
end

function var_0_0._autoSelectTab(arg_27_0)
	local var_27_0 = Activity125Model.instance:getById(arg_27_0._actId):getFirstRewardEpisode() - 1
	local var_27_1 = 30
	local var_27_2 = 46
	local var_27_3 = 0

	if var_27_0 > 1 then
		var_27_3 = arg_27_0._selectItemHeight + arg_27_0._itemHeight * (var_27_0 - 2) + (var_27_0 - 1) * var_27_2 + var_27_1
	end

	if var_27_3 > arg_27_0._canMoveHeight then
		var_27_3 = arg_27_0._canMoveHeight
	end

	recthelper.setAnchorY(arg_27_0._gocategorycontent.transform, var_27_3)
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

function var_0_0.onRefreshActivity(arg_29_0)
	local var_29_0 = ActivityHelper.getActivityStatus(arg_29_0._actId)

	if var_29_0 == ActivityEnum.ActivityStatus.NotOnLine or var_29_0 == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

return var_0_0
