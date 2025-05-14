module("modules.logic.summon.defines.SummonEnum", package.seeall)

local var_0_0 = _M

var_0_0.SummonSceneId = 501
var_0_0.SummonEquipSceneId = 502
var_0_0.SummonCharScenePath = "scenes/m_s06_summon/m_s06_summon_p_real.prefab"
var_0_0.SummonEquipPreloadPath = {
	EquipUISR = "scenes/m_s03_xx/s03_ui_sr.prefab",
	EquipBoomR = "scenes/m_s03_xx/equip_r.prefab",
	EquipUIN = "scenes/m_s03_xx/s03_ui_n.prefab",
	EquipBoomN = "scenes/m_s03_xx/equip_n.prefab",
	EquipUISSR = "scenes/m_s03_xx/s03_ui_ssr.prefab",
	EquipUIR = "scenes/m_s03_xx/s03_ui_r.prefab",
	EquipBoomSR = "scenes/m_s03_xx/equip_sr.prefab",
	EquipBoomSSR = "scenes/m_s03_xx/equip_ssr.prefab"
}
var_0_0.SummonCharPreloadPath = {
	UIN = "scenes/m_s06_summon/s06_ui_n.prefab",
	SceneSRStep1 = "scenes/m_s06_summon/s06_effect_sr_chuxian_1.prefab",
	UIR = "scenes/m_s06_summon/s06_ui_r.prefab",
	SceneNWheel = "scenes/m_s06_summon/s06_effect_n_lunzhuan.prefab",
	SceneRStep3 = "scenes/m_s06_summon/s06_effect_r_chuxian_3.prefab",
	SceneSSRStep2 = "scenes/m_s06_summon/s06_effect_ssr_chuxian_2.prefab",
	SceneSSRStep1 = "scenes/m_s06_summon/s06_effect_ssr_chuxian_1.prefab",
	SceneSSRWheel = "scenes/m_s06_summon/s06_effect_ssr_lunzhuan.prefab",
	SceneRWheel = "scenes/m_s06_summon/s06_effect_r_lunzhuan.prefab",
	SceneRollWaterL = "scenes/m_s06_summon/s06_effect_ssr_shuihua_zuo.prefab",
	SceneRStep1 = "scenes/m_s06_summon/s06_effect_r_chuxian_1.prefab",
	SceneNBoom = "scenes/m_s06_summon/s06_effect_n_baofa.prefab",
	SceneRStep2 = "scenes/m_s06_summon/s06_effect_r_chuxian_2.prefab",
	SceneSRStep3 = "scenes/m_s06_summon/s06_effect_sr_chuxian_3.prefab",
	SceneNStep3 = "scenes/m_s06_summon/s06_effect_n_chuxian_3.prefab",
	SceneSRBoom = "scenes/m_s06_summon/s06_effect_sr_baofa.prefab",
	UISSR = "scenes/m_s06_summon/s06_ui_ssr.prefab",
	SceneRBoom = "scenes/m_s06_summon/s06_effect_r_baofa.prefab",
	SceneSSRStep3 = "scenes/m_s06_summon/s06_effect_ssr_chuxian_3.prefab",
	UISR = "scenes/m_s06_summon/s06_ui_sr.prefab",
	SceneSRWheel = "scenes/m_s06_summon/s06_effect_sr_lunzhuan.prefab",
	SceneRollWaterR = "scenes/m_s06_summon/s06_effect_ssr_shuihua_you.prefab",
	SceneSSRBoom = "scenes/m_s06_summon/s06_effect_ssr_baofa.prefab",
	SceneSRStep2 = "scenes/m_s06_summon/s06_effect_sr_chuxian_2.prefab",
	SceneNStep1 = "scenes/m_s06_summon/s06_effect_n_chuxian_1.prefab",
	SceneNStep2 = "scenes/m_s06_summon/s06_effect_n_chuxian_2.prefab"
}
var_0_0.SummonLuckyBagPreloadPath = {
	UILuckyBag = "scenes/m_s06_summon/s06_ui_luckybag.prefab"
}
var_0_0.SummonPreloadPath = tabletool.copy(var_0_0.SummonEquipPreloadPath)

for iter_0_0, iter_0_1 in pairs(var_0_0.SummonCharPreloadPath) do
	var_0_0.SummonPreloadPath[iter_0_0] = iter_0_1
end

var_0_0.SummonQualityDefine = {
	"N",
	"N",
	"R",
	"SR",
	"SSR"
}
var_0_0.TenAnimationName = "m_s06_summon_anim_a"
var_0_0.SingleAnimationName = "m_s06_summon_anim_b"
var_0_0.EquipTenAnimationName = "m_s03_xx_p_a"
var_0_0.EquipSingleAnimationName = "m_s03_xx_p_b"
var_0_0.SummonSkipCharacterAnimationName = "m_s06_summon_anim_c"
var_0_0.SummonSkipAnimationName = "none"
var_0_0.InitialStateAnimationName = "m_s06_summon_anim_in"
var_0_0.InitialStateEquipAnimationName = "m_s03_xx_p_in"
var_0_0.GuideInitialStateAnimationName = "m_s06_summon_anim_story02"
var_0_0.SummonOpenAnimationName = "m_s06_summon_anim_story01"
var_0_0.SummonFogAnimationName = "m_s06_summon_anim_story02"
var_0_0.SummonWheelAnimationName = "m_s06_summon_anim_story03"
var_0_0.SummonCharAnimationEnter = "open"
var_0_0.SummonCharAnimationSwitch = "switch"
var_0_0.SummonEquipAnimationSwitch = "switch"
var_0_0.AnimationName = {
	[var_0_0.SummonPreloadPath.UIN] = "m_s06_summon_anim_b04",
	[var_0_0.SummonPreloadPath.UIR] = "m_s06_summon_anim_b03",
	[var_0_0.SummonPreloadPath.UISR] = "m_s06_summon_anim_b02",
	[var_0_0.SummonPreloadPath.UISSR] = "m_s06_summon_anim_b01",
	[var_0_0.SummonPreloadPath.EquipUIN] = "m_s06_summon_anim_b04",
	[var_0_0.SummonPreloadPath.EquipUIR] = "m_s06_summon_anim_b03",
	[var_0_0.SummonPreloadPath.EquipUISR] = "m_s06_summon_anim_b02",
	[var_0_0.SummonPreloadPath.EquipUISSR] = "m_s06_summon_anim_b01",
	[var_0_0.SummonLuckyBagPreloadPath.UILuckyBag] = "m_s06_summon_anim_b01"
}
var_0_0.UIMaterialPath = {
	[var_0_0.SummonPreloadPath.UIN] = {
		"s06_ui_obj_a/s06_ui_obj_d001",
		"s06_ui_obj_a_mirror/s06_ui_obj_d001"
	},
	[var_0_0.SummonPreloadPath.UIR] = {
		"s06_ui_obj_a/s06_ui_obj_c001",
		"s06_ui_obj_a_mirror/s06_ui_obj_c001"
	},
	[var_0_0.SummonPreloadPath.UISR] = {
		"s06_ui_obj_a/s06_ui_obj_b001",
		"s06_ui_obj_a_mirror/s06_ui_obj_b001"
	},
	[var_0_0.SummonPreloadPath.UISSR] = {
		"s06_ui_obj_a/s06_ui_obj_a001",
		"s06_ui_obj_a_mirror/s06_ui_obj_a001"
	},
	[var_0_0.SummonPreloadPath.EquipUIN] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[var_0_0.SummonPreloadPath.EquipUIR] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[var_0_0.SummonPreloadPath.EquipUISR] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[var_0_0.SummonPreloadPath.EquipUISSR] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[var_0_0.SummonLuckyBagPreloadPath.UILuckyBag] = {
		"s06_ui_obj_a",
		"s06_ui_obj_a_mirror"
	}
}
var_0_0.BoomEquipEffectAnimationName = {
	[var_0_0.SummonPreloadPath.EquipBoomN] = "s03_ui_ssr_in",
	[var_0_0.SummonPreloadPath.EquipBoomR] = "s03_ui_ssr_in",
	[var_0_0.SummonPreloadPath.EquipBoomSR] = "s03_ui_ssr_in",
	[var_0_0.SummonPreloadPath.EquipBoomSSR] = "s03_ui_ssr_in"
}
var_0_0.EquipUIAnim = {
	RootGachaStartRare3 = "_white",
	RootGachaIn = "go_controller_in",
	LightGacha10 = "shiying02_x10_in",
	RootGachaStartRare4 = "_purple",
	RootGachaStartRare5 = "_golden",
	RootGachaStart1Prefix = "go_controller_summonequip_x1",
	RootGachaStart10Prefix = "go_controller_summonequip_x10",
	LightGacha1 = "shiying01_x1_in"
}
var_0_0.EquipFloatIconFrameNode = "s03_ui_obj_a"
var_0_0.EquipFloatIconFrameBeforeOpen = "scenes/dynamic/m_s03_xx/textures/m_s03_ui_obj.png"
var_0_0.EquipFloatIconFrameOpened = "scenes/dynamic/m_s03_xx/textures/m_s03_ui_open.png"
var_0_0.EquipDefaultIconPath = "singlebg/summon/equip/xray.png"
var_0_0.Type = {
	Limit = 6,
	NewPlayer = 201,
	CustomPick = 7,
	StrongCustomOnePick = 12,
	Newbie = 1,
	LuckyBag = 5,
	MultiProbUp4 = 4,
	ProbUp = 3,
	DoubleSsrUp = 202,
	Normal = 2
}
var_0_0.ResultType = {
	Char = 1,
	Equip = 2,
	MaxCount = 2
}
var_0_0.SummonCallingType = {
	Summon = 1,
	SummonSimulation = 2
}
var_0_0.TabContentIndex = {
	CharNormal = 1,
	CharNewbie = 3,
	EquipNormal = 2,
	EquipProbUp = 5,
	CharProbUp = 4
}
var_0_0.Type2PageIndex = {
	[var_0_0.Type.NewPlayer] = var_0_0.TabContentIndex.CharProbUp,
	[var_0_0.Type.DoubleSsrUp] = var_0_0.TabContentIndex.CharProbUp,
	var_0_0.TabContentIndex.CharNewbie,
	var_0_0.TabContentIndex.CharNormal,
	var_0_0.TabContentIndex.CharProbUp,
	var_0_0.TabContentIndex.CharProbUp,
	var_0_0.TabContentIndex.CharProbUp,
	var_0_0.TabContentIndex.CharProbUp,
	var_0_0.TabContentIndex.CharProbUp,
	[10] = var_0_0.TabContentIndex.EquipNormal,
	[11] = var_0_0.TabContentIndex.EquipProbUp
}
var_0_0.Type2Result = {
	var_0_0.ResultType.Char,
	var_0_0.ResultType.Char,
	var_0_0.ResultType.Char,
	var_0_0.ResultType.Char,
	var_0_0.ResultType.Char,
	var_0_0.ResultType.Char,
	var_0_0.ResultType.Char,
	[10] = var_0_0.ResultType.Equip,
	[11] = var_0_0.ResultType.Equip
}
var_0_0.GuidePoolId = 2
var_0_0.GuideIdSet = {
	[163] = 1,
	[103] = 1
}
var_0_0.HistoryColor = {
	"#272525bf",
	"#272525bf",
	"#272525bf",
	"#aa7e1d",
	"#bc4d02"
}
var_0_0.HistoryNameStarFormat = {
	"%s",
	"%s",
	"%s",
	"%s(5    )",
	"%s(6    )"
}
var_0_0.DetailParagraphType = {
	SpaceOne = 1,
	Normal = 0
}
var_0_0.BannerFlagType = {
	Limit = 3,
	Activity = 2,
	Newbie = 1,
	Reprint = 4
}
var_0_0.TenSummonAgainOpen = false
var_0_0.MultiProbUp4ShowRate = 25
var_0_0.LuckyBagRare = 5
var_0_0.CustomPickRare = 5
var_0_0.PoolId = {
	Normal = 2,
	QuNiang = 16111
}
var_0_0.ChooseNeedFirstHeroIds = {
	3025
}

return var_0_0
