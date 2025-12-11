module("modules.logic.handbook.define.HandbookEnum", package.seeall)

local var_0_0 = _M

var_0_0.Type = {
	Character = 3,
	Story = 1,
	CG = 2,
	Equip = 4
}
var_0_0.HeroType = {
	Common = 1,
	AllHero = 99
}
var_0_0.CGType = {
	Role = 2,
	Rouge = 3,
	Dungeon = 1
}
var_0_0.BookBGRes = {
	[var_0_0.HeroType.Common] = {
		left = "peper_06",
		right = "peper_05"
	},
	[var_0_0.HeroType.AllHero] = {
		left = "img_tujian_bg_zuo",
		right = "img_tujian_bg_you"
	}
}
var_0_0.SkinScene = {
	"scenes/v2a8_m_s17_pftj/prefab/skin_sence_01.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10003.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10004.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10005.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10006.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10007.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10009.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10001.prefab",
	"scenes/v3a0_m_s17_pftj/prefab/sence_10010.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_12001.prefab"
}
var_0_0.SkinSuitSceneType = {
	Tarot = 2,
	Normal = 1
}
var_0_0.SkinSuitId2SceneType = {
	[11001] = var_0_0.SkinSuitSceneType.Tarot
}
var_0_0.SkinSuitGroupDefaultScene = "scenes/v2a8_m_s17_pftj/prefab/skin_sence_01.prefab"
var_0_0.TarotSkinDefaultCardPath = "singlebg/skinhandbook_singlebg/tarot/card00.png"
var_0_0.TarotSkinCount = 21
var_0_0.TarotSkinCardDir = "singlebg/skinhandbook_singlebg/tarot"
var_0_0.TarotDefaultFOV = 22
var_0_0.HandbookSkinShowRedDotMap = {
	[10001] = true,
	[11001] = true
}
var_0_0.Live2DSkin = {
	[302504] = {
		spineAsset = "roles_bust/v3a1_302504_skinsuit/302504_skinsuit.prefab",
		scale = "1.55",
		pos = "0,-60"
	},
	[306604] = {
		pos = "95,15",
		scale = "1",
		spineAsset = "roles_bust/v2a2_37xx_3_skinstore/37xx_3_skinstore.prefab",
		spineAsset2 = "roles_bust/v2a2_37xx_3_skinstore_pokuang/37xx_3_skinstore_pokuang.prefab"
	},
	[308603] = {
		pos = "-30,50",
		scale = "1.25",
		spineAsset = "roles_bust/v2a8_308603_lxxx_skinstore/308603_lxxx_skinstore.prefab",
		spineAsset2 = "roles_bust/v2a8_308603_lxxx_skinstore_pokuang/308603_lxxx_skinstore_pokuang.prefab"
	}
}

return var_0_0
