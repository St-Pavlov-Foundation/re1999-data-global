module("modules.logic.room.view.common.RoomSourcesCobrandLogoItem", package.seeall)

slot0 = class("RoomSourcesCobrandLogoItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagelogoicon = gohelper.findChildImage(slot0.viewGO, "logo/#image_logoicon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0.setSourcesTypeStr(slot0, slot1)
	slot0._sourcesTypeCfg = slot0:_findSourcesTypeCfg(slot1)
	slot0._isShow = false

	if slot0._sourcesTypeCfg then
		slot0._isShow = true

		UISpriteSetMgr.instance:setRoomSprite(slot0._imagelogoicon, slot0._sourcesTypeCfg.bgIcon)
	end

	gohelper.setActive(slot0.viewGO, slot0._isShow)
end

function slot0.getIsShow(slot0)
	return slot0._isShow
end

function slot0._findSourcesTypeCfg(slot0, slot1)
	if not slot1 or string.nilorempty(slot1) then
		return nil
	end

	if string.splitToNumber(slot1, "#") == nil or #slot2 < 1 then
		return nil
	end

	slot3 = nil

	for slot8, slot9 in ipairs(slot2) do
		if RoomConfig.instance:getSourcesTypeConfig(slot9) and slot10.showType == RoomEnum.SourcesShowType.Cobrand then
			slot3 = slot10

			break
		end
	end

	return slot3
end

return slot0
