module("modules.logic.versionactivity3_1.enter.view.VersionActivity3_1EnterBgmView", package.seeall)

local var_0_0 = class("VersionActivity3_1EnterBgmView", VersionActivityFixedEnterBgmView)

function var_0_0.initActHandle(arg_1_0)
	if not arg_1_0.actHandleDict then
		arg_1_0.actHandleDict = {
			[BossRushConfig.instance:getActivityId()] = arg_1_0._bossrushBgmHandle,
			[VersionActivity3_1Enum.ActivityId.Reactivity] = arg_1_0._reactivityBgmHandle
		}
	end
end

function var_0_0.defaultBgmHandle(arg_2_0, arg_2_1)
	var_0_0.super.defaultBgmHandle(arg_2_0, arg_2_1)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.SwitchBGM, arg_2_1)
end

return var_0_0
