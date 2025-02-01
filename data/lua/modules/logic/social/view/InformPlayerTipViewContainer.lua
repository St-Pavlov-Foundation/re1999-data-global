module("modules.logic.social.view.InformPlayerTipViewContainer", package.seeall)

slot0 = class("InformPlayerTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "scroll_inform"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "scroll_inform/Viewport/#go_informContent/#go_informItem"
	slot1.cellClass = ReportTypeItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 4
	slot1.cellWidth = 280
	slot1.cellHeight = 40
	slot1.cellSpaceH = 37
	slot1.cellSpaceV = 33
	slot1.startSpace = 0

	return {
		InformPlayerTipView.New(),
		LuaListScrollView.New(ReportTypeListModel.instance, slot1)
	}
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
