module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawBlockObj", package.seeall)

local var_0_0 = class("KaRongDrawBlockObj", KaRongDrawBaseObj)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_switch")

	arg_1_0._btnswitch:AddClickListener(arg_1_0._btnswitchOnClick, arg_1_0)

	arg_1_0._anim = arg_1_1:GetComponent(gohelper.Type_Animator)

	arg_1_0:addEventCb(KaRongDrawController.instance, KaRongDrawEvent.UsingSkill, arg_1_0._onUsingSkill, arg_1_0)
end

function var_0_0._onUsingSkill(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0._btnswitch, arg_2_1)

	local var_2_0 = arg_2_1 and "highlight" or "gray"

	arg_2_0._anim:Play(var_2_0, 0, 0)
end

function var_0_0.onInit(arg_3_0, arg_3_1)
	var_0_0.super.onInit(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0._btnswitch.gameObject, false)
end

function var_0_0._btnswitchOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_barrier_dispel)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("KaRongDrawBlockObj")
	arg_4_0._anim:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_4_0._delayHide, arg_4_0, 1.67)
end

function var_0_0._delayHide(arg_5_0)
	gohelper.setActive(arg_5_0.go, false)
	KaRongDrawController.instance:useSkill(arg_5_0.mo)
	UIBlockMgr.instance:endBlock("KaRongDrawBlockObj")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.destroy(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayHide, arg_6_0)
	UIBlockMgr.instance:endBlock("KaRongDrawBlockObj")
	UIBlockMgrExtend.setNeedCircleMv(true)
	arg_6_0._btnswitch:RemoveClickListener()
	var_0_0.super.destroy(arg_6_0)
end

return var_0_0
