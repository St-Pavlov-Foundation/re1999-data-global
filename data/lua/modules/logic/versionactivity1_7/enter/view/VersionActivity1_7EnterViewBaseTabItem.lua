module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterViewBaseTabItem", package.seeall)

local var_0_0 = class("VersionActivity1_7EnterViewBaseTabItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0.index = arg_1_1
	arg_1_0.actMo = arg_1_2
	arg_1_0.rootGo = arg_1_3
	arg_1_0.redDotUid = arg_1_2.redDotUid or 0
	arg_1_0.storeId = arg_1_2.storeId

	arg_1_0:updateActId()
	gohelper.setActive(arg_1_0.rootGo, true)

	arg_1_0.rectTr = arg_1_0.rootGo:GetComponent(gohelper.Type_RectTransform)
	arg_1_0.goSelected = gohelper.findChild(arg_1_0.rootGo, "#go_select")
	arg_1_0.goUnselected = gohelper.findChild(arg_1_0.rootGo, "#go_unselect")
	arg_1_0.imageUnSelectTabIcon = gohelper.findChildImage(arg_1_0.rootGo, "#go_unselect/#image_tabicon")
	arg_1_0.imageSelectTabIcon = gohelper.findChildImage(arg_1_0.rootGo, "#go_select/#image_tabicon")
	arg_1_0.goTag = gohelper.findChild(arg_1_0.rootGo, "#go_tag")
	arg_1_0.goTagNewAct = gohelper.findChild(arg_1_0.rootGo, "#go_tag/#go_newact")
	arg_1_0.goTagNewLevel = gohelper.findChild(arg_1_0.rootGo, "#go_tag/#go_newlevel")
	arg_1_0.goTagTime = gohelper.findChild(arg_1_0.rootGo, "#go_tag/#go_time")
	arg_1_0.goTagLock = gohelper.findChild(arg_1_0.rootGo, "#go_tag/#go_lock")
	arg_1_0.txtTime = gohelper.findChildText(arg_1_0.goTagTime, "bg/#txt_time")
	arg_1_0.txtLock = gohelper.findChildText(arg_1_0.goTagLock, "bg/#txt_lock")
	arg_1_0.goRedDot = gohelper.findChild(arg_1_0.rootGo, "#go_reddot")
	arg_1_0.click = gohelper.getClickWithDefaultAudio(arg_1_0.rootGo)

	arg_1_0.click:AddClickListener(arg_1_0.onClickSelf, arg_1_0)

	arg_1_0.animator = arg_1_0.rootGo:GetComponent(gohelper.Type_Animator)

	arg_1_0:_editableInitView()
end

function var_0_0.updateActId(arg_2_0)
	local var_2_0 = VersionActivityEnterHelper.getActId(arg_2_0.actMo)

	if var_2_0 == arg_2_0.actId then
		return false
	end

	arg_2_0.actId = var_2_0
	arg_2_0.activityCo = ActivityConfig.instance:getActivityCo(arg_2_0.actId)

	return true
end

function var_0_0._editableInitView(arg_3_0)
	local var_3_0 = string.split(arg_3_0.activityCo.tabBgPath, "#")

	UISpriteSetMgr.instance:setV1a7MainActivitySprite(arg_3_0.imageSelectTabIcon, var_3_0[1])
	UISpriteSetMgr.instance:setV1a7MainActivitySprite(arg_3_0.imageUnSelectTabIcon, var_3_0[2])

	arg_3_0.redDotIcon = RedDotController.instance:addRedDot(arg_3_0.goRedDot, arg_3_0.activityCo.redDotId, arg_3_0.redDotUid)

	arg_3_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_3_0.refreshTag, arg_3_0)
	arg_3_0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_3_0.refreshSelect, arg_3_0)
	arg_3_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.onRefreshActivity, arg_3_0)
	TaskDispatcher.runRepeat(arg_3_0.refreshTag, arg_3_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.onClickSelf(arg_4_0)
	if arg_4_0.isSelect then
		return
	end

	if arg_4_0.handleFunc then
		arg_4_0.handleFunc(arg_4_0.handleFuncObj, arg_4_0)

		return
	end

	local var_4_0 = arg_4_0.storeId or arg_4_0.actId
	local var_4_1, var_4_2, var_4_3 = ActivityHelper.getActivityStatusAndToast(var_4_0)

	if var_4_1 == ActivityEnum.ActivityStatus.Normal or var_4_1 == ActivityEnum.ActivityStatus.NotUnlock then
		arg_4_0.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, arg_4_0.actId, arg_4_0)

		return
	end

	if var_4_2 then
		GameFacade.showToastWithTableParam(var_4_2, var_4_3)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

function var_0_0.overrideOnClickHandle(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.handleFunc = arg_5_1
	arg_5_0.handleFuncObj = arg_5_2
end

function var_0_0.refreshSelect(arg_6_0, arg_6_1)
	arg_6_0.isSelect = arg_6_1 == arg_6_0.actId

	gohelper.setActive(arg_6_0.goSelected, arg_6_0.isSelect)
	gohelper.setActive(arg_6_0.goUnselected, not arg_6_0.isSelect)
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = ActivityHelper.getActivityStatus(arg_7_0.actId)

	gohelper.setActive(arg_7_0.goRedDot, var_7_0 == ActivityEnum.ActivityStatus.Normal)
	arg_7_0:refreshTag()
end

function var_0_0.refreshTag(arg_8_0)
	arg_8_0:clearTag()

	local var_8_0 = ActivityHelper.getActivityStatus(arg_8_0.actId)

	if var_8_0 == ActivityEnum.ActivityStatus.Normal then
		arg_8_0:refreshNormalTag()
	elseif var_8_0 == ActivityEnum.ActivityStatus.NotUnlock then
		arg_8_0:refreshNotUnlockTag()
	else
		arg_8_0:refreshLockTag()
	end
end

function var_0_0.refreshLockTag(arg_9_0)
	gohelper.setActive(arg_9_0.goTagLock, true)

	if ActivityHelper.getActivityStatus(arg_9_0.actId) == ActivityEnum.ActivityStatus.NotOpen then
		local var_9_0 = ActivityModel.instance:getActivityInfo()[arg_9_0.actId]:getRemainTimeStr2ByOpenTime()

		arg_9_0.txtLock.text = var_9_0
	else
		gohelper.setActive(arg_9_0.goTagLock, false)
	end
end

function var_0_0.refreshNormalTag(arg_10_0)
	if not ActivityEnterMgr.instance:isEnteredActivity(arg_10_0.actId) then
		gohelper.setActive(arg_10_0.goTagNewAct, true)

		return
	end

	local var_10_0 = ActivityModel.instance:getActivityInfo()[arg_10_0.actId]

	if var_10_0 and var_10_0:isNewStageOpen() then
		gohelper.setActive(arg_10_0.goTagNewLevel, true)

		return
	end

	if VersionActivity1_7Enum.ActId2ShowRemainTimeDict[arg_10_0.actId] and var_10_0 then
		if var_10_0:getRealEndTimeStamp() - ServerTime.now() > VersionActivity1_7Enum.MaxShowTimeOffset then
			return
		end

		gohelper.setActive(arg_10_0.goTagTime, true)

		arg_10_0.txtTime.text = var_10_0:getRemainTimeStr2ByEndTime()
	end
end

function var_0_0.refreshNotUnlockTag(arg_11_0)
	gohelper.setActive(arg_11_0.goTagLock, false)

	if not ActivityEnterMgr.instance:isEnteredActivity(arg_11_0.actId) then
		gohelper.setActive(arg_11_0.goTagNewAct, true)
	end
end

function var_0_0.clearTag(arg_12_0)
	gohelper.setActive(arg_12_0.goTagNewAct, false)
	gohelper.setActive(arg_12_0.goTagNewLevel, false)
	gohelper.setActive(arg_12_0.goTagTime, false)
	gohelper.setActive(arg_12_0.goTagLock, false)
end

function var_0_0.onRefreshActivity(arg_13_0, arg_13_1)
	if arg_13_0.actId ~= arg_13_1 then
		return
	end

	arg_13_0:refreshTag()
end

function var_0_0.isShowRedDot(arg_14_0)
	return arg_14_0.redDotIcon and arg_14_0.redDotIcon.show
end

function var_0_0.getAnchorY(arg_15_0)
	return recthelper.getAnchorY(arg_15_0.rectTr)
end

function var_0_0.dispose(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.refreshTag, arg_16_0)
	arg_16_0.click:RemoveClickListener()
	arg_16_0:__onDispose()
end

return var_0_0
