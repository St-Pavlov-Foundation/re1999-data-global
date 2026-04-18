-- chunkname: @modules/logic/character/defines/CharacterVoiceEnum.lua

module("modules.logic.character.defines.CharacterVoiceEnum", package.seeall)

local CharacterVoiceEnum = _M

CharacterVoiceEnum.ChangeRTSize = true
CharacterVoiceEnum.RTCameraSize = 12
CharacterVoiceEnum.RTWidth = 3000
CharacterVoiceEnum.Hero = {
	Luxi = 3086
}
CharacterVoiceEnum.LuxiState = {
	HumanFace = 2,
	MetalFace = 1
}
CharacterVoiceEnum.LuxiSkin2 = 308602
CharacterVoiceEnum.PlayType = {
	Auto = 2,
	Click = 1
}
CharacterVoiceEnum.StatusParams = {
	Luxi_NoChangeStatus = "noChangeStatus"
}
CharacterVoiceEnum.WaitVoiceParamsType = {
	MultiGroup = 1,
	VoiceWithWeightGroup = 2
}
CharacterVoiceEnum.WaitVoiceParamsCls = {
	[CharacterVoiceEnum.WaitVoiceParamsType.MultiGroup] = "MultiGroupWaitVoiceParams",
	[CharacterVoiceEnum.WaitVoiceParamsType.VoiceWithWeightGroup] = "VoiceWithWeightGroupParams"
}
CharacterVoiceEnum.SkinInteraction = {
	[311003] = "LiangYueSkinInteraction",
	[314102] = "LuSiJianSkinInteraction",
	[313402] = "BleSkinInteraction"
}
CharacterVoiceEnum.RankUpResultShowMask = {
	[3120] = true
}
CharacterVoiceEnum.UIBloomView = {
	CharacterDataView = "view_CharacterDataView"
}
CharacterVoiceEnum.NormalBloomViewType = {
	Capture = 2,
	CustomOpen = 3,
	Normal = 1
}
CharacterVoiceEnum.NormalBloomView = {
	WeekWalk_2HeartResultView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	RoleStoryFightSuccView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	RougeFightSuccessView = CharacterVoiceEnum.NormalBloomViewType.Capture,
	Rouge2_FightSuccessView = CharacterVoiceEnum.NormalBloomViewType.Capture,
	CharacterGetView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterRankUpResultView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterRankUpView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterSkinGainView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterSkinView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	CharacterRecommedView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	StoreSkinDefaultShowView = CharacterVoiceEnum.NormalBloomViewType.Normal,
	StoreView = CharacterVoiceEnum.NormalBloomViewType.CustomOpen,
	FightSuccView = CharacterVoiceEnum.NormalBloomViewType.Capture
}
CharacterVoiceEnum.RTShareType = {
	BloomClose = 2,
	BloomOpen = 3,
	BloomAuto = 100,
	FullScreen = 4,
	Normal = 1
}
CharacterVoiceEnum.BloomCameraSize = {
	[3116] = 10,
	[3108] = 10,
	[3122] = 10,
	[3107] = 10,
	[3134] = 10,
	[3070] = 10,
	[3047] = 10,
	[3128] = 10,
	[3120] = 10
}
CharacterVoiceEnum.NormalTypeCameraSize = 10
CharacterVoiceEnum.BloomTypeCameraSize = 10
CharacterVoiceEnum.NormalFullScreenEffectCameraSize = 13
CharacterVoiceEnum.BloomFullScreenEffectCameraSize = 13
CharacterVoiceEnum.DelayFrame = 5

return CharacterVoiceEnum
