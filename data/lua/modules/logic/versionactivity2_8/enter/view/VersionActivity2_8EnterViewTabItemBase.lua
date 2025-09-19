module("modules.logic.versionactivity2_8.enter.view.VersionActivity2_8EnterViewTabItemBase", package.seeall)

local var_0_0 = class("VersionActivity2_8EnterViewTabItemBase", VersionActivityEnterViewBaseTabItem)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0.goSelected = gohelper.findChild(arg_1_0.go, "#go_select")
	arg_1_0.imageSelectTabIcon = gohelper.findChildImage(arg_1_0.go, "#go_select/#image_tabicon")
	arg_1_0.goUnselected = gohelper.findChild(arg_1_0.go, "#go_unselect")
	arg_1_0.imageUnSelectTabIcon = gohelper.findChildImage(arg_1_0.go, "#go_unselect/#image_tabicon")

	local var_1_0 = arg_1_0:_getTagPath()

	arg_1_0.goTag = gohelper.findChild(arg_1_0.go, var_1_0)
	arg_1_0.goTagNewAct = gohelper.findChild(arg_1_0.go, var_1_0 .. "/#go_newact")
	arg_1_0.goTagNewLevel = gohelper.findChild(arg_1_0.go, var_1_0 .. "/#go_newlevel")
	arg_1_0.goTagTime = gohelper.findChild(arg_1_0.go, var_1_0 .. "/#go_time")
	arg_1_0.goTagLock = gohelper.findChild(arg_1_0.go, var_1_0 .. "/#go_lock")
	arg_1_0.txtTime = gohelper.findChildText(arg_1_0.goTagTime, "bg/#txt_time")
	arg_1_0.txtLock = gohelper.findChildText(arg_1_0.goTagLock, "bg/#txt_lock")
	arg_1_0.goRedDot = gohelper.findChild(arg_1_0.go, "#go_reddot")
	arg_1_0.animator = arg_1_0.go:GetComponent(gohelper.Type_Animator)

	if not arg_1_0.goTag or not arg_1_0.goTagNewAct or not arg_1_0.goTagNewLevel or not arg_1_0.goTagTime or not arg_1_0.goTagLock then
		logError("error node:", tostring(arg_1_0.goTag), tostring(arg_1_0.goTagNewAct), tostring(arg_1_0.goTagNewLevel), tostring(arg_1_0.goTagTime), tostring(arg_1_0.goTagLock))
	end

	if not arg_1_0.txtTime or not arg_1_0.txtLock then
		logError("error node txt:", tostring(arg_1_0.txtTime), tostring(arg_1_0.txtLock))
	end
end

function var_0_0._getTagPath(arg_2_0)
	return "#txt_name/#go_tag"
end

function var_0_0.afterSetData(arg_3_0)
	if arg_3_0.actId then
		arg_3_0.activityCo = ActivityConfig.instance:getActivityCo(arg_3_0.actId)
	end

	if not arg_3_0.activityCo then
		gohelper.setActive(arg_3_0.go, false)
		logError("VersionActivity2_8EnterViewTabItemBase.afterSetData error, no act config, actId:%s", arg_3_0.actId)

		return
	end

	local var_3_0 = string.split(arg_3_0.activityCo.tabBgPath, "#")
	local var_3_1 = var_3_0[1]

	if not string.nilorempty(var_3_1) then
		UISpriteSetMgr.instance:setV2a8MainActivitySprite(arg_3_0.imageSelectTabIcon, var_3_1)
	end

	local var_3_2 = var_3_0[2]

	if not string.nilorempty(var_3_2) then
		UISpriteSetMgr.instance:setV2a8MainActivitySprite(arg_3_0.imageUnSelectTabIcon, var_3_2)
	end

	arg_3_0.redDotIcon = RedDotController.instance:addRedDot(arg_3_0.goRedDot, arg_3_0.activityCo.redDotId, arg_3_0.redDotUid)
end

function var_0_0.childRefreshSelect(arg_4_0)
	gohelper.setActive(arg_4_0.goSelected, arg_4_0.isSelect)
	gohelper.setActive(arg_4_0.goUnselected, not arg_4_0.isSelect)
end

function var_0_0.childRefreshUI(arg_5_0)
	local var_5_0 = ActivityHelper.getActivityStatus(arg_5_0.actId)

	gohelper.setActive(arg_5_0.goRedDot, var_5_0 == ActivityEnum.ActivityStatus.Normal)
end

function var_0_0.refreshTag(arg_6_0)
	arg_6_0:clearTag()

	if not arg_6_0.actId then
		return
	end

	local var_6_0 = ActivityHelper.getActivityStatus(arg_6_0.actId)

	if var_6_0 == ActivityEnum.ActivityStatus.Normal then
		arg_6_0:refreshNormalTag()
	elseif var_6_0 == ActivityEnum.ActivityStatus.NotUnlock then
		arg_6_0:refreshNotUnlockTag()
	else
		arg_6_0:refreshLockTag()
	end
end

function var_0_0.clearTag(arg_7_0)
	gohelper.setActive(arg_7_0.goTagNewAct, false)
	gohelper.setActive(arg_7_0.goTagNewLevel, false)
	gohelper.setActive(arg_7_0.goTagTime, false)
	gohelper.setActive(arg_7_0.goTagLock, false)
end

function var_0_0.refreshNormalTag(arg_8_0)
	if not ActivityEnterMgr.instance:isEnteredActivity(arg_8_0.actId) then
		gohelper.setActive(arg_8_0.goTagNewAct, true)

		return
	end

	local var_8_0 = ActivityModel.instance:getActivityInfo()[arg_8_0.actId]

	if var_8_0 and var_8_0:isNewStageOpen() then
		gohelper.setActive(arg_8_0.goTagNewLevel, true)

		return
	end

	if VersionActivity2_8EnterHelper.GetIsShowTabRemainTime(arg_8_0.actId) and var_8_0 then
		if var_8_0:getRealEndTimeStamp() - ServerTime.now() > VersionActivity2_8Enum.MaxShowTimeOffset then
			return
		end

		gohelper.setActive(arg_8_0.goTagTime, true)

		arg_8_0.txtTime.text = var_8_0:getRemainTimeStr2ByEndTime()
	end
end

function var_0_0.refreshNotUnlockTag(arg_9_0)
	gohelper.setActive(arg_9_0.goTagLock, false)

	if not ActivityEnterMgr.instance:isEnteredActivity(arg_9_0.actId) then
		gohelper.setActive(arg_9_0.goTagNewAct, true)
	end
end

function var_0_0.refreshLockTag(arg_10_0)
	gohelper.setActive(arg_10_0.goTagLock, true)

	if ActivityHelper.getActivityStatus(arg_10_0.actId) == ActivityEnum.ActivityStatus.NotOpen then
		local var_10_0 = ActivityModel.instance:getActivityInfo()[arg_10_0.actId]:getRemainTimeStr2ByOpenTime()

		arg_10_0.txtLock.text = var_10_0
	else
		gohelper.setActive(arg_10_0.goTagLock, false)
	end
end

function var_0_0.isShowRedDot(arg_11_0)
	return arg_11_0.redDotIcon and arg_11_0.redDotIcon.show
end

return var_0_0
