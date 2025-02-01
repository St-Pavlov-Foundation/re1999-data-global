module("modules.logic.versionactivity1_5.aizila.view.AiZiLaHandbookViewContainer", package.seeall)

slot0 = class("AiZiLaHandbookViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "Right/#scroll_Items"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = AiZiLaGoodsItem.prefabPath
	slot2.cellClass = AiZiLaHandbookItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 4
	slot2.cellWidth = 286
	slot2.cellHeight = 236
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(AiZiLaHandbookListModel.instance, slot2))
	table.insert(slot1, AiZiLaHandbookView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return slot0
