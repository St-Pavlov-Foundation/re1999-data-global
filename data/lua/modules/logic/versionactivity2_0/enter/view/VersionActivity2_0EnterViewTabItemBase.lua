module("modules.logic.versionactivity2_0.enter.view.VersionActivity2_0EnterViewTabItemBase", package.seeall)

local var_0_0 = class("VersionActivity2_0EnterViewTabItemBase", VersionActivityEnterViewBaseTabItem)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0.goSelected = gohelper.findChild(arg_1_0.go, "#go_select")
	arg_1_0.imageSelectTabIcon = gohelper.findChildImage(arg_1_0.go, "#go_select/#image_tabicon")
	arg_1_0.goUnselected = gohelper.findChild(arg_1_0.go, "#go_unselect")
	arg_1_0.imageUnSelectTabIcon = gohelper.findChildImage(arg_1_0.go, "#go_unselect/#image_tabicon")
	arg_1_0.goTag = gohelper.findChild(arg_1_0.go, "#go_tag")
	arg_1_0.goTagNewAct = gohelper.findChild(arg_1_0.go, "#go_tag/#go_newact")
	arg_1_0.goTagNewLevel = gohelper.findChild(arg_1_0.go, "#go_tag/#go_newlevel")
	arg_1_0.goTagTime = gohelper.findChild(arg_1_0.go, "#go_tag/#go_time")
	arg_1_0.goTagLock = gohelper.findChild(arg_1_0.go, "#go_tag/#go_lock")
	arg_1_0.txtTime = gohelper.findChildText(arg_1_0.goTagTime, "bg/#txt_time")
	arg_1_0.txtLock = gohelper.findChildText(arg_1_0.goTagLock, "bg/#txt_lock")
	arg_1_0.goRedDot = gohelper.findChild(arg_1_0.go, "#go_reddot")
	arg_1_0.animator = arg_1_0.go:GetComponent(gohelper.Type_Animator)
end

function var_0_0.afterSetData(arg_2_0)
	if arg_2_0.actId then
		arg_2_0.activityCo = ActivityConfig.instance:getActivityCo(arg_2_0.actId)
	end

	if not arg_2_0.activityCo then
		gohelper.setActive(arg_2_0.go, false)
		logError("VersionActivity2_0EnterViewTabItemBase.afterSetData error, no act config, actId:%s", arg_2_0.actId)

		return
	end

	local var_2_0 = string.split(arg_2_0.activityCo.tabBgPath, "#")
	local var_2_1 = var_2_0[1]

	if not string.nilorempty(var_2_1) then
		UISpriteSetMgr.instance:setV2a0MainActivitySprite(arg_2_0.imageSelectTabIcon, var_2_1)
	end

	local var_2_2 = var_2_0[2]

	if not string.nilorempty(var_2_2) then
		UISpriteSetMgr.instance:setV2a0MainActivitySprite(arg_2_0.imageUnSelectTabIcon, var_2_2)
	end

	arg_2_0.redDotIcon = RedDotController.instance:addRedDot(arg_2_0.goRedDot, arg_2_0.activityCo.redDotId, arg_2_0.redDotUid)
end

function var_0_0.childRefreshSelect(arg_3_0)
	gohelper.setActive(arg_3_0.goSelected, arg_3_0.isSelect)
	gohelper.setActive(arg_3_0.goUnselected, not arg_3_0.isSelect)
end

function var_0_0.childRefreshUI(arg_4_0)
	local var_4_0 = ActivityHelper.getActivityStatus(arg_4_0.actId)

	gohelper.setActive(arg_4_0.goRedDot, var_4_0 == ActivityEnum.ActivityStatus.Normal)
end

function var_0_0.refreshTag(arg_5_0)
	arg_5_0:clearTag()

	if not arg_5_0.actId then
		return
	end

	local var_5_0 = ActivityHelper.getActivityStatus(arg_5_0.actId)

	if var_5_0 == ActivityEnum.ActivityStatus.Normal then
		arg_5_0:refreshNormalTag()
	elseif var_5_0 == ActivityEnum.ActivityStatus.NotUnlock then
		arg_5_0:refreshNotUnlockTag()
	else
		arg_5_0:refreshLockTag()
	end
end

function var_0_0.clearTag(arg_6_0)
	gohelper.setActive(arg_6_0.goTagNewAct, false)
	gohelper.setActive(arg_6_0.goTagNewLevel, false)
	gohelper.setActive(arg_6_0.goTagTime, false)
	gohelper.setActive(arg_6_0.goTagLock, false)
end

function var_0_0.refreshNormalTag(arg_7_0)
	if not ActivityEnterMgr.instance:isEnteredActivity(arg_7_0.actId) then
		gohelper.setActive(arg_7_0.goTagNewAct, true)

		return
	end

	local var_7_0 = ActivityModel.instance:getActivityInfo()[arg_7_0.actId]

	if var_7_0 and var_7_0:isNewStageOpen() then
		gohelper.setActive(arg_7_0.goTagNewLevel, true)

		return
	end

	if VersionActivity2_0EnterHelper.GetIsShowTabRemainTime(arg_7_0.actId) and var_7_0 then
		if var_7_0:getRealEndTimeStamp() - ServerTime.now() > VersionActivity2_0Enum.MaxShowTimeOffset then
			return
		end

		gohelper.setActive(arg_7_0.goTagTime, true)

		arg_7_0.txtTime.text = var_7_0:getRemainTimeStr2ByEndTime()
	end
end

function var_0_0.refreshNotUnlockTag(arg_8_0)
	gohelper.setActive(arg_8_0.goTagLock, false)

	if not ActivityEnterMgr.instance:isEnteredActivity(arg_8_0.actId) then
		gohelper.setActive(arg_8_0.goTagNewAct, true)
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

function var_0_0.isShowRedDot(arg_10_0)
	return arg_10_0.redDotIcon and arg_10_0.redDotIcon.show
end

return var_0_0
