module("modules.video.AvProEnum", package.seeall)

local var_0_0 = class("AvProEnum")

var_0_0.PlayerStatus = {
	Stalled = 8,
	ReadyToPlay = 1,
	Unstalled = 9,
	Closing = 5,
	StartedBuffering = 13,
	Error = 6,
	PlaylistItemChanged = 16,
	PlaylistFinished = 17,
	FinishedBuffering = 14,
	TextTracksChanged = 18,
	ResolutionChanged = 10,
	TextCueChanged = 7,
	MetaDataReady = 0,
	SubtitleChange = 7,
	Started = 2,
	FinishedPlaying = 4,
	StartedSeeking = 11,
	PropertiesChanged = 15,
	FirstFrameReady = 3,
	FinishedSeeking = 12
}

function var_0_0.getPlayerStatusEnumName(arg_1_0)
	if arg_1_0 == var_0_0.PlayerStatus.MetaDataReady then
		return "MetaDataReady"
	end

	if arg_1_0 == var_0_0.PlayerStatus.ReadyToPlay then
		return "ReadyToPlay"
	end

	if arg_1_0 == var_0_0.PlayerStatus.Started then
		return "Started"
	end

	if arg_1_0 == var_0_0.PlayerStatus.FirstFrameReady then
		return "FirstFrameReady"
	end

	if arg_1_0 == var_0_0.PlayerStatus.FinishedPlaying then
		return "FinishedPlaying"
	end

	if arg_1_0 == var_0_0.PlayerStatus.Closing then
		return "Closing"
	end

	if arg_1_0 == var_0_0.PlayerStatus.Error then
		return "Error"
	end

	if arg_1_0 == var_0_0.PlayerStatus.SubtitleChange then
		return "SubtitleChange"
	end

	if arg_1_0 == var_0_0.PlayerStatus.Stalled then
		return "Stalled"
	end

	if arg_1_0 == var_0_0.PlayerStatus.Unstalled then
		return "Unstalled"
	end

	if arg_1_0 == var_0_0.PlayerStatus.ResolutionChanged then
		return "ResolutionChanged"
	end

	if arg_1_0 == var_0_0.PlayerStatus.StartedSeeking then
		return "StartedSeeking"
	end

	if arg_1_0 == var_0_0.PlayerStatus.FinishedSeeking then
		return "FinishedSeeking"
	end

	if arg_1_0 == var_0_0.PlayerStatus.StartedBuffering then
		return "StartedBuffering"
	end

	if arg_1_0 == var_0_0.PlayerStatus.FinishedBuffering then
		return "FinishedBuffering"
	end

	if arg_1_0 == var_0_0.PlayerStatus.PropertiesChanged then
		return "PropertiesChanged"
	end

	if arg_1_0 == var_0_0.PlayerStatus.PlaylistItemChanged then
		return "PlaylistItemChanged"
	end

	if arg_1_0 == var_0_0.PlayerStatus.PlaylistFinished then
		return "PlaylistFinished"
	end

	if arg_1_0 == var_0_0.PlayerStatus.TextTracksChanged then
		return "TextTracksChanged"
	end

	if arg_1_0 == var_0_0.PlayerStatus.TextCueChanged then
		return "TextCueChanged"
	end

	return "None"
end

var_0_0.ErrorCode = {
	DecodeFailed = 200,
	LoadFailed = 100,
	None = 0
}

function var_0_0.getErrorCodeEnumName(arg_2_0)
	if arg_2_0 == var_0_0.ErrorCode.None then
		return "None"
	end

	if arg_2_0 == var_0_0.ErrorCode.LoadFailed then
		return "LoadFailed"
	end

	if arg_2_0 == var_0_0.ErrorCode.DecodeFailed then
		return "DecodeFailed"
	end

	return "UnKnown"
end

return var_0_0
