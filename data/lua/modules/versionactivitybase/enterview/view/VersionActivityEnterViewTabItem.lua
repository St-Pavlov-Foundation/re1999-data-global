module("modules.versionactivitybase.enterview.view.VersionActivityEnterViewTabItem", package.seeall)

local var_0_0 = class("VersionActivityEnterViewTabItem", UserDataDispose)
local var_0_1 = VersionActivityEnterViewTabEnum.ActTabFlag

var_0_0.activityRemainTimeColor = "#9DD589"

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.index = arg_1_1
	arg_1_0.actId = arg_1_2
	arg_1_0.rootGo = arg_1_3
	arg_1_0.go_selected = gohelper.findChild(arg_1_0.rootGo, "#go_select")
	arg_1_0.go_unselected = gohelper.findChild(arg_1_0.rootGo, "#go_normal")
	arg_1_0.activityNameTexts = arg_1_0:getUserDataTb_()
	arg_1_0.activityNameTexts.select = gohelper.findChildText(arg_1_0.go_selected, "#txt_name")
	arg_1_0.activityNameTexts.normal = gohelper.findChildText(arg_1_0.go_unselected, "#txt_name")
	arg_1_0.txtLockGo = gohelper.findChild(arg_1_3, "lockContainer/lock")
	arg_1_0.txtLock = gohelper.findChildText(arg_1_3, "lockContainer/lock/txt_lock")
	arg_1_0.redPoints = arg_1_0:getUserDataTb_()
	arg_1_0.redPoints.select = gohelper.findChild(arg_1_0.go_selected, "#image_reddot")
	arg_1_0.redPoints.normal = gohelper.findChild(arg_1_0.go_unselected, "#image_reddot")
	arg_1_0.newActivityFlags = arg_1_0:getUserDataTb_()
	arg_1_0.newActivityFlags.select = gohelper.findChild(arg_1_0.go_selected, "#go_newact")
	arg_1_0.newActivityFlags.normal = gohelper.findChild(arg_1_0.go_unselected, "#go_newact")
	arg_1_0.newEpisodeFlags = arg_1_0:getUserDataTb_()
	arg_1_0.newEpisodeFlags.select = gohelper.findChild(arg_1_0.go_selected, "#go_newlevel")
	arg_1_0.newEpisodeFlags.normal = gohelper.findChild(arg_1_0.go_unselected, "#go_newlevel")
	arg_1_0.rewardunlock = arg_1_0:getUserDataTb_()
	arg_1_0.rewardunlock.select = gohelper.findChild(arg_1_0.go_selected, "#go_rewardunlock")
	arg_1_0.rewardunlock.normal = gohelper.findChild(arg_1_0.go_unselected, "#go_rewardunlock")
	arg_1_0.timeObjs = arg_1_0:getUserDataTb_()
	arg_1_0.timeObjs.goTime = arg_1_0:getUserDataTb_()
	arg_1_0.timeObjs.goTime.select = gohelper.findChild(arg_1_0.go_selected, "#go_time")
	arg_1_0.timeObjs.goTime.normal = gohelper.findChild(arg_1_0.go_unselected, "#go_time")
	arg_1_0.timeObjs.txtTime = arg_1_0:getUserDataTb_()
	arg_1_0.timeObjs.txtTime.select = gohelper.findChildText(arg_1_0.go_selected, "#go_time/bg/#txt_timelimit")
	arg_1_0.timeObjs.txtTime.normal = gohelper.findChildText(arg_1_0.go_unselected, "#go_time/bg/#txt_timelimit")
	arg_1_0.timeObjs.timeIcon = arg_1_0:getUserDataTb_()
	arg_1_0.timeObjs.timeIcon.select = gohelper.findChildImage(arg_1_0.go_selected, "#go_time/bg/#txt_timelimit/#image_timeicon")
	arg_1_0.timeObjs.timeIcon.normal = gohelper.findChildImage(arg_1_0.go_unselected, "#go_time/bg/#txt_timelimit/#image_timeicon")
	arg_1_0.imageIcons = arg_1_0:getUserDataTb_()
	arg_1_0.imageIcons.select = gohelper.findChildImage(arg_1_0.go_selected, "#simage_icon_select")
	arg_1_0.imageIcons.normal = gohelper.findChildImage(arg_1_0.go_unselected, "#simage_icon_normal")

	local var_1_0 = gohelper.findChild(arg_1_0.rootGo, "#btn_self")

	arg_1_0.click = SLFramework.UGUI.ButtonWrap.Get(var_1_0)
	arg_1_0.redPointTagAnimator = arg_1_0.goRedPointTag and arg_1_0.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))

	local var_1_1 = ActivityConfig.instance:getActivityCo(arg_1_2)

	arg_1_0.openId = var_1_1 and var_1_1.openId
	arg_1_0.redDotId = var_1_1 and var_1_1.redDotId
	arg_1_0.redDotUid = 0
	arg_1_0._redDotIconSelect = nil
	arg_1_0._redDotIconNormal = nil
end

function var_0_0.setClickFunc(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.click:AddClickListener(arg_2_1, arg_2_2, arg_2_0)
end

function var_0_0.setShowRemainDayToggle(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._showOpenRemainDayThreshold = arg_3_2
	arg_3_0._showOpenRemainDay = arg_3_1
end

function var_0_0.onClick(arg_4_0)
	return
end

function var_0_0.refreshSelectState(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0.go_selected, arg_5_1)
	gohelper.setActive(arg_5_0.go_unselected, not arg_5_1)
end

function var_0_0.refreshNameText(arg_6_0)
	if arg_6_0.activityNameTexts then
		local var_6_0 = ActivityModel.instance:getActMO(arg_6_0.actId).config.tabName

		arg_6_0.activityNameTexts.select.text = var_6_0
		arg_6_0.activityNameTexts.normal.text = var_6_0
	end
end

function var_0_0.addRedDot(arg_7_0)
	if arg_7_0._redDotIconNormal ~= nil then
		return
	end

	if ActivityHelper.getActivityStatus(arg_7_0.actId) == ActivityEnum.ActivityStatus.Normal and arg_7_0.redDotId and arg_7_0.redDotId ~= 0 then
		arg_7_0._redDotIconSelect = RedDotController.instance:addRedDot(arg_7_0.redPoints.select, arg_7_0.redDotId, arg_7_0.redDotUid)
		arg_7_0._redDotIconNormal = RedDotController.instance:addRedDot(arg_7_0.redPoints.normal, arg_7_0.redDotId, arg_7_0.redDotUid)
	end
end

function var_0_0.refreshActivityItemTag(arg_8_0)
	local var_8_0 = ActivityHelper.getActivityStatus(arg_8_0.actId)
	local var_8_1 = var_8_0 == ActivityEnum.ActivityStatus.Normal or var_8_0 == ActivityEnum.ActivityStatus.NotUnlock

	gohelper.setActive(arg_8_0.newActivityFlags.select, false)
	gohelper.setActive(arg_8_0.newActivityFlags.normal, false)
	gohelper.setActive(arg_8_0.newEpisodeFlags.select, false)
	gohelper.setActive(arg_8_0.newEpisodeFlags.normal, false)

	arg_8_0.showTag = nil

	if var_8_1 then
		local var_8_2 = ActivityModel.instance:getActMO(arg_8_0.actId)
		local var_8_3 = not ActivityEnterMgr.instance:isEnteredActivity(arg_8_0.actId)

		if var_8_3 then
			arg_8_0.showTag = var_0_1.ShowNewAct
		elseif var_8_2:isNewStageOpen() then
			arg_8_0.showTag = var_0_1.ShowNewStage
		end

		if arg_8_0.actId == VersionActivity1_6Enum.ActivityId.Cachot then
			local var_8_4 = V1a6_CachotProgressListModel.instance:checkRewardStageChange()

			gohelper.setActive(arg_8_0.rewardunlock.select, var_8_4 and not var_8_3)
			gohelper.setActive(arg_8_0.rewardunlock.normal, var_8_4 and not var_8_3)
		end
	end
end

function var_0_0.refreshTimeInfo(arg_9_0)
	if arg_9_0.showTag == var_0_1.ShowNewAct or arg_9_0.showTag == var_0_1.ShowNewStage then
		arg_9_0:_setItemObjActive(arg_9_0.timeObjs.goTime, false)

		return
	end

	local var_9_0 = ActivityHelper.getActivityStatus(arg_9_0.actId)
	local var_9_1 = "#FFFFFF"
	local var_9_2 = ""
	local var_9_3 = ActivityModel.instance:getActMO(arg_9_0.actId)

	if (var_9_0 == ActivityEnum.ActivityStatus.Normal or var_9_0 == ActivityEnum.ActivityStatus.NotUnlock) and arg_9_0._showOpenRemainDay then
		if var_9_3:getRemainDay() < arg_9_0._showOpenRemainDayThreshold then
			arg_9_0:_setItemObjActive(arg_9_0.timeObjs.goTime, true)

			var_9_1 = var_0_0.activityRemainTimeColor

			local var_9_4 = var_9_3:getRemainTimeStr2ByEndTime()

			arg_9_0.timeObjs.txtTime.select.text = var_9_4
			arg_9_0.timeObjs.txtTime.normal.text = var_9_4

			SLFramework.UGUI.GuiHelper.SetColor(arg_9_0.timeObjs.timeIcon.select, var_9_1)
			SLFramework.UGUI.GuiHelper.SetColor(arg_9_0.timeObjs.timeIcon.normal, var_9_1)
		else
			arg_9_0:_setItemObjActive(arg_9_0.timeObjs.goTime, false)
		end
	elseif var_9_0 == ActivityEnum.ActivityStatus.NotOpen then
		local var_9_5 = var_9_3:getRemainOpeningDay()

		arg_9_0:_setItemObjActive(arg_9_0.timeObjs.goTime, true)

		local var_9_6 = var_9_3:getRemainTimeStr2ByOpenTime()

		arg_9_0.timeObjs.txtTime.select.text = var_9_6
		arg_9_0.timeObjs.txtTime.normal.text = var_9_6

		SLFramework.UGUI.GuiHelper.SetColor(arg_9_0.timeObjs.timeIcon.select, var_9_1)
		SLFramework.UGUI.GuiHelper.SetColor(arg_9_0.timeObjs.timeIcon.normal, var_9_1)
	else
		arg_9_0:_setItemObjActive(arg_9_0.timeObjs.goTime, false)
	end
end

function var_0_0._setItemObjActive(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		gohelper.setActive(iter_10_1.gameObject, arg_10_2)
	end
end

return var_0_0
