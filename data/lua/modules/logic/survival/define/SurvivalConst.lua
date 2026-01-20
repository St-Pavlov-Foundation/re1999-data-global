-- chunkname: @modules/logic/survival/define/SurvivalConst.lua

module("modules.logic.survival.define.SurvivalConst", package.seeall)

local SurvivalConst = _M

SurvivalConst.CameraTraceTime = 1
SurvivalConst.MapCameraParams = {
	MaxDis = 10.5,
	MinDis = 6,
	DefaultDis = 7.5
}
SurvivalConst.CloudHeight = 0.75
SurvivalConst.Shelter_EpisodeId = 1280601
SurvivalConst.Survival_EpisodeId = 1280602
SurvivalConst.EventChoiceColor = {
	Yellow = "#B28135",
	Green = "#7FAA88",
	Gray = "#F5F1EB",
	Red = "#FF7C72"
}
SurvivalConst.UnitEffectPath = {
	Fly = "survival/effects/prefab/v2a8_scene_yidong.prefab",
	FastFight = "survival/effects/prefab/v2a8_scene_tiaoguo.prefab",
	CreateUnit = "survival/effects/prefab/v2a8_scene_bianshen.prefab",
	UnitType42 = "survival/effects/prefab/v2a8_scene_smoke_01.prefab",
	UnitType44 = "survival/effects/prefab/v2a8_scene_smoke_02.prefab",
	Transfer2 = "survival/effects/prefab/v2a8_scene_chuansong_01.prefab",
	FollowUnit = "survival/effects/prefab/v2a8_scene_jinguang.prefab",
	Transfer1 = "survival/effects/prefab/v2a8_scene_chuansong_02.prefab"
}
SurvivalConst.UnitEffectTime = {
	[SurvivalConst.UnitEffectPath.FastFight] = 1,
	[SurvivalConst.UnitEffectPath.Fly] = 0.4,
	[SurvivalConst.UnitEffectPath.Transfer1] = 0.8,
	[SurvivalConst.UnitEffectPath.Transfer2] = 0.8,
	[SurvivalConst.UnitEffectPath.CreateUnit] = 2
}
SurvivalConst.CustomDifficulty = 9999
SurvivalConst.FirstPlayDifficulty = 999
SurvivalConst.ItemRareColor = {
	"#27682e",
	"#6384E5",
	"#C28DC7",
	"#D2C197",
	"#E99B56",
	"#ff7567"
}
SurvivalConst.ItemRareColor2 = {
	"#27682e",
	"#324bb6",
	"#804885",
	"#897519",
	"#ac5320",
	"#a40f10"
}
SurvivalConst.ShelterTagColor = {
	"#986452",
	"#74657F",
	"#6A837F",
	"#5E6D94"
}
SurvivalConst.TurnDirSpeed = 0.15
SurvivalConst.PlayerMoveSpeed = 0.4
SurvivalConst.TornadoTransferTime = 1
SurvivalConst.TornadoTransferHeight = 0.8
SurvivalConst.ModelClipTime = 0.4
SurvivalConst.PlayerClipRate = 0.6

return SurvivalConst
