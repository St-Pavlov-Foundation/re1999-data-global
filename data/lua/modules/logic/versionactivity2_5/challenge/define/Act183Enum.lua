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
var_0_0.EpisodeClsType = {
	[Act183Helper.getEpisodeClsKey(var_0_0.GroupType.Daily, var_0_0.EpisodeType.Boss)] = Act183DailyEpisodeItem,
	[Act183Helper.getEpisodeClsKey(var_0_0.GroupType.Daily, var_0_0.EpisodeType.Sub)] = Act183DailyEpisodeItem,
	[Act183Helper.getEpisodeClsKey(var_0_0.GroupType.NormalMain, var_0_0.EpisodeType.Boss)] = Act183MainBossEpisodeItem,
	[Act183Helper.getEpisodeClsKey(var_0_0.GroupType.NormalMain, var_0_0.EpisodeType.Sub)] = Act183MainNormalEpisodeItem,
	[Act183Helper.getEpisodeClsKey(var_0_0.GroupType.HardMain, var_0_0.EpisodeType.Boss)] = Act183MainBossEpisodeItem,
	[Act183Helper.getEpisodeClsKey(var_0_0.GroupType.HardMain, var_0_0.EpisodeType.Sub)] = Act183MainNormalEpisodeItem
}
var_0_0.GroupCategoryClsType = {
	[var_0_0.GroupType.Daily] = Act183DungeonBaseGroupItem,
	[var_0_0.GroupType.NormalMain] = Act183DungeonBaseGroupItem,
	[var_0_0.GroupType.HardMain] = Act183DungeonHardMainGroupItem
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
var_0_0.TaskNameLangId = {
	[var_0_0.TaskType.Daily] = "act183taskview_dailytask",
	[var_0_0.TaskType.NormalMain] = "act183taskview_normalmaintask",
	[var_0_0.TaskType.HardMain] = "act183taskview_hardmaintask"
}
var_0_0.HeroType = {
	Trial = 2,
	Normal = 1
}
var_0_0.MaxMainSubEpisodesNum = 4
var_0_0.MaxDailySubEpisodesNum = 3
var_0_0.MainGroupBossEpisodeNum = 1
var_0_0.BossEpisodeMaxHeroNum = 5
var_0_0.Const = {
	MaxBadgeNum = 1,
	BadgeItemId = 6,
	PlayerClothIds = 7,
	RoundStage = 5
}
var_0_0.RuleEscapeAnimType = {
	RightTop2Center = 10,
	RightTop2LeftBottom = 6,
	LeftTop2RightBottom = 5,
	LeftTop2Center = 9,
	LeftBottom2Center = 11,
	LeftBottom2RightTop = 7,
	Top2Bottom = 1,
	RightBottom2LeftTop = 8,
	RightBottom2Center = 12,
	Bottom2Top = 2,
	Right2Left = 4,
	Left2Right = 3
}
var_0_0.ConditionStatus = {
	Pass = 2,
	Pass_Unselect = 3,
	Pass_Select = 4,
	Unpass = 1
}
var_0_0.ConditionStarImgName = {
	[var_0_0.ConditionStatus.Unpass] = "v2a5_challenge_settlement_bossstar1",
	[var_0_0.ConditionStatus.Pass] = "v2a5_challenge_settlement_bossstar2",
	[var_0_0.ConditionStatus.Pass_Unselect] = "v2a5_challenge_settlement_bossstar3",
	[var_0_0.ConditionStatus.Pass_Select] = "v2a5_challenge_settlement_bossstar2"
}
var_0_0.BattleNumToSnapShotType = {
	Default = ModuleEnum.HeroGroupSnapshotType.Act183Boss,
	[4] = ModuleEnum.HeroGroupSnapshotType.Act183Normal,
	[5] = ModuleEnum.HeroGroupSnapshotType.Act183Boss
}
var_0_0.EpisodeMaxStarNum = 3
var_0_0.ActType = 183
var_0_0.StoreEntryPrefabUrl = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_storeentry.prefab"

return var_0_0
