module("modules.logic.versionactivity2_4.music.define.VersionActivity2_4MusicEnum", package.seeall)

slot0 = _M
slot0.RecordStatus = {
	NormalAfterRecord = 2,
	RecordPause = 5,
	RecordReady = 3,
	Playing = 7,
	PlayPause = 6,
	Recording = 4,
	Del = 8,
	Normal = 1
}
slot0.TrackStatus = {
	UnRecorded = 2,
	Del = 5,
	Add = 1,
	Inactive = 0
}
slot0.ActionStatus = {
	Record = 2,
	Del = 1
}
slot0.MuteStatus = {
	Close = 0,
	Open = 1
}
slot0.Const = {
	Score = 4,
	MaxTrackCount = 1,
	TrackLength = 2,
	ScoreTime = 5
}
slot0.AccompanyStatus = {
	Close = 0,
	Open = 1
}
slot0.AccompanyType = {
	High = 1,
	Low = 2,
	Drum = 3
}
slot0.AccompanyTypeName = {
	"bakaluoer_rhythm",
	"bakaluoer_mid",
	"bakaluoer_high"
}
slot0.NoteIcon = {
	"do",
	"re",
	"mi",
	"fa",
	"sol",
	"la",
	"si"
}
slot0.SelectInstrumentNum = 2
slot0.BgmPlay = 20240006
slot0.BgmPause = 20240039
slot0.BgmResume = 20240040
slot0.BgmStop = 20240042
slot0.BgmStatus = {
	Resume = 4,
	Play = 1,
	Stop = 3,
	Pause = 2
}
slot0.BeatStatus = {
	Pause = 3,
	End = 4,
	Playing = 2,
	CountDown = 1,
	None = 0
}
slot0.BeatGrade = {
	Miss = 4,
	Cool = 3,
	Great = 2,
	Perfect = 1
}
slot0.BeatGradeStatName = {
	[slot0.BeatGrade.Perfect] = "perfect_num",
	[slot0.BeatGrade.Great] = "great_num",
	[slot0.BeatGrade.Cool] = "cool_num",
	[slot0.BeatGrade.Miss] = "miss_num"
}
slot0.BeatResult = {
	Abort = 3,
	Restart = 4,
	Fail = 2,
	Success = 1
}
slot0.BeatResultStatName = {
	"成功",
	"失败",
	"中断",
	"重新开始"
}
slot0.EpisodeType = {
	Free = 3,
	Story = 1,
	Beat = 2
}
slot0.EpisodeStatus = {
	PlayEndStory = 2,
	Unlock = 0,
	PlayStartStory = 1
}
slot0.EpisodeItemWidth = 475
slot0.ProgressBgWidth = 470
slot0.ProgressLightPos = -1425
slot0.FirstEpisodeId = 1240501
slot0.times_sign = "×"

return slot0
