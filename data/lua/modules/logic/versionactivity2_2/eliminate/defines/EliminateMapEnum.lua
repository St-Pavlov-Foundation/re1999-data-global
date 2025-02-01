module("modules.logic.versionactivity2_2.eliminate.defines.EliminateMapEnum", package.seeall)

slot0 = class("EliminateMapEnum")
slot0.DefaultChapterId = 1
slot0.MapViewChapterUnlockDuration = 0.5
slot0.MapViewOpenAnimLength = 0.667
slot0.ChapterStatus = {
	notOpen = 1,
	Lock = 3,
	Normal = 0
}
slot0.SortType = {
	Resource = 3,
	Rare = 1,
	Power = 2
}
slot0.PrefsKey = {
	RoleSelected = 3,
	RoleUnlock = 1,
	ChessUnlock = 2,
	ChessSelected = 4
}
slot0.TxtNormalPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#FEE5CD")
slot0.TxtNormalUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#C5C5C5")
slot0.TxtBossPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#FFEEE4")
slot0.TxtBossUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#DEC3BC")
slot0.NormalPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#CC7620")
slot0.NormalUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#947B63")
slot0.BossPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#D34A3D")
slot0.BossUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#A37C78")

return slot0
