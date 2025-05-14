module("modules.logic.versionactivity2_5.challenge.view.Act183MainBossEpisodeItem", package.seeall)

local var_0_0 = class("Act183MainBossEpisodeItem", Act183BaseEpisodeItem)
local var_0_1 = {
	2.9,
	-3.3,
	0,
	0,
	0
}

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._animunlock = gohelper.onceAddComponent(arg_1_0._gounlock, gohelper.Type_Animator)

	arg_1_0:addEventCb(Act183Controller.instance, Act183Event.OnInitDungeonDone, arg_1_0._onInitDungeonDone, arg_1_0)
end

function var_0_0._onInitDungeonDone(arg_2_0)
	arg_2_0:_checkPlayNewUnlockAnim()
end

function var_0_0._checkPlayNewUnlockAnim(arg_3_0)
	if arg_3_0._status ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	if Act183Model.instance:isEpisodeNewUnlock(arg_3_0._episodeId) then
		arg_3_0._animunlock:Play("unlock", 0, 0)
	end
end

function var_0_0._getCheckIconPosAndRotConfig(arg_4_0, arg_4_1)
	return var_0_1
end

return var_0_0
