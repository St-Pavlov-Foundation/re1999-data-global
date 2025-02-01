module("modules.logic.fight.view.FightFocusCameraAdjustView", package.seeall)

slot0 = class("FightFocusCameraAdjustView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnblock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_block")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._gooffset = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_offset")
	slot0._gooffset1 = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_offset/offsets/#go_offset1")
	slot0._gooffset2 = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_offset/offsets/#go_offset2")
	slot0._gooffset3 = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_offset/offsets/#go_offset3")
	slot0._btnsaveOffset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/component/#go_offset/#btn_saveOffset")
	slot0._btnresetOffset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/component/#go_offset/#btn_resetOffset")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/component/#go_offset/#btn_close")
	slot0._txtskinId = gohelper.findChildText(slot0.viewGO, "#go_container/component/label/#txt_skinId")
	slot0._txtoffset = gohelper.findChildText(slot0.viewGO, "#go_container/component/label/#txt_offset")
	slot0._gomiddlecontainer = gohelper.findChild(slot0.viewGO, "#go_middlecontainer")
	slot0._gomiddle = gohelper.findChild(slot0.viewGO, "#go_middlecontainer/#go_middle")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnblock:AddClickListener(slot0._btnblockOnClick, slot0)
	slot0._btnsaveOffset:AddClickListener(slot0._btnsaveOffsetOnClick, slot0)
	slot0._btnresetOffset:AddClickListener(slot0._btnresetOffsetOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnblock:RemoveClickListener()
	slot0._btnsaveOffset:RemoveClickListener()
	slot0._btnresetOffset:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

slot0.SliderMaxValue = 50
slot0.SliderMinValue = -50
slot0.OffsetKey = {
	Z = "z",
	X = "x",
	Y = "y"
}

function slot0._btnblockOnClick(slot0)
end

function slot0._btnsaveOffsetOnClick(slot0)
end

function slot0._btnresetOffsetOnClick(slot0)
	for slot4, slot5 in pairs(slot0.sliderDict) do
		slot5.slider:SetValue(0)
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._onSliderValueChanged(slot0)
	if not slot0.initDone then
		return
	end

	slot1 = slot0.sliderDict[uv0.OffsetKey.X].slider:GetValue()
	slot2 = slot0.sliderDict[uv0.OffsetKey.Y].slider:GetValue()
	slot3 = slot0.sliderDict[uv0.OffsetKey.Z].slider:GetValue()
	slot0.sliderDict[uv0.OffsetKey.X].text.text = slot1
	slot0.sliderDict[uv0.OffsetKey.Y].text.text = slot2
	slot0.sliderDict[uv0.OffsetKey.Z].text.text = slot3

	FightWorkFocusMonster.changeCameraPosition(slot1, slot2, slot3, slot0.updateEntityMiddlePosition, slot0)
	slot0:refreshOffsetLabel(slot1, slot2, slot3)
end

function slot0.addBtnClick(slot0, slot1)
	slot1.slider:SetValue(slot1.slider:GetValue() + tonumber(slot1.intervalField:GetText()))
end

function slot0.reduceBtnClick(slot0, slot1)
	slot1.slider:SetValue(slot1.slider:GetValue() - tonumber(slot1.intervalField:GetText()))
end

function slot0._initSlider(slot0, slot1, slot2)
	slot3 = gohelper.findChildSlider(slot1, "slider_offset")
	slot3.slider.maxValue = uv0.SliderMaxValue
	slot3.slider.minValue = uv0.SliderMinValue

	slot3:AddOnValueChanged(slot0._onSliderValueChanged, slot0)
	slot3:SetValue(0)

	slot4 = gohelper.findChildText(slot1, "txt_offset")
	slot5 = gohelper.findChildButtonWithAudio(slot1, "AddBtn")
	slot6 = gohelper.findChildButtonWithAudio(slot1, "ReduceBtn")
	slot7 = gohelper.findChildTextMeshInputField(slot1, "IntervalField")
	slot8 = slot0:getUserDataTb_()
	slot8.slider = slot3
	slot8.text = slot4
	slot8.addBtn = slot5
	slot8.reduceBtn = slot6
	slot8.intervalField = slot7

	slot5:AddClickListener(slot0.addBtnClick, slot0, slot8)
	slot6:AddClickListener(slot0.reduceBtnClick, slot0, slot8)
	slot7:SetText(1)

	slot4.text = 0
	slot0.sliderDict[slot2] = slot8
end

function slot0._editableInitView(slot0)
	slot0.initDone = false
	slot0.sliderDict = slot0:getUserDataTb_()

	slot0:_initSlider(slot0._gooffset1, uv0.OffsetKey.X)
	slot0:_initSlider(slot0._gooffset2, uv0.OffsetKey.Y)
	slot0:_initSlider(slot0._gooffset3, uv0.OffsetKey.Z)

	slot0.unitCamera = CameraMgr.instance:getUnitCamera()
	slot0.initDone = true
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:initEntity()

	slot0._txtskinId.text = "皮肤ID : " .. slot0:getFocusSkinId()

	slot0:refreshOffsetLabel(0, 0, 0)
	FightWorkFocusMonster.changeCameraPosition(0, 0, 0, slot0.updateEntityMiddlePosition, slot0)
end

function slot0.getFocusSkinId(slot0)
	return slot0.entity and slot0.entity:getMO().skin or ""
end

function slot0.initEntity(slot0)
	if not ViewMgr.instance:getContainer(ViewName.FightSkillSelectView) then
		slot0.entity = nil

		return
	end

	if not slot1._views[1]:getCurrentFocusEntityId() then
		slot0.entity = nil

		return
	end

	if not FightHelper.getEntity(slot2) then
		slot0.entity = nil

		return
	end

	slot0.entity = slot3
	slot0.mountMiddleGo = slot0.entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
end

function slot0.refreshOffsetLabel(slot0, slot1, slot2, slot3)
	slot0._txtoffset.text = string.format("X : <color=red>%.4f</color>;    Y : <color=red>%.4f</color>;    Z : <color=red>%.4f</color>", slot1, slot2, slot3)
end

function slot0.updateEntityMiddlePosition(slot0)
	if not slot0.mountMiddleGo then
		return
	end

	slot1 = recthelper.worldPosToAnchorPos(slot0.mountMiddleGo.transform.position, slot0._gomiddlecontainer.transform, nil, slot0.unitCamera)

	recthelper.setAnchor(slot0._gomiddle.transform, slot1.x, slot1.y)
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0.sliderDict) do
		slot5.slider:RemoveOnValueChanged()
		slot5.addBtn:RemoveClickListener()
		slot5.reduceBtn:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
