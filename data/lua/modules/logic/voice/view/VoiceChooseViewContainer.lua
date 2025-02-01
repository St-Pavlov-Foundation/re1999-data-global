module("modules.logic.voice.view.VoiceChooseViewContainer", package.seeall)

slot0 = class("VoiceChooseViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "view/#scroll_content"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = VoiceChooseItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1400
	slot1.cellHeight = 124
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 10
	slot1.startSpace = 0
	slot2 = {}

	table.insert(slot2, LuaListScrollView.New(VoiceChooseModel.instance, slot1))
	table.insert(slot2, VoiceChooseView.New())

	return slot2
end

return slot0
