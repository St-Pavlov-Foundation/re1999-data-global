module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapExtraView", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapExtraView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnstealth = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_stealth")
	arg_1_0._gostealthlocked = gohelper.findChild(arg_1_0.viewGO, "#btn_stealth/#go_stealthlocked")
	arg_1_0._gostealthunlocked = gohelper.findChild(arg_1_0.viewGO, "#btn_stealth/#go_stealthunlocked")
	arg_1_0._gostealthreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_stealth/#go_stealthreddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstealth:AddClickListener(arg_2_0._btnstealthOnClick, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0._refreshActivityState, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstealth:RemoveClickListener()
end

function var_0_0._btnstealthOnClick(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_9Enum.ActivityId.Outside)

	if var_4_0 ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(var_4_1, var_4_2)

		return
	end

	AssassinController.instance:openAssassinMapView(nil, true)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshStealthBtnStatus()
end

function var_0_0.refreshStealthBtnStatus(arg_7_0)
	local var_7_0 = ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.Outside)

	gohelper.setActive(arg_7_0._gostealthunlocked, var_7_0)
	gohelper.setActive(arg_7_0._gostealthlocked, not var_7_0)
end

function var_0_0._refreshActivityState(arg_8_0, arg_8_1)
	if not arg_8_1 or arg_8_1 == VersionActivity2_9Enum.ActivityId.Outside then
		arg_8_0:refreshStealthBtnStatus()
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
