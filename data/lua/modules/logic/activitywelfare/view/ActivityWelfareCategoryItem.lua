module("modules.logic.activitywelfare.view.ActivityWelfareCategoryItem", package.seeall)

local var_0_0 = class("ActivityWelfareCategoryItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "beselected")
	arg_1_0._gounselect = gohelper.findChild(arg_1_1, "noselected")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_1, "beselected/activitynamecn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_1, "beselected/activitynamecn/activitynameen")
	arg_1_0._txtunselectnamecn = gohelper.findChildText(arg_1_1, "noselected/noactivitynamecn")
	arg_1_0._txtunselectnameen = gohelper.findChildText(arg_1_1, "noselected/noactivitynamecn/noactivitynameen")
	arg_1_0._goreddot = gohelper.findChild(arg_1_1, "#go_reddot")
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_0.go)
	arg_1_0._anim = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._openAnimTime = 0.43
	arg_1_0._gonewwelfare = gohelper.findChild(arg_1_1, "#go_newwelfare")
	arg_1_0._goselectwelfare = gohelper.findChild(arg_1_1, "#go_newwelfare/selecticon")

	arg_1_0:playEnterAnim()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.SwitchWelfareActivity, arg_2_0.refreshSelect, arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._itemClick:RemoveClickListener()
end

function var_0_0._onItemClick(arg_4_0)
	if arg_4_0._selected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)

	if arg_4_0._mo.id == ActivityEnum.Activity.StoryShow or arg_4_0._mo.id == ActivityEnum.Activity.ClassShow then
		ActivityBeginnerController.instance:setFirstEnter(arg_4_0._mo.id)
		arg_4_0.redDot:refreshDot()
	end

	ActivityModel.instance:setTargetActivityCategoryId(arg_4_0._mo.id)
	ActivityController.instance:dispatchEvent(ActivityEvent.SwitchWelfareActivity)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:_refreshItem()

	if Time.realtimeSinceStartup - ActivityWelfareListModel.instance.openViewTime > arg_5_0._openAnimTime then
		arg_5_0._anim:Play(UIAnimationName.Idle, 0, 1)
	end
end

function var_0_0._refreshItem(arg_6_0)
	local var_6_0

	if arg_6_0._mo.type == ActivityEnum.ActivityType.Welfare then
		local var_6_1 = ActivityConfig.instance:getActivityCenterCo(ActivityEnum.ActivityType.Welfare).reddotid

		if arg_6_0._mo.id == ActivityEnum.Activity.StoryShow or arg_6_0._mo.id == ActivityEnum.Activity.ClassShow then
			arg_6_0.redDot = RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_1, arg_6_0._mo.id, arg_6_0.checkActivityShowFirstEnter, arg_6_0)
		else
			arg_6_0.redDot = RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_1, arg_6_0._mo.id)
		end
	end

	local var_6_2 = ActivityConfig.instance:getActivityCo(arg_6_0._mo.id)

	arg_6_0._txtnamecn.text = var_6_2.name
	arg_6_0._txtnameen.text = var_6_2.nameEn
	arg_6_0._txtunselectnamecn.text = var_6_2.name
	arg_6_0._txtunselectnameen.text = var_6_2.nameEn

	arg_6_0:refreshSelect()
end

function var_0_0.refreshSelect(arg_7_0)
	arg_7_0._selected = arg_7_0._mo.id == ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Welfare)

	local var_7_0 = false

	gohelper.setActive(arg_7_0._gonewwelfare, var_7_0)
	gohelper.setActive(arg_7_0._goselectwelfare, var_7_0 and arg_7_0._selected)
	gohelper.setActive(arg_7_0._goselect, not var_7_0 and arg_7_0._selected)
	gohelper.setActive(arg_7_0._gounselect, not var_7_0 and not arg_7_0._selected)
end

function var_0_0.checkActivityShowFirstEnter(arg_8_0, arg_8_1)
	arg_8_1:defaultRefreshDot()

	if not arg_8_1.show then
		arg_8_1.show = ActivityBeginnerController.instance:checkFirstEnter(arg_8_0._mo.id)

		arg_8_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.playEnterAnim(arg_9_0)
	local var_9_0 = Mathf.Clamp01((Time.realtimeSinceStartup - ActivityWelfareListModel.instance.openViewTime) / arg_9_0._openAnimTime)

	arg_9_0._anim:Play(UIAnimationName.Open, 0, var_9_0)
end

function var_0_0.onDestroy(arg_10_0)
	return
end

return var_0_0
