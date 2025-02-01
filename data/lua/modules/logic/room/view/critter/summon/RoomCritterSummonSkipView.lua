module("modules.logic.room.view.critter.summon.RoomCritterSummonSkipView", package.seeall)

slot0 = class("RoomCritterSummonSkipView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")
	slot0._imageskip = gohelper.findChildImage(slot0.viewGO, "#btn_skip/#image_skip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onDragEnd, slot0.onDragEnd, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onOpenEgg, slot0._closeSkip, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnskip:RemoveClickListener()
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onDragEnd, slot0.onDragEnd, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onOpenEgg, slot0._closeSkip, slot0)
end

function slot0._btnskipOnClick(slot0)
	slot0:_closeSkip()
	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onSummonSkip)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onDragEnd(slot0)
end

function slot0._closeSkip(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._btnskip.gameObject, true)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
