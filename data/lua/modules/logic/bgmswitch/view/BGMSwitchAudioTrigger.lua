module("modules.logic.bgmswitch.view.BGMSwitchAudioTrigger", package.seeall)

slot0 = class("BGMSwitchAudioTrigger")
slot1 = {
	[BGMSwitchEnum.Gear.On2] = true,
	[BGMSwitchEnum.Gear.On3] = true
}

function slot0.switchGearTo(slot0, slot1)
	uv0._play_ui_replay_tunetable()

	if math.abs(slot1 - slot0) > 1 then
		TaskDispatcher.runRepeat(uv0._play_ui_replay_tunetable, nil, 0.2, slot2 - 1)
	end

	if slot0 == BGMSwitchEnum.Gear.OFF then
		TaskDispatcher.runDelay(uv0._play_ui_replay_boot, nil, slot2 * 0.2)
	end

	if slot1 == BGMSwitchEnum.Gear.OFF then
		TaskDispatcher.runDelay(uv0._play_ui_replay_shutdown, nil, slot2 * 0.2)
	end

	if not uv1[slot0] and uv1[slot1] then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_whitenoise_loop)
	elseif uv1[slot0] and not uv1[slot1] then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_replay_whitenoise_loop)
	end
end

function slot0._play_ui_replay_tunetable()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tunetable)
end

function slot0._play_ui_replay_boot()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_boot)
end

function slot0._play_ui_replay_shutdown()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_shutdown)
end

function slot0.play_ui_replay_open()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_open)

	if uv0[BGMSwitchModel.instance:getMechineGear()] then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_whitenoise_loop)
	end
end

function slot0.play_ui_replay_close()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_close)

	if uv0[BGMSwitchModel.instance:getMechineGear()] then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_replay_whitenoise_loop)
	end
end

function slot0.play_ui_replay_tinyopen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tinyopen)
end

function slot0.play_ui_replay_tinyclose()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tinyclose)
end

function slot0.play_ui_replay_buttonsilp()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttonsilp)
end

function slot0.play_ui_replay_buttoncut()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttoncut)
end

function slot0.play_ui_replay_tapswitch()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tapswitch)
end

function slot0.play_ui_replay_buttonegg()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttonegg)
end

function slot0.play_ui_replay_flap()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_flap)
end

function slot0.play_ui_replay_heart(slot0)
	if slot0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_hearton)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_heartoff)
	end
end

function slot0.play_ui_rolesgo()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesgo)
end

function slot0.play_ui_achieve_weiqicard_switch()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
end

function slot0.play_ui_checkpoint_resources_cardpass()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_resources_cardpass)
end

return slot0
