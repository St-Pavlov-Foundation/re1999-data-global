module("modules.logic.room.view.critter.summon.RoomCritterSummonDragView", package.seeall)

slot0 = class("RoomCritterSummonDragView", BaseView)

function slot0.onInitView(slot0)
	slot0._goresult = gohelper.findChild(slot0.viewGO, "#go_result")
	slot0._goresultitem = gohelper.findChild(slot0.viewGO, "#go_result/resultcontent/#go_resultitem")
	slot0._btnreturn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#btn_return")
	slot0._btnopenall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#btn_openall")
	slot0._godrag = gohelper.findChild(slot0.viewGO, "#go_drag")
	slot0._goguide = gohelper.findChild(slot0.viewGO, "#go_drag/#go_guide")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, slot0._onSummonSkip, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCanDrag, slot0._onCanDrag, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onEndSummon, slot0._onSummonDragEnd, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, slot0._onSummonSkip, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCanDrag, slot0._onCanDrag, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onEndSummon, slot0._onSummonDragEnd, slot0)
end

function slot0._editableInitView(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godrag)

	slot0._drag:AddDragListener(slot0.onDrag, slot0)
	slot0._drag:AddDragBeginListener(slot0.onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0.onDragEnd, slot0)
	gohelper.setActive(slot0._goresultitem, false)
	gohelper.setActive(slot0._goresult, false)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._godrag.gameObject, false)

	slot0._lastDragAngle = nil
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showGuide, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
end

function slot0._runDelayShowGuide(slot0)
	gohelper.setActive(slot0._goguide, false)
	TaskDispatcher.runDelay(slot0._showGuide, slot0, 0.3)
end

function slot0._showGuide(slot0)
	TaskDispatcher.cancelTask(slot0._showGuide, slot0)
	gohelper.setActive(slot0._goguide, true)
end

function slot0._hideGuide(slot0)
	TaskDispatcher.cancelTask(slot0._showGuide, slot0)
	gohelper.setActive(slot0._goguide, false)
end

function slot0.onDragBegin(slot0, slot1, slot2)
	if slot0._startPlayAnim then
		return
	end

	slot0._lastDragAngle = slot2.position

	slot0:_hideGuide()
end

slot1 = 1

function slot0.onDragEnd(slot0, slot1, slot2)
	if not slot0._lastDragAngle or slot0._startPlayAnim then
		return
	end

	if uv0 < slot0._lastDragAngle.y - slot2.position.y and slot0.viewParam and slot0.viewParam.critterMo and slot0.viewParam.critterMo:getDefineCfg() then
		slot0._startPlayAnim = true

		CritterSummonController.instance:onSummonDragEnd(slot0.viewParam.mode, slot4.rare)
		slot0:_hideGuide()
		gohelper.setActive(slot0._godrag.gameObject, false)

		slot0._audioId = AudioMgr.instance:trigger(RoomSummonEnum.SummonMode[slot0.viewParam.mode].AudioId)

		return
	end

	slot0:_runDelayShowGuide()
end

function slot0.onDrag(slot0, slot1, slot2)
end

function slot0._onSummonSkip(slot0)
	slot0:openSummonGetCritterView(slot0.viewParam, true)

	if slot0._audioId then
		AudioMgr.instance:stopPlayingID(slot0._audioId)
	end
end

function slot0._onCanDrag(slot0)
	gohelper.setActive(slot0._godrag.gameObject, true)
	slot0:_runDelayShowGuide()
end

function slot0._onSummonDragEnd(slot0)
	slot0:openSummonGetCritterView(slot0.viewParam, false)
end

function slot0.openSummonGetCritterView(slot0, slot1, slot2)
	if slot1.mode == RoomSummonEnum.SummonType.Summon and slot1.critterMOList and #slot1.critterMOList > 1 then
		ViewMgr.instance:openView(ViewName.RoomCritterSummonResultView, slot1)
		ViewMgr.instance:closeView(ViewName.RoomCritterSummonSkipView)
	else
		CritterSummonController.instance:openSummonGetCritterView(slot1, slot2)
	end
end

return slot0
