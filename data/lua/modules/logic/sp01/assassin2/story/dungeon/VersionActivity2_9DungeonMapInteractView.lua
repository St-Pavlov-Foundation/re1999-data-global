module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapInteractView", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapInteractView", VersionActivityFixedDungeonMapInteractView)

function var_0_0.show(arg_1_0)
	if arg_1_0._show then
		return
	end

	arg_1_0._show = true

	gohelper.setActive(arg_1_0._gointeractitem, true)
	gohelper.setActive(arg_1_0._gointeractroot, true)
	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_clickElement)
end

function var_0_0.hide(arg_2_0)
	if not arg_2_0._show then
		return
	end

	VersionActivityFixedDungeonModel.instance:setShowInteractView(nil)

	arg_2_0._show = false
	arg_2_0.dispatchMo = nil

	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_clickElement)
	gohelper.setActive(arg_2_0._gointeractitem, false)
	gohelper.setActive(arg_2_0._gointeractroot, false)
	TaskDispatcher.cancelTask(arg_2_0.everySecondCall, arg_2_0)
	VersionActivityFixedHelper.getVersionActivityDungeonController().instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnHideInteractUI)
end

return var_0_0
