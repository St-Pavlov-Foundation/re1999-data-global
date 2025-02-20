module("modules.logic.summon.defines.SummonEnum", package.seeall)

slot0 = _M
slot0.SummonSceneId = 501
slot0.SummonEquipSceneId = 502
slot0.SummonCharScenePath = "scenes/m_s06_summon/m_s06_summon_p_real.prefab"
slot0.SummonEquipPreloadPath = {
	EquipUISR = "scenes/m_s03_xx/s03_ui_sr.prefab",
	EquipBoomR = "scenes/m_s03_xx/equip_r.prefab",
	EquipUIN = "scenes/m_s03_xx/s03_ui_n.prefab",
	EquipBoomN = "scenes/m_s03_xx/equip_n.prefab",
	EquipUISSR = "scenes/m_s03_xx/s03_ui_ssr.prefab",
	EquipUIR = "scenes/m_s03_xx/s03_ui_r.prefab",
	EquipBoomSR = "scenes/m_s03_xx/equip_sr.prefab",
	EquipBoomSSR = "scenes/m_s03_xx/equip_ssr.prefab"
}
slot0.SummonCharPreloadPath = {
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
slot0.SummonLuckyBagPreloadPath = {
	UILuckyBag = "scenes/m_s06_summon/s06_ui_luckybag.prefab"
}
slot0.SummonPreloadPath = tabletool.copy(slot0.SummonEquipPreloadPath)

for slot4, slot5 in pairs(slot0.SummonCharPreloadPath) do
	slot0.SummonPreloadPath[slot4] = slot5
end

slot0.SummonQualityDefine = {
	"N",
	"N",
	"R",
	"SR",
	"SSR"
}
slot0.TenAnimationName = "m_s06_summon_anim_a"
slot0.SingleAnimationName = "m_s06_summon_anim_b"
slot0.EquipTenAnimationName = "m_s03_xx_p_a"
slot0.EquipSingleAnimationName = "m_s03_xx_p_b"
slot0.SummonSkipCharacterAnimationName = "m_s06_summon_anim_c"
slot0.SummonSkipAnimationName = "none"
slot0.InitialStateAnimationName = "m_s06_summon_anim_in"
slot0.InitialStateEquipAnimationName = "m_s03_xx_p_in"
slot0.GuideInitialStateAnimationName = "m_s06_summon_anim_story02"
slot0.SummonOpenAnimationName = "m_s06_summon_anim_story01"
slot0.SummonFogAnimationName = "m_s06_summon_anim_story02"
slot0.SummonWheelAnimationName = "m_s06_summon_anim_story03"
slot0.SummonCharAnimationEnter = "open"
slot0.SummonCharAnimationSwitch = "switch"
slot0.SummonEquipAnimationSwitch = "switch"
slot0.AnimationName = {
	[slot0.SummonPreloadPath.UIN] = "m_s06_summon_anim_b04",
	[slot0.SummonPreloadPath.UIR] = "m_s06_summon_anim_b03",
	[slot0.SummonPreloadPath.UISR] = "m_s06_summon_anim_b02",
	[slot0.SummonPreloadPath.UISSR] = "m_s06_summon_anim_b01",
	[slot0.SummonPreloadPath.EquipUIN] = "m_s06_summon_anim_b04",
	[slot0.SummonPreloadPath.EquipUIR] = "m_s06_summon_anim_b03",
	[slot0.SummonPreloadPath.EquipUISR] = "m_s06_summon_anim_b02",
	[slot0.SummonPreloadPath.EquipUISSR] = "m_s06_summon_anim_b01",
	[slot0.SummonLuckyBagPreloadPath.UILuckyBag] = "m_s06_summon_anim_b01"
}
slot0.UIMaterialPath = {
	[slot0.SummonPreloadPath.UIN] = {
		"s06_ui_obj_a/s06_ui_obj_d001",
		"s06_ui_obj_a_mirror/s06_ui_obj_d001"
	},
	[slot0.SummonPreloadPath.UIR] = {
		"s06_ui_obj_a/s06_ui_obj_c001",
		"s06_ui_obj_a_mirror/s06_ui_obj_c001"
	},
	[slot0.SummonPreloadPath.UISR] = {
		"s06_ui_obj_a/s06_ui_obj_b001",
		"s06_ui_obj_a_mirror/s06_ui_obj_b001"
	},
	[slot0.SummonPreloadPath.UISSR] = {
		"s06_ui_obj_a/s06_ui_obj_a001",
		"s06_ui_obj_a_mirror/s06_ui_obj_a001"
	},
	[slot0.SummonPreloadPath.EquipUIN] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[slot0.SummonPreloadPath.EquipUIR] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[slot0.SummonPreloadPath.EquipUISR] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[slot0.SummonPreloadPath.EquipUISSR] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[slot0.SummonLuckyBagPreloadPath.UILuckyBag] = {
		"s06_ui_obj_a",
		"s06_ui_obj_a_mirror"
	}
}
slot0.BoomEquipEffectAnimationName = {
	[slot0.SummonPreloadPath.EquipBoomN] = "s03_ui_ssr_in",
	[slot0.SummonPreloadPath.EquipBoomR] = "s03_ui_ssr_in",
	[slot0.SummonPreloadPath.EquipBoomSR] = "s03_ui_ssr_in",
	[slot0.SummonPreloadPath.EquipBoomSSR] = "s03_ui_ssr_in"
}
slot0.EquipUIAnim = {
	RootGachaStartRare3 = "_white",
	RootGachaIn = "go_controller_in",
	LightGacha10 = "shiying02_x10_in",
	RootGachaStartRare4 = "_purple",
	RootGachaStartRare5 = "_golden",
	RootGachaStart1Prefix = "go_controller_summonequip_x1",
	RootGachaStart10Prefix = "go_controller_summonequip_x10",
	LightGacha1 = "shiying01_x1_in"
}
slot0.EquipFloatIconFrameNode = "s03_ui_obj_a"
slot0.EquipFloatIconFrameBeforeOpen = "scenes/dynamic/m_s03_xx/textures/m_s03_ui_obj.png"
slot0.EquipFloatIconFrameOpened = "scenes/dynamic/m_s03_xx/textures/m_s03_ui_open.png"
slot0.EquipDefaultIconPath = "singlebg/summon/equip/xray.png"
slot0.Type = {
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
slot0.ResultType = {
	Char = 1,
	Equip = 2,
	MaxCount = 2
}
slot0.SummonCallingType = {
	Summon = 1,
	SummonSimulation = 2
}
slot0.TabContentIndex = {
	CharNormal = 1,
	CharNewbie = 3,
	EquipNormal = 2,
	EquipProbUp = 5,
	CharProbUp = 4
}
slot0.Type2PageIndex = {
	slot0.TabContentIndex.CharNewbie,
	slot0.TabContentIndex.CharNormal,
	slot0.TabContentIndex.CharProbUp,
	slot0.TabContentIndex.CharProbUp,
	slot0.TabContentIndex.CharProbUp,
	slot0.TabContentIndex.CharProbUp,
	slot0.TabContentIndex.CharProbUp,
	[slot0.Type.NewPlayer] = slot0.TabContentIndex.CharProbUp,
	[slot0.Type.DoubleSsrUp] = slot0.TabContentIndex.CharProbUp,
	[10] = slot0.TabContentIndex.EquipNormal,
	[11] = slot0.TabContentIndex.EquipProbUp
}
slot0.Type2Result = {
	slot0.ResultType.Char,
	slot0.ResultType.Char,
	slot0.ResultType.Char,
	slot0.ResultType.Char,
	slot0.ResultType.Char,
	slot0.ResultType.Char,
	slot0.ResultType.Char,
	[10] = slot0.ResultType.Equip,
	[11] = slot0.ResultType.Equip
}
slot0.GuidePoolId = 2
slot0.GuideIdSet = {
	[163.0] = 1,
	[103.0] = 1
}
slot0.HistoryColor = {
	"#272525bf",
	"#272525bf",
	"#272525bf",
	"#aa7e1d",
	"#bc4d02"
}
slot0.HistoryNameStarFormat = {
	"%s",
	"%s",
	"%s",
	"%s(5    )",
	"%s(6    )"
}
slot0.DetailParagraphType = {
	SpaceOne = 1,
	Normal = 0
}
slot0.BannerFlagType = {
	Limit = 3,
	Activity = 2,
	Newbie = 1
}
slot0.TenSummonAgainOpen = false
slot0.MultiProbUp4ShowRate = 25
slot0.LuckyBagRare = 5
slot0.CustomPickRare = 5
slot0.PoolId = {
	Normal = 2,
	QuNiang = 16111
}

return slot0
