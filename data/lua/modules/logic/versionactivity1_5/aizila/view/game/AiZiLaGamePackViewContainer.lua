module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGamePackViewContainer", package.seeall)

slot0 = class("AiZiLaGamePackViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_Items"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = AiZiLaGoodsItem.prefabPath
	slot2.cellClass = AiZiLaGoodsItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 5
	slot2.cellWidth = 270
	slot2.cellHeight = 250
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(AiZiLaGamePackListModel.instance, slot2))
	table.insert(slot1, AiZiLaGamePackView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return slot0
