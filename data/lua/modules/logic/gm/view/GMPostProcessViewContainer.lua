module("modules.logic.gm.view.GMPostProcessViewContainer", package.seeall)

slot0 = class("GMPostProcessViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = MixScrollParam.New()
	slot2.scrollGOPath = "scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "scroll/item"
	slot2.cellClass = GMPostProcessItem
	slot2.scrollDir = ScrollEnum.ScrollDirV

	table.insert(slot1, LuaMixScrollView.New(GMPostProcessModel.instance, slot2))
	table.insert(slot1, GMPostProcessView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
