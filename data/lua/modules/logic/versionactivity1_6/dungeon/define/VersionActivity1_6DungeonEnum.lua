module("modules.logic.versionactivity1_6.dungeon.define.VersionActivity1_6DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.DungeonMapCameraSize = 5
var_0_0.DungeonChapterId = {
	Story4 = 16201,
	Story = 16101,
	Hard = 16201,
	Story1 = 16101,
	BossFight = 16501,
	Story2 = 16301,
	Story3 = 16401
}
var_0_0.SceneRootName = "VersionActivity1_6DungeonMapScene"
var_0_0.EpisodeItemMinWidth = 300
var_0_0.EpisodeStarType = {
	[var_0_0.DungeonChapterId.Story1] = "v1a6_dungeon_star_2",
	[var_0_0.DungeonChapterId.Story2] = "v1a6_dungeon_star_3",
	[var_0_0.DungeonChapterId.Story3] = "v1a6_dungeon_star_4",
	[var_0_0.DungeonChapterId.Story4] = "v1a6_dungeon_star_4"
}
var_0_0.EpisodeStarEmptyType = {
	[var_0_0.DungeonChapterId.Story1] = "v1a6_dungeon_star_1",
	[var_0_0.DungeonChapterId.Story2] = "v1a6_dungeon_star_1",
	[var_0_0.DungeonChapterId.Story3] = "v1a6_dungeon_star_5",
	[var_0_0.DungeonChapterId.Story4] = "v1a6_dungeon_star_5"
}
var_0_0.HardModeUnlockAnimDuration = 1.7
var_0_0.ResPath = {
	BossScheduleItem = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_scheduleitem.prefab",
	BossFightScoreTips = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_ig_scoretips.prefab"
}
var_0_0.DungeonBossMapElementId = 1610101
var_0_0.DungeonBossEpisodeId = 1610119
var_0_0.ModifyBgmEpisodeId = 1610119
var_0_0.DungeonBossElementHideObjPaths = {
	"Obj-Plant/all/diffuse/m_s08_hddt_qz019_renqun"
}
var_0_0.DungeonConstId = {
	skill3Icon = 8,
	GoldEffectSkillLv = 5,
	SilverEffectSkillLv = 4,
	MaxSkillLv = 2,
	skill1Icon = 6,
	MaxSkillPointNum = 1,
	skill2Icon = 7,
	skill4Icon = 9
}
var_0_0.SkillOriginIcon = {
	var_0_0.DungeonConstId.skill1Icon,
	var_0_0.DungeonConstId.skill2Icon,
	var_0_0.DungeonConstId.skill3Icon,
	var_0_0.DungeonConstId.skill4Icon
}
var_0_0.skillPointMinNum = 0
var_0_0.skillPointMaxNum = 7
var_0_0.skillMaxLv = 7
var_0_0.skillTypeNum = 4
var_0_0.SkillKeyPointIdxs = {
	true,
	nil,
	true,
	nil,
	nil,
	nil,
	true
}
var_0_0.bossMaxOrder = 8

return var_0_0
