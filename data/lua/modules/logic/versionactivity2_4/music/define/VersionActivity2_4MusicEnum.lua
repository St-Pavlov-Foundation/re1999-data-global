module("modules.logic.versionactivity2_4.music.define.VersionActivity2_4MusicEnum", package.seeall)

local var_0_0 = _M

var_0_0.RecordStatus = {
	NormalAfterRecord = 2,
	RecordPause = 5,
	RecordReady = 3,
	Playing = 7,
	PlayPause = 6,
	Recording = 4,
	Del = 8,
	Normal = 1
}
var_0_0.TrackStatus = {
	UnRecorded = 2,
	Del = 5,
	Add = 1,
	Inactive = 0
}
var_0_0.ActionStatus = {
	Record = 2,
	Del = 1
}
var_0_0.MuteStatus = {
	Close = 0,
	Open = 1
}
var_0_0.Const = {
	Score = 4,
	MaxTrackCount = 1,
	TrackLength = 2,
	ScoreTime = 5
}
var_0_0.AccompanyStatus = {
	Close = 0,
	Open = 1
}
var_0_0.AccompanyType = {
	High = 1,
	Low = 2,
	Drum = 3
}
var_0_0.AccompanyTypeName = {
	"bakaluoer_rhythm",
	"bakaluoer_mid",
	"bakaluoer_high"
}
var_0_0.NoteIcon = {
	"do",
	"re",
	"mi",
	"fa",
	"sol",
	"la",
	"si"
}
var_0_0.SelectInstrumentNum = 2
var_0_0.BgmPlay = 20240006
var_0_0.BgmPause = 20240039
var_0_0.BgmResume = 20240040
var_0_0.BgmStop = 20240042
var_0_0.BgmStatus = {
	Resume = 4,
	Play = 1,
	Stop = 3,
	Pause = 2
}
var_0_0.BeatStatus = {
	Pause = 3,
	End = 4,
	Playing = 2,
	CountDown = 1,
	None = 0
}
var_0_0.BeatGrade = {
	Miss = 4,
	Cool = 3,
	Great = 2,
	Perfect = 1
}
var_0_0.BeatGradeStatName = {
	[var_0_0.BeatGrade.Perfect] = "perfect_num",
	[var_0_0.BeatGrade.Great] = "great_num",
	[var_0_0.BeatGrade.Cool] = "cool_num",
	[var_0_0.BeatGrade.Miss] = "miss_num"
}
var_0_0.BeatResult = {
	Abort = 3,
	Restart = 4,
	Fail = 2,
	Success = 1
}
var_0_0.BeatResultStatName = {
	"成功",
	"失败",
	"中断",
	"重新开始"
}
var_0_0.EpisodeType = {
	Free = 3,
	Story = 1,
	Beat = 2
}
var_0_0.EpisodeStatus = {
	PlayEndStory = 2,
	Unlock = 0,
	PlayStartStory = 1
}
var_0_0.EpisodeItemWidth = 475
var_0_0.ProgressBgWidth = 470
var_0_0.ProgressLightPos = -1425
var_0_0.FirstEpisodeId = 1240501
var_0_0.times_sign = "×"

return var_0_0
