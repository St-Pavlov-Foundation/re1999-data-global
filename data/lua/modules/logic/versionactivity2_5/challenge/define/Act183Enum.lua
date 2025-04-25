module("modules.logic.versionactivity2_5.challenge.define.Act183Enum", package.seeall)

slot0 = _M
slot0.EpisodeType = {
	Sub = 2,
	Boss = 1
}
slot0.GroupType = {
	NormalMain = 2,
	Daily = 1,
	HardMain = 3
}
slot0.EpisodeStatus = {
	Finished = 3,
	Locked = 1,
	Unlocked = 2
}
slot0.GroupStatus = {
	Finished = 3,
	Locked = 1,
	Unlocked = 2
}
slot0.RuleStatus = {
	Repress = 2,
	Enabled = 0,
	Escape = 1
}
slot0.TaskListItemType = {
	Head = 1,
	Task = 2,
	OneKey = 3
}
slot0.TaskItemHeightMap = {
	[slot0.TaskListItemType.Head] = 52,
	[slot0.TaskListItemType.Task] = 158,
	[slot0.TaskListItemType.OneKey] = 158
}
slot0.TaskType = {
	NormalMain = 2,
	Daily = 1,
	HardMain = 3
}
slot0.TaskSubType = {
	Core = 1,
	Addition = 2
}
slot0.GroupTypeToTaskType = {
	[slot0.GroupType.Daily] = slot0.TaskType.Daily,
	[slot0.GroupType.NormalMain] = slot0.TaskType.NormalMain,
	[slot0.GroupType.HardMain] = slot0.TaskType.HardMain
}
slot0.HeroType = {
	Trial = 2,
	Normal = 1
}
slot0.MaxMainSubEpisodesNum = 4
slot0.MaxDailySubEpisodesNum = 3
slot0.MainGroupMaxBossEpisodeNum = 1
slot0.BossEpisodeMaxHeroNum = 5
slot0.Const = {
	MaxBadgeNum = 1,
	BadgeItemId = 6,
	PlayerClothIds = 7,
	RoundStage = 5
}
slot0.RuleEscapeAnimType = {
	Middle_Negative = 4,
	Large_Left_Positive = 5,
	Large_Left_Negative = 7,
	Short_Positive = 1,
	Large_Right_Negative = 8,
	Short_Negative = 2,
	Middle_Positive = 3,
	Large_Right_Positive = 6
}

return slot0
