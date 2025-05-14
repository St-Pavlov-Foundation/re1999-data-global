module("modules.logic.versionactivity2_2.eliminate.defines.EliminateMapEnum", package.seeall)

local var_0_0 = class("EliminateMapEnum")

var_0_0.DefaultChapterId = 1
var_0_0.MapViewChapterUnlockDuration = 0.5
var_0_0.MapViewOpenAnimLength = 0.667
var_0_0.ChapterStatus = {
	notOpen = 1,
	Lock = 3,
	Normal = 0
}
var_0_0.SortType = {
	Resource = 3,
	Rare = 1,
	Power = 2
}
var_0_0.PrefsKey = {
	RoleSelected = 3,
	RoleUnlock = 1,
	ChessUnlock = 2,
	ChessSelected = 4
}
var_0_0.TxtNormalPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#FEE5CD")
var_0_0.TxtNormalUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#C5C5C5")
var_0_0.TxtBossPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#FFEEE4")
var_0_0.TxtBossUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#DEC3BC")
var_0_0.NormalPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#CC7620")
var_0_0.NormalUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#947B63")
var_0_0.BossPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#D34A3D")
var_0_0.BossUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#A37C78")

return var_0_0
