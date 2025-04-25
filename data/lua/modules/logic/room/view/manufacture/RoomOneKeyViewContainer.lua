module("modules.logic.room.view.manufacture.RoomOneKeyViewContainer", package.seeall)

slot0 = class("RoomOneKeyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = MixScrollParam.New()
	slot2.scrollGOPath = "right/#go_addPop/#scroll_production"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "right/#go_addPop/#scroll_production/viewport/content/#go_productionItem"
	slot2.cellClass = RoomOneKeyAddPopItem
	slot2.scrollDir = ScrollEnum.ScrollDirV

	table.insert(slot1, LuaMixScrollView.New(OneKeyAddPopListModel.instance, slot2))

	slot0.roomOneKeyAddPopView = RoomOneKeyAddPopView.New()

	table.insert(slot1, slot0.roomOneKeyAddPopView)

	slot0.oneKeyView = RoomOneKeyView.New()

	table.insert(slot1, slot0.oneKeyView)

	return slot1
end

function slot0.playOpenTransition(slot0)
	slot1 = "open"

	if ManufactureModel.instance:getRecordOneKeyType() == RoomManufactureEnum.OneKeyType.Customize then
		slot1 = "open2"
	end

	uv0.super.playOpenTransition(slot0, {
		anim = slot1
	})
end

function slot0.oneKeyViewSetAddPopActive(slot0, slot1)
	slot0.oneKeyView:setAddPopActive(slot1)
end

return slot0
