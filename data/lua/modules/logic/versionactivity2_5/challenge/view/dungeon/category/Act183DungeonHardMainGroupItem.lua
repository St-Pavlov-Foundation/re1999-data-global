module("modules.logic.versionactivity2_5.challenge.view.dungeon.category.Act183DungeonHardMainGroupItem", package.seeall)

local var_0_0 = class("Act183DungeonHardMainGroupItem", Act183DungeonBaseGroupItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._animUnlock = gohelper.onceAddComponent(arg_1_0._golock, gohelper.Type_Animator)

	arg_1_0:addEventCb(Act183Controller.instance, Act183Event.OnInitDungeonDone, arg_1_0._onInitDungeonDone, arg_1_0)
end

function var_0_0._onInitDungeonDone(arg_2_0)
	arg_2_0:_checkPlayNewUnlockAnim()
end

function var_0_0._checkPlayNewUnlockAnim(arg_3_0)
	if Act183Model.instance:isHardMainGroupNewUnlock() then
		gohelper.setActive(arg_3_0._golock, true)
		arg_3_0._animUnlock:Play("unlock", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Act183_HardMainUnlock)
	end
end

return var_0_0
