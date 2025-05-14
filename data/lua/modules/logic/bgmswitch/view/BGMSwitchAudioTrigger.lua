module("modules.logic.bgmswitch.view.BGMSwitchAudioTrigger", package.seeall)

local var_0_0 = class("BGMSwitchAudioTrigger")
local var_0_1 = {
	[BGMSwitchEnum.Gear.On2] = true,
	[BGMSwitchEnum.Gear.On3] = true
}

function var_0_0.switchGearTo(arg_1_0, arg_1_1)
	local var_1_0 = math.abs(arg_1_1 - arg_1_0)

	var_0_0._play_ui_replay_tunetable()

	if var_1_0 > 1 then
		TaskDispatcher.runRepeat(var_0_0._play_ui_replay_tunetable, nil, 0.2, var_1_0 - 1)
	end

	if arg_1_0 == BGMSwitchEnum.Gear.OFF then
		TaskDispatcher.runDelay(var_0_0._play_ui_replay_boot, nil, var_1_0 * 0.2)
	end

	if arg_1_1 == BGMSwitchEnum.Gear.OFF then
		TaskDispatcher.runDelay(var_0_0._play_ui_replay_shutdown, nil, var_1_0 * 0.2)
	end

	if not var_0_1[arg_1_0] and var_0_1[arg_1_1] then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_whitenoise_loop)
	elseif var_0_1[arg_1_0] and not var_0_1[arg_1_1] then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_replay_whitenoise_loop)
	end
end

function var_0_0._play_ui_replay_tunetable()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tunetable)
end

function var_0_0._play_ui_replay_boot()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_boot)
end

function var_0_0._play_ui_replay_shutdown()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_shutdown)
end

function var_0_0.play_ui_replay_open()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_open)

	local var_5_0 = BGMSwitchModel.instance:getMechineGear()

	if var_0_1[var_5_0] then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_whitenoise_loop)
	end
end

function var_0_0.play_ui_replay_close()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_close)

	local var_6_0 = BGMSwitchModel.instance:getMechineGear()

	if var_0_1[var_6_0] then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_replay_whitenoise_loop)
	end
end

function var_0_0.play_ui_replay_tinyopen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tinyopen)
end

function var_0_0.play_ui_replay_tinyclose()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tinyclose)
end

function var_0_0.play_ui_replay_buttonsilp()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttonsilp)
end

function var_0_0.play_ui_replay_buttoncut()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttoncut)
end

function var_0_0.play_ui_replay_tapswitch()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tapswitch)
end

function var_0_0.play_ui_replay_buttonegg()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttonegg)
end

function var_0_0.play_ui_replay_flap()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_flap)
end

function var_0_0.play_ui_replay_heart(arg_14_0)
	if arg_14_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_hearton)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_heartoff)
	end
end

function var_0_0.play_ui_rolesgo()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesgo)
end

function var_0_0.play_ui_achieve_weiqicard_switch()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
end

function var_0_0.play_ui_checkpoint_resources_cardpass()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_resources_cardpass)
end

return var_0_0
