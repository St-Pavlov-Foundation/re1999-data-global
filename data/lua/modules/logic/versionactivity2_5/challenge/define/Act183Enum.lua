module("modules.logic.versionactivity2_5.challenge.define.Act183Enum", package.seeall)

local var_0_0 = _M

var_0_0.EpisodeType = {
	Sub = 2,
	Boss = 1
}
var_0_0.GroupType = {
	NormalMain = 2,
	Daily = 1,
	HardMain = 3
}
var_0_0.EpisodeStatus = {
	Finished = 3,
	Locked = 1,
	Unlocked = 2
}
var_0_0.GroupStatus = {
	Finished = 3,
	Locked = 1,
	Unlocked = 2
}
var_0_0.RuleStatus = {
	Repress = 2,
	Enabled = 0,
	Escape = 1
}
var_0_0.TaskListItemType = {
	Head = 1,
	Task = 2,
	OneKey = 3
}
var_0_0.TaskItemHeightMap = {
	[var_0_0.TaskListItemType.Head] = 52,
	[var_0_0.TaskListItemType.Task] = 158,
	[var_0_0.TaskListItemType.OneKey] = 158
}
var_0_0.TaskType = {
	NormalMain = 2,
	Daily = 1,
	HardMain = 3
}
var_0_0.TaskSubType = {
	Core = 1,
	Addition = 2
}
var_0_0.GroupTypeToTaskType = {
	[var_0_0.GroupType.Daily] = var_0_0.TaskType.Daily,
	[var_0_0.GroupType.NormalMain] = var_0_0.TaskType.NormalMain,
	[var_0_0.GroupType.HardMain] = var_0_0.TaskType.HardMain
}
var_0_0.HeroType = {
	Trial = 2,
	Normal = 1
}
var_0_0.MaxMainSubEpisodesNum = 4
var_0_0.MaxDailySubEpisodesNum = 3
var_0_0.MainGroupMaxBossEpisodeNum = 1
var_0_0.BossEpisodeMaxHeroNum = 5
var_0_0.Const = {
	MaxBadgeNum = 1,
	BadgeItemId = 6,
	PlayerClothIds = 7,
	RoundStage = 5
}
var_0_0.RuleEscapeAnimType = {
	Middle_Negative = 4,
	Large_Left_Positive = 5,
	Large_Left_Negative = 7,
	Short_Positive = 1,
	Large_Right_Negative = 8,
	Short_Negative = 2,
	Middle_Positive = 3,
	Large_Right_Positive = 6
}

return var_0_0
