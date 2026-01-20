-- chunkname: @modules/logic/character/defines/CharacterVoiceEnum.lua

module("modules.logic.character.defines.CharacterVoiceEnum", package.seeall)

local CharacterVoiceEnum = _M

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
CharacterVoiceEnum.SkinInteraction = {
	[313402] = "BleSkinInteraction"
}
CharacterVoiceEnum.RankUpResultShowMask = {
	[3120] = true
}
CharacterVoiceEnum.UIBloomView = {
	CharacterDataView = "view_CharacterDataView"
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
	[3107] = 10,
	[3108] = 10,
	[3122] = 10,
	[3134] = 10,
	[3070] = 10,
	[3128] = 10,
	[3120] = 10
}
CharacterVoiceEnum.NormalTypeCameraSize = 13
CharacterVoiceEnum.NormalFullScreenEffectCameraSize = 13
CharacterVoiceEnum.BloomFullScreenEffectCameraSize = 13
CharacterVoiceEnum.DelayFrame = 5

return CharacterVoiceEnum
