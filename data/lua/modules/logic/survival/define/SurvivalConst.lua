module("modules.logic.survival.define.SurvivalConst", package.seeall)

local var_0_0 = _M

var_0_0.CameraTraceTime = 1
var_0_0.MapCameraParams = {
	MaxDis = 10.5,
	MinDis = 6,
	DefaultDis = 7.5
}
var_0_0.CloudHeight = 0.75
var_0_0.Shelter_EpisodeId = 1280601
var_0_0.Survival_EpisodeId = 1280602
var_0_0.EventChoiceColor = {
	Yellow = "#B28135",
	Green = "#7FAA88",
	Gray = "#F5F1EB",
	Red = "#FF7C72"
}
var_0_0.UnitEffectPath = {
	Fly = "survival/effects/prefab/v2a8_scene_yidong.prefab",
	FastFight = "survival/effects/prefab/v2a8_scene_tiaoguo.prefab",
	CreateUnit = "survival/effects/prefab/v2a8_scene_bianshen.prefab",
	UnitType42 = "survival/effects/prefab/v2a8_scene_smoke_01.prefab",
	UnitType44 = "survival/effects/prefab/v2a8_scene_smoke_02.prefab",
	Transfer2 = "survival/effects/prefab/v2a8_scene_chuansong_01.prefab",
	FollowUnit = "survival/effects/prefab/v2a8_scene_jinguang.prefab",
	Transfer1 = "survival/effects/prefab/v2a8_scene_chuansong_02.prefab"
}
var_0_0.UnitEffectTime = {
	[var_0_0.UnitEffectPath.FastFight] = 1,
	[var_0_0.UnitEffectPath.Fly] = 0.4,
	[var_0_0.UnitEffectPath.Transfer1] = 0.8,
	[var_0_0.UnitEffectPath.Transfer2] = 0.8,
	[var_0_0.UnitEffectPath.CreateUnit] = 2
}
var_0_0.CustomDifficulty = 9999
var_0_0.FirstPlayDifficulty = 999
var_0_0.ItemRareColor = {
	"#27682e",
	"#6384E5",
	"#C28DC7",
	"#D2C197",
	"#E99B56",
	"#ff7567"
}
var_0_0.ItemRareColor2 = {
	"#27682e",
	"#324bb6",
	"#804885",
	"#897519",
	"#ac5320",
	"#a40f10"
}
var_0_0.ShelterTagColor = {
	"#986452",
	"#74657F",
	"#6A837F",
	"#5E6D94"
}
var_0_0.TurnDirSpeed = 0.15
var_0_0.PlayerMoveSpeed = 0.4
var_0_0.TornadoTransferTime = 1
var_0_0.TornadoTransferHeight = 0.8
var_0_0.ModelClipTime = 0.4
var_0_0.PlayerClipRate = 0.6

return var_0_0
