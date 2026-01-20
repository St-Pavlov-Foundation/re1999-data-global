-- chunkname: @modules/logic/handbook/define/HandbookEnum.lua

module("modules.logic.handbook.define.HandbookEnum", package.seeall)

local HandbookEnum = _M

HandbookEnum.Type = {
	Character = 3,
	Story = 1,
	CG = 2,
	Equip = 4
}
HandbookEnum.HeroType = {
	Common = 1,
	AllHero = 99
}
HandbookEnum.CGType = {
	Role = 2,
	Rouge = 3,
	Dungeon = 1
}
HandbookEnum.BookBGRes = {
	[HandbookEnum.HeroType.Common] = {
		left = "peper_06",
		right = "peper_05"
	},
	[HandbookEnum.HeroType.AllHero] = {
		left = "img_tujian_bg_zuo",
		right = "img_tujian_bg_you"
	}
}
HandbookEnum.SkinSceneAsset = {
	"ui/animations/dynamic/skinbook_camerar.controller",
	"scenes/v2a8_m_s17_pftj/prefab/skin_sence_01.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10003.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10004.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10005.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10006.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10007.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10009.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10001.prefab",
	"scenes/v3a0_m_s17_pftj/prefab/sence_10010.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_12001.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10008.prefab"
}
HandbookEnum.SkinSuitSceneType = {
	Tarot = 2,
	Normal = 1
}
HandbookEnum.SkinSuitId2SceneType = {
	[11001] = HandbookEnum.SkinSuitSceneType.Tarot
}
HandbookEnum.SkinSuitGroupDefaultScene = "scenes/v2a8_m_s17_pftj/prefab/skin_sence_01.prefab"
HandbookEnum.TarotSkinDefaultCardPath = "singlebg/skinhandbook_singlebg/tarot/card00.png"
HandbookEnum.TarotSkinCount = 21
HandbookEnum.TarotSkinCardDir = "singlebg/skinhandbook_singlebg/tarot"
HandbookEnum.TarotDefaultFOV = 22
HandbookEnum.HandbookSkinShowRedDotMap = {
	[10001] = true,
	[11001] = true
}
HandbookEnum.Live2DSkin = {
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

return HandbookEnum
