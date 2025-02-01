module("modules.logic.room.view.RoomInformPlayerViewContainer", package.seeall)

slot0 = class("RoomInformPlayerViewContainer", BaseViewContainer)
slot1 = {
	[LangSettings.zh] = {
		cellSpaceH = 37,
		cellWidth = 280,
		lineCount = 4
	},
	[LangSettings.jp] = {
		cellSpaceH = 37,
		cellWidth = 390,
		lineCount = 3
	},
	[LangSettings.en] = {
		cellSpaceH = 60,
		cellWidth = 380,
		lineCount = 3
	}
}

function slot0.buildViews(slot0)
	slot1 = uv0[GameConfig:GetCurLangType()] or uv0[LangSettings.zh]
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "object/scroll_inform"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "object/scroll_inform/Viewport/#go_informContent/#go_informItem"
	slot2.cellClass = RoomInformReportTypeItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = slot1.lineCount
	slot2.cellWidth = slot1.cellWidth
	slot2.cellHeight = 40
	slot2.cellSpaceH = slot1.cellSpaceH
	slot2.cellSpaceV = 33
	slot2.startSpace = 0

	return {
		CommonViewFrame.New(),
		RoomInformPlayerView.New(),
		LuaListScrollView.New(RoomReportTypeListModel.instance, slot2)
	}
end

function slot0.buildTabViews(slot0, slot1)
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
