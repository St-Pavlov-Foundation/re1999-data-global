module("modules.logic.versionactivity2_4.music.model.VersionActivity2_4MusicTrackMo", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicTrackMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.index = nil
	arg_1_0.status = VersionActivity2_4MusicEnum.TrackStatus.Inactive
	arg_1_0.recordTotalTime = 0
	arg_1_0.mute = VersionActivity2_4MusicEnum.MuteStatus.Close
	arg_1_0.timeline = {}
end

function var_0_0.canSave(arg_2_0)
	return arg_2_0.recordTotalTime > 0
end

function var_0_0.encode(arg_3_0)
	local var_3_0 = {
		index = arg_3_0.index,
		recordTotalTime = arg_3_0.recordTotalTime,
		mute = arg_3_0.mute,
		timeline = arg_3_0.timeline
	}

	return cjson.encode(var_3_0)
end

function var_0_0.setMute(arg_4_0, arg_4_1)
	arg_4_0.mute = not arg_4_1 and VersionActivity2_4MusicEnum.MuteStatus.Close or VersionActivity2_4MusicEnum.MuteStatus.Open
end

function var_0_0.setDelSelected(arg_5_0, arg_5_1)
	arg_5_0.isDelSelected = arg_5_1
end

return var_0_0
