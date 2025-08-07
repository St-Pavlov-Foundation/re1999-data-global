module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9TaskItem", package.seeall)

local var_0_0 = class("VersionActivity2_9TaskItem", VersionActivityFixedTaskItem)

function var_0_0._btnFinishOnClick(arg_1_0)
	var_0_0.super._btnFinishOnClick(arg_1_0)
	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_finishTask)
end

function var_0_0._btnNotFinishOnClick(arg_2_0)
	if arg_2_0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(arg_2_0.co.jumpId) then
			arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0._onJumpDone, arg_2_0)
		end
	end
end

function var_0_0._onJumpDone(arg_3_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity2_9TaskView)
end

return var_0_0
