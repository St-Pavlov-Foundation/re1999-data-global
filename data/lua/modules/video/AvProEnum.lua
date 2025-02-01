module("modules.video.AvProEnum", package.seeall)

slot0 = class("AvProEnum")
slot0.PlayerStatus = {
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

function slot0.getPlayerStatusEnumName(slot0)
	if slot0 == uv0.PlayerStatus.MetaDataReady then
		return "MetaDataReady"
	end

	if slot0 == uv0.PlayerStatus.ReadyToPlay then
		return "ReadyToPlay"
	end

	if slot0 == uv0.PlayerStatus.Started then
		return "Started"
	end

	if slot0 == uv0.PlayerStatus.FirstFrameReady then
		return "FirstFrameReady"
	end

	if slot0 == uv0.PlayerStatus.FinishedPlaying then
		return "FinishedPlaying"
	end

	if slot0 == uv0.PlayerStatus.Closing then
		return "Closing"
	end

	if slot0 == uv0.PlayerStatus.Error then
		return "Error"
	end

	if slot0 == uv0.PlayerStatus.SubtitleChange then
		return "SubtitleChange"
	end

	if slot0 == uv0.PlayerStatus.Stalled then
		return "Stalled"
	end

	if slot0 == uv0.PlayerStatus.Unstalled then
		return "Unstalled"
	end

	if slot0 == uv0.PlayerStatus.ResolutionChanged then
		return "ResolutionChanged"
	end

	if slot0 == uv0.PlayerStatus.StartedSeeking then
		return "StartedSeeking"
	end

	if slot0 == uv0.PlayerStatus.FinishedSeeking then
		return "FinishedSeeking"
	end

	if slot0 == uv0.PlayerStatus.StartedBuffering then
		return "StartedBuffering"
	end

	if slot0 == uv0.PlayerStatus.FinishedBuffering then
		return "FinishedBuffering"
	end

	if slot0 == uv0.PlayerStatus.PropertiesChanged then
		return "PropertiesChanged"
	end

	if slot0 == uv0.PlayerStatus.PlaylistItemChanged then
		return "PlaylistItemChanged"
	end

	if slot0 == uv0.PlayerStatus.PlaylistFinished then
		return "PlaylistFinished"
	end

	if slot0 == uv0.PlayerStatus.TextTracksChanged then
		return "TextTracksChanged"
	end

	if slot0 == uv0.PlayerStatus.TextCueChanged then
		return "TextCueChanged"
	end

	return "None"
end

slot0.ErrorCode = {
	DecodeFailed = 200,
	LoadFailed = 100,
	None = 0
}

function slot0.getErrorCodeEnumName(slot0)
	if slot0 == uv0.ErrorCode.None then
		return "None"
	end

	if slot0 == uv0.ErrorCode.LoadFailed then
		return "LoadFailed"
	end

	if slot0 == uv0.ErrorCode.DecodeFailed then
		return "DecodeFailed"
	end

	return "UnKnown"
end

return slot0
