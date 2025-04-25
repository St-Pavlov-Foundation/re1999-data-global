module("modules.logic.room.view.critter.summon.RoomCritterSummonResultView", package.seeall)

slot0 = class("RoomCritterSummonResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtclose = gohelper.findChildText(slot0.viewGO, "#btn_close/#txt_close")
	slot0._goposcontent = gohelper.findChild(slot0.viewGO, "#go_pos_content")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_item")
	slot0._goegg = gohelper.findChild(slot0.viewGO, "#go_item/#go_egg")
	slot0._gocritter = gohelper.findChild(slot0.viewGO, "#go_item/#go_critter")
	slot0._imagequality = gohelper.findChildImage(slot0.viewGO, "#go_item/#go_critter/#image_quality")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_item/#go_critter/#simage_icon")
	slot0._btnopenEgg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_item/#btn_openEgg")
	slot0._btnopenall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_openall")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")
	slot0._imageskip = gohelper.findChildImage(slot0.viewGO, "#btn_skip/#image_skip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnopenEgg:AddClickListener(slot0._btnopenEggOnClick, slot0)
	slot0._btnopenall:AddClickListener(slot0._btnopenallOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnopenEgg:RemoveClickListener()
	slot0._btnopenall:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
end

function slot0._btnskipOnClick(slot0)
	slot0:_setAllOpen(true)
	slot0:_refreshUI()
end

function slot0._btnopenallOnClick(slot0)
	if slot0:_findNotOpenMOList() and #slot1 > 0 then
		CritterSummonController.instance:openSummonGetCritterView({
			mode = RoomSummonEnum.SummonType.Summon,
			critterMo = slot1[1],
			critterMOList = slot1
		}, true)
		slot0:_setAllOpen()
	end
end

function slot0._btncloseOnClick(slot0)
	if slot0:isAllOpen() then
		slot0:closeThis()
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewRefreshCamera)
		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onCloseGetCritter)
	end
end

function slot0._btnopenEggOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0._itemCompList = {}

	for slot4 = 1, 10 do
		slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._goitem, gohelper.findChild(slot0._goposcontent, "go_pos" .. slot4)), RoomCritterSummonResultItem)
		slot7._view = slot0
		slot0._itemCompList[slot4] = slot7
	end

	gohelper.setActive(slot0._goitem)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_obtain)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onOpenCloseView, slot0)

	slot1 = {}

	if slot0.viewParam and slot0.viewParam.critterMOList then
		tabletool.addValues(slot1, slot0.viewParam.critterMOList)
	end

	slot0._critterMOList = slot1

	slot0:_refreshCritterUI()
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0._onOpenCloseView(slot0)
	if slot0._lastIsOpen ~= ViewMgr.instance:isOpen(ViewName.RoomGetCritterView) then
		slot0._lastIsOpen = slot1

		slot0:_refreshUI()

		if not slot1 then
			slot2 = false

			for slot6 = 1, #slot0._itemCompList do
				if slot0._itemCompList[slot6].critterMO and slot7:playAnim(slot7:isOpenEgg()) then
					slot2 = true
				end
			end

			if slot2 then
				AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_shilian1)
			end
		end
	end
end

function slot0._refreshUI(slot0)
	slot1 = slot0:isAllOpen()

	gohelper.setActive(slot0._txtclose, slot1)
	gohelper.setActive(slot0._btnopenall, not slot1)
	gohelper.setActive(slot0._btnskip, not slot1)
end

function slot0._refreshCritterUI(slot0)
	for slot4 = 1, #slot0._itemCompList do
		slot0._itemCompList[slot4]:onUpdateMO(slot0._critterMOList[slot4])
	end
end

function slot0.isAllOpen(slot0)
	for slot4 = 1, #slot0._itemCompList do
		if not slot0._itemCompList[slot4]:isOpenEgg() and slot0._critterMOList[slot4] then
			return false
		end
	end

	return true
end

function slot0._findNotOpenMOList(slot0, slot1)
	slot2 = nil

	for slot6 = 1, #slot0._itemCompList do
		if not slot0._itemCompList[slot6]:isOpenEgg() and slot0._critterMOList[slot6] then
			table.insert(slot2 or {}, slot0._critterMOList[slot6])
		end
	end

	return slot2
end

function slot0._setAllOpen(slot0, slot1)
	slot2 = false

	for slot6 = 1, #slot0._itemCompList do
		if slot0._critterMOList[slot6] then
			slot0._itemCompList[slot6]:setOpenEgg(true)

			if slot1 and slot7:playAnim(true) then
				slot2 = true
			end
		end
	end

	if slot2 then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_shilian1)
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._itemCompList) do
		slot5:onDestroy()
	end
end

return slot0
