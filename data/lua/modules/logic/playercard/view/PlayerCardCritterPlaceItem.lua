module("modules.logic.playercard.view.PlayerCardCritterPlaceItem", package.seeall)

slot0 = class("PlayerCardCritterPlaceItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_icon")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#go_click")
	slot0._uiclick = gohelper.getClickWithDefaultAudio(slot0._goclick)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._uiclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._uiclick:AddClickDownListener(slot0._btnclickOnClickDown, slot0)
end

function slot0.removeEvents(slot0)
	slot0._uiclick:RemoveClickListener()
	slot0._uiclick:RemoveClickDownListener()
end

function slot0._btnclickOnClick(slot0)
	slot1, slot2 = slot0:getCritterId()
	slot0.filterMO = CritterFilterModel.instance:generateFilterMO(ViewName.PlayerCardCritterPlaceView)

	PlayerCardModel.instance:setSelectCritterUid(slot1)
	PlayerCardRpc.instance:sendSetPlayerCardCritterRequest(slot1)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:setCritter()
end

function slot0.setCritter(slot0)
	slot1, slot2 = slot0:getCritterId()

	if not slot0.critterIcon then
		slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._goicon)

		slot0.critterIcon:setSelectUIVisible(true)
	end

	slot0.critterIcon:setMOValue(slot1, slot2)
	slot0.critterIcon:showSpeical()
	slot0.critterIcon:setMaturityIconShow(true)
	slot0:_refreshSelect()
end

function slot0._refreshSelect(slot0)
	slot1, slot2 = slot0:getCritterId()
	slot0._isSelect = tonumber(slot1) == PlayerCardModel.instance:getSelectCritterUid()

	slot0.critterIcon:onSelect(slot0._isSelect)
end

function slot0.getCritterId(slot0)
	slot1, slot2 = nil

	if slot0._mo then
		slot1 = slot0._mo:getId()
		slot2 = slot0._mo:getDefineId()
	end

	return slot1, slot2
end

function slot0.onDestroy(slot0)
end

return slot0
