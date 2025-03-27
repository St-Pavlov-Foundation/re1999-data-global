module("modules.logic.rouge.common.comp.RougeCollectionComp", package.seeall)

slot0 = class("RougeCollectionComp", RougeLuaCompBase)

function slot0.Get(slot0)
	slot1 = uv0.New()

	slot1:init(slot0)

	return slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()
	uv0.super.init(slot0, slot1)

	slot0.go = slot1
	slot0._gostate1 = gohelper.findChild(slot0.go, "Root/#go_state1")
	slot0._gostate2 = gohelper.findChild(slot0.go, "Root/#go_state2")
	slot0._goicon = gohelper.findChild(slot0.go, "Root/#go_state1/#go_icon")
	slot0._gostate2Normal = gohelper.findChild(slot0.go, "Root/#go_state2/#go_Normal")
	slot0._gostate2Light = gohelper.findChild(slot0.go, "Root/#go_state2/#go_Light")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "Root/#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)

	slot0._animator = gohelper.onceAddComponent(slot0.go, gohelper.Type_Animator)
	slot0._slotComp = RougeCollectionSlotComp.Get(slot0._goicon, RougeCollectionHelper.BagEntrySlotParam)

	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, slot0.placeCollection2SlotArea, slot0)
end

function slot0._btnclickOnClick(slot0)
	RougeController.instance:openRougeCollectionChessView()
end

function slot0.onOpen(slot0, slot1)
	slot3 = RougeCollectionModel.instance:getCurSlotAreaSize()

	slot0._slotComp:onUpdateMO(slot3.col, slot3.row, RougeCollectionModel.instance:getSlotAreaCollection())
	slot0:switchEntryState(slot1)
	slot0:tickUpdateDLCs()
end

function slot0.onClose(slot0)
end

function slot0.switchEntryState(slot0, slot1)
	if slot0._curState == (slot1 or RougeEnum.CollectionEntryState.Grid) then
		return
	end

	slot0._curState = slot1

	if slot1 == RougeEnum.CollectionEntryState.Icon then
		slot0:onSwitch2IconState()
	elseif slot1 == RougeEnum.CollectionEntryState.Grid then
		slot0:onSwitch2GridState()
	end
end

function slot0.onSwitch2IconState(slot0)
	slot0:setState2IconLight(false)
	slot0._animator:Play("swicth_state2", 0, 0)
end

function slot0.onSwitch2GridState(slot0)
	slot0._animator:Play("swicth_state1", 0, 0)
end

function slot0.setState2IconLight(slot0, slot1)
	gohelper.setActive(slot0._gostate2Normal, not slot1)
	gohelper.setActive(slot0._gostate2Light, slot1)
end

function slot0.placeCollection2SlotArea(slot0, slot1, slot2)
	if slot1 and RougeCollectionHelper.isNewGetCollection(slot2) and slot0._curState == RougeEnum.CollectionEntryState.Icon then
		slot0:setState2IconLight(true)
	end
end

function slot0.destroy(slot0)
	slot0._btnclick:RemoveClickListener()

	if slot0._slotComp then
		slot0._slotComp:destroy()
	end

	slot0:__onDispose()
end

return slot0
