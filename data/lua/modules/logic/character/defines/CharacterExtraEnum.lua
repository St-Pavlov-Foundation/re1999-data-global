module("modules.logic.character.defines.CharacterExtraEnum", package.seeall)

local var_0_0 = _M

var_0_0.TalentSkillSubCount = 3
var_0_0.TalentSkillTreeNodeCount = 3
var_0_0.UnlockTalentPointCountConst = 52
var_0_0.SkillTreeNodeStatus = {
	Light = 3,
	Lock = 2,
	Normal = 1
}
var_0_0.SkillTreeAnimName = {
	Click = "click",
	OpenTip = "open",
	Lock = "lock",
	OpenNomal = "open_nomal",
	OpenBottom = "open_bottom",
	CloseTip = "close",
	Bottom = "bottom",
	Normal = "normal"
}
var_0_0.EffectCellHeight = 136
var_0_0.EffectCellSpace = 26
var_0_0.WeaponType = {
	Second = 2,
	First = 1
}
var_0_0.WeaponStatus = {
	Equip = 3,
	Lock = 2,
	Normal = 1
}
var_0_0.WeaponParams = {
	[var_0_0.WeaponType.First] = {
		RankupShow = "character_rankup_system_2",
		UnlockConst = 53
	},
	[var_0_0.WeaponType.Second] = {
		RankupShow = "character_rankup_system_3",
		UnlockConst = 54
	}
}
var_0_0.WeaponTypeReddot = "CharacterExtraEnum_WeaponTypeReddot"
var_0_0.WeaponReddot = "CharacterExtraEnum_WeaponReddot"
var_0_0.WeaponAnimName = {
	Switch = "switch",
	Idle = "idle",
	Unlock = "unlock"
}

return var_0_0
