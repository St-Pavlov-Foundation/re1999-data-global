module("modules.logic.room.entity.work.RoomAtmosphereEffectWork", package.seeall)

local var_0_0 = class("RoomAtmosphereEffectWork", BaseWork)
local var_0_1 = 0.3

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._effectId = arg_1_1
	arg_1_0._effResPath = RoomConfig.instance:getRoomEffectPath(arg_1_1)

	local var_1_0

	if not GameResMgr.IsFromEditorDir then
		var_1_0 = FightHelper.getEffectAbPath(arg_1_0._effResPath)
	end

	arg_1_0._effGO = RoomGOPool.getInstance(arg_1_0._effResPath, arg_1_2, "effect_" .. arg_1_1, var_1_0)
	arg_1_0._playingId = nil
	arg_1_0._tmpAudioId = nil

	gohelper.setActive(arg_1_0._effGO, false)
end

function var_0_0.onStart(arg_2_0)
	gohelper.setActive(arg_2_0._effGO, false)
	gohelper.setActive(arg_2_0._effGO, true)

	local var_2_0 = RoomConfig.instance:getRoomEffectDuration(arg_2_0._effectId)

	if var_2_0 <= 0 then
		arg_2_0:finish(true)
	else
		local var_2_1 = RoomConfig.instance:getRoomEffectAudioId(arg_2_0._effectId)

		if var_2_1 and var_2_1 ~= 0 and not gohelper.isNil(arg_2_0._effGO) then
			arg_2_0._tmpAudioId = var_2_1

			TaskDispatcher.runDelay(arg_2_0.delayPlayAudio, arg_2_0, var_0_1)
		end

		TaskDispatcher.runDelay(arg_2_0.finish, arg_2_0, var_2_0)
	end
end

function var_0_0.delayPlayAudio(arg_3_0)
	arg_3_0._playingId = AudioMgr.instance:trigger(arg_3_0._tmpAudioId, arg_3_0._effGO)
	arg_3_0._tmpAudioId = nil
end

function var_0_0.setAudioIsFade(arg_4_0, arg_4_1)
	if gohelper.isNil(arg_4_0._effGO) then
		return
	end

	local var_4_0 = AudioEnum.Room.set_firework_normal

	if arg_4_1 then
		var_4_0 = AudioEnum.Room.set_firework_lower
	end

	AudioMgr.instance:trigger(var_4_0, arg_4_0._effGO)
end

function var_0_0.finish(arg_5_0, arg_5_1)
	local var_5_0 = not arg_5_1

	arg_5_0:onDone(var_5_0)
end

function var_0_0.clearWork(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.finish, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.delayPlayAudio, arg_6_0)

	if not gohelper.isNil(arg_6_0._effGO) then
		gohelper.setActive(arg_6_0._effGO, false)
		AudioMgr.instance:trigger(AudioEnum.Room.stop_home_activity_firework, arg_6_0._effGO)
	elseif arg_6_0._playingId then
		AudioMgr.instance:stopPlayingID(arg_6_0._playingId)

		arg_6_0._playingId = nil
	end
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0:clearWork()
	RoomGOPool.returnInstance(arg_7_0._effResPath, arg_7_0._effGO)

	arg_7_0._effGO = nil
	arg_7_0._effectId = nil
	arg_7_0._effResPath = nil
	arg_7_0._tmpAudioId = nil
end

return var_0_0
