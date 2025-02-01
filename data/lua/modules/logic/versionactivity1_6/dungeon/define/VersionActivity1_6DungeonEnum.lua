module("modules.logic.versionactivity1_6.dungeon.define.VersionActivity1_6DungeonEnum", package.seeall)

slot0 = _M
slot0.DungeonMapCameraSize = 5
slot0.DungeonChapterId = {
	Story4 = 16201,
	Story = 16101,
	Hard = 16201,
	Story1 = 16101,
	BossFight = 16501,
	Story2 = 16301,
	Story3 = 16401
}
slot0.SceneRootName = "VersionActivity1_6DungeonMapScene"
slot0.EpisodeItemMinWidth = 300
slot0.EpisodeStarType = {
	[slot0.DungeonChapterId.Story1] = "v1a6_dungeon_star_2",
	[slot0.DungeonChapterId.Story2] = "v1a6_dungeon_star_3",
	[slot0.DungeonChapterId.Story3] = "v1a6_dungeon_star_4",
	[slot0.DungeonChapterId.Story4] = "v1a6_dungeon_star_4"
}
slot0.EpisodeStarEmptyType = {
	[slot0.DungeonChapterId.Story1] = "v1a6_dungeon_star_1",
	[slot0.DungeonChapterId.Story2] = "v1a6_dungeon_star_1",
	[slot0.DungeonChapterId.Story3] = "v1a6_dungeon_star_5",
	[slot0.DungeonChapterId.Story4] = "v1a6_dungeon_star_5"
}
slot0.HardModeUnlockAnimDuration = 1.7
slot0.ResPath = {
	BossScheduleItem = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_scheduleitem.prefab",
	BossFightScoreTips = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_ig_scoretips.prefab"
}
slot0.DungeonBossMapElementId = 1610101
slot0.DungeonBossEpisodeId = 1610119
slot0.ModifyBgmEpisodeId = 1610119
slot0.DungeonBossElementHideObjPaths = {
	"Obj-Plant/all/diffuse/m_s08_hddt_qz019_renqun"
}
slot0.DungeonConstId = {
	skill3Icon = 8,
	GoldEffectSkillLv = 5,
	SilverEffectSkillLv = 4,
	MaxSkillLv = 2,
	skill1Icon = 6,
	MaxSkillPointNum = 1,
	skill2Icon = 7,
	skill4Icon = 9
}
slot0.SkillOriginIcon = {
	slot0.DungeonConstId.skill1Icon,
	slot0.DungeonConstId.skill2Icon,
	slot0.DungeonConstId.skill3Icon,
	slot0.DungeonConstId.skill4Icon
}
slot0.skillPointMinNum = 0
slot0.skillPointMaxNum = 7
slot0.skillMaxLv = 7
slot0.skillTypeNum = 4
slot0.SkillKeyPointIdxs = {
	true,
	nil,
	true,
	nil,
	nil,
	nil,
	true
}
slot0.bossMaxOrder = 5

return slot0
