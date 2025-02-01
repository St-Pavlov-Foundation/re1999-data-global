module("modules.logic.room.view.RoomBlockPackageItem", package.seeall)

slot0 = class("RoomBlockPackageItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnItem:RemoveClickListener()
end

function slot0._btnitemOnClick(slot0)
	RoomHelper.hideBlockPackageReddot(slot0._packageId)
	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlockPackage, slot0._packageId)
end

function slot0.getGO(slot0)
	return slot0._go
end

function slot0.setShowIcon(slot0, slot1)
	slot0._isShowIcon = slot1
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	gohelper.setActive(slot0._goselect, slot1)
	slot0:_onSelectUI()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._showPackageMO = slot1

	slot0:setPackageId(slot1.id)
end

function slot0.getPackageId(slot0)
	return slot0._packageId
end

function slot0.setPackageId(slot0, slot1)
	slot0._packageId = slot1
	slot0._packageCfg = RoomConfig.instance:getBlockPackageConfig(slot1) or nil
	slot0._packageMO = RoomInventoryBlockModel.instance:getPackageMOById(slot1)
	slot0._blockNum = slot0._packageMO and slot0._packageMO:getUnUseCount() or 0

	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.RoomBlockPackage, slot0._packageId)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if not slot0._packageCfg then
		return
	end

	slot0._txtname.text = slot0._packageCfg.name
	slot0._txtnum.text = slot0._blockNum
	slot0._txtdegree.text = slot0._packageCfg.blockBuildDegree * slot0._blockNum

	gohelper.setActive(slot0._goempty, slot0._blockNum == 0)
	gohelper.setActive(slot0._txtnum.gameObject, slot0._blockNum > 0)
	gohelper.setActive(slot0._txtdegree.gameObject, slot0._blockNum > 0)
	slot0:_onRefreshUI()
end

function slot0.onDestroy(slot0)
end

function slot0._onInit(slot0, slot1)
end

function slot0._onRefreshUI(slot0)
end

function slot0._onSelectUI(slot0)
end

return slot0
