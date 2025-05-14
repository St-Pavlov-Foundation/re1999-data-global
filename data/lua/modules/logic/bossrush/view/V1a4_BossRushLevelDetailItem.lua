module("modules.logic.bossrush.view.V1a4_BossRushLevelDetailItem", package.seeall)

local var_0_0 = class("V1a4_BossRushLevelDetailItem", LuaCompBase)
local var_0_1 = {
	UnSelectd = 1,
	Locked = 0,
	Selected = 2
}
local var_0_2 = BossRushEnum.AnimEvtLevelDetailItem

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.transform

	arg_1_0._lockedGo = var_1_0:GetChild(var_0_1.Locked).gameObject
	arg_1_0._unSelectedGo = var_1_0:GetChild(var_0_1.UnSelectd).gameObject
	arg_1_0._selectedGo = var_1_0:GetChild(var_0_1.Selected).gameObject
	arg_1_0._animSelf = arg_1_1:GetComponent(gohelper.Type_Animator)
	arg_1_0._animEvent = arg_1_1:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_1_0.go = arg_1_1

	arg_1_0._animEvent:AddEventListener(var_0_2.onPlayUnlockSound, arg_1_0._onPlayUnlockSound, arg_1_0)
end

function var_0_0.onDestroy(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayUnlockCallBack, arg_2_0)
	arg_2_0._animEvent:RemoveEventListener(var_0_2.onPlayUnlockSound)
end

function var_0_0.onDestroyView(arg_3_0)
	arg_3_0:onDestroy()
end

function var_0_0.setSelect(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._unSelectedGo, not arg_4_1)
	gohelper.setActive(arg_4_0._selectedGo, arg_4_1)
end

function var_0_0.setData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._index = arg_5_1
	arg_5_0._stageLayerInfo = arg_5_2

	local var_5_0 = arg_5_2.isOpen

	arg_5_0._isOpen = var_5_0

	arg_5_0:setIsLocked(not var_5_0)

	if not var_5_0 then
		gohelper.setActive(arg_5_0._unSelectedGo, false)
		gohelper.setActive(arg_5_0._selectedGo, false)
	end
end

function var_0_0.setIsLocked(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._lockedGo, arg_6_1)
	arg_6_0:playIdle(arg_6_1)
end

function var_0_0.plaAnim(arg_7_0, arg_7_1, ...)
	arg_7_0._animSelf:Play(arg_7_1, ...)
end

function var_0_0.playIdle(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._isOpen

	if arg_8_1 ~= nil then
		var_8_0 = not arg_8_1
	end

	if var_8_0 then
		arg_8_0._animSelf:Play(BossRushEnum.AnimLevelDetailBtn.UnlockedIdle, 0, 1)
	else
		arg_8_0._animSelf:Play(BossRushEnum.AnimLevelDetailBtn.LockedIdle, 0, 1)
	end
end

function var_0_0.setTrigger(arg_9_0, arg_9_1)
	arg_9_0._animSelf:SetTrigger(arg_9_1)
end

function var_0_0._delayUnlockCallBack(arg_10_0)
	arg_10_0:setTrigger(BossRushEnum.AnimTriggerLevelDetailBtn.PlayUnlock)
end

function var_0_0.playUnlock(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._delayUnlockCallBack, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0._delayUnlockCallBack, arg_11_0, 0.5)
	arg_11_0:playIdle(true)
end

function var_0_0._onPlayUnlockSound(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.ui_checkpoint.play_ui_checkpoint_light_up)
end

return var_0_0
