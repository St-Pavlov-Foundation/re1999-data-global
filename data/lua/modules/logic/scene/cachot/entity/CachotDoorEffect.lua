module("modules.logic.scene.cachot.entity.CachotDoorEffect", package.seeall)

local var_0_0 = class("CachotDoorEffect", LuaCompBase)
local var_0_1 = {
	enter = UnityEngine.Animator.StringToHash("enter"),
	active = UnityEngine.Animator.StringToHash("active"),
	exit = UnityEngine.Animator.StringToHash("exit")
}
local var_0_2 = 0.5

function var_0_0.Create(arg_1_0)
	return MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_1.transform
	arg_2_0._animator = arg_2_1:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_2_1, false)

	arg_2_0._isInDoor = false
end

function var_0_0.setIsInDoor(arg_3_0, arg_3_1)
	if arg_3_0._isInDoor == arg_3_1 then
		return
	end

	arg_3_0._isInDoor = arg_3_1

	gohelper.setActive(arg_3_0.go, true)
	TaskDispatcher.cancelTask(arg_3_0.hideEffect, arg_3_0)

	local var_3_0 = arg_3_0._animator:GetCurrentAnimatorStateInfo(0)
	local var_3_1 = 0

	if arg_3_1 then
		if var_3_0.shortNameHash == var_0_1.exit then
			var_3_1 = 1 - var_3_0.normalizedTime
		end

		arg_3_0._animator:Play(var_0_1.enter, 0, var_3_1)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_entrance_light)
	else
		if var_3_0.shortNameHash == var_0_1.enter then
			var_3_1 = 1 - var_3_0.normalizedTime
		end

		arg_3_0._animator:Play(var_0_1.exit, 0, var_3_1)
		TaskDispatcher.runDelay(arg_3_0.hideEffect, arg_3_0, (1 - var_3_1) * var_0_2)
	end
end

function var_0_0.hideEffect(arg_4_0)
	arg_4_0._isInDoor = false

	TaskDispatcher.cancelTask(arg_4_0.hideEffect, arg_4_0)
	gohelper.setActive(arg_4_0.go, false)
end

function var_0_0.dispose(arg_5_0)
	gohelper.destroy(arg_5_0.go)
	TaskDispatcher.cancelTask(arg_5_0.hideEffect, arg_5_0)
end

return var_0_0
