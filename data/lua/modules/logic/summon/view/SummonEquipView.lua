module("modules.logic.summon.view.SummonEquipView", package.seeall)

slot0 = class("SummonEquipView", BaseView)

function slot0.onInitView(slot0)
	slot0._goresult = gohelper.findChild(slot0.viewGO, "#go_result")
	slot0._goresultitem = gohelper.findChild(slot0.viewGO, "#go_result/resultcontent/#go_resultitem")
	slot0._btnopenall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#btn_openall")
	slot0._btnreturn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#btn_return")
	slot0._godrag = gohelper.findChild(slot0.viewGO, "#go_drag")
	slot0._gocontroller = gohelper.findChild(slot0.viewGO, "#go_controller")
	slot0._goguide = gohelper.findChild(slot0.viewGO, "#go_drag/#go_guide")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreturn:AddClickListener(slot0._btnreturnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreturn:RemoveClickListener()
end

function slot0._btnreturnOnClick(slot0)
	slot0:_summonEnd()
end

function slot0._editableInitView(slot0)
	slot0:checkInitDrawComp()

	slot0._animMonitor = slot0._gocontroller:GetComponent(typeof(UnityEngine.Animation))
	slot0._animLight = gohelper.findChild(slot0._gocontroller, "shiying"):GetComponent(typeof(UnityEngine.Animation))
	slot1 = nil
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godrag)

	slot0._drag:AddDragListener(slot0.onDrag, slot0)
	slot0._drag:AddDragBeginListener(slot0.onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0.onDragEnd, slot0)
end

function slot0.handleSkip(slot0)
	if not slot0._isDrawing then
		return
	end

	slot0:_hideGuide()

	if slot0:checkInitDrawComp() then
		slot0._drawComp:skip()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	SummonController.instance:playSkipAnimation(false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.startDraw, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimEnterDraw, slot0.handleAnimStartDraw, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonDraw, slot0.onDragComplete, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, slot0.onSummonAnimEnd, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonResultClose, slot0._summonEnd, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonSkip, slot0.handleSkip, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.handleCloseView, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.startDraw, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimEnterDraw, slot0.handleAnimStartDraw, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonDraw, slot0.onDragComplete, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, slot0.onSummonAnimEnd, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonResultClose, slot0._summonEnd, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonSkip, slot0.handleSkip, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.handleCloseView, slot0)
end

function slot0.startDraw(slot0)
	if not slot0:checkInitDrawComp() then
		slot0:handleSkip()
	end

	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonAward))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_callfor_open)
	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_inscription_amb)
	gohelper.setActive(slot0._goresult, false)
	gohelper.setActive(slot0._gocontroller, true)
	SummonController.instance:resetAnim()

	slot0.summonResult = SummonModel.instance:getSummonResult(true)

	slot0:_summonMoniterAnimIn()

	if slot0.summonResult and #slot0.summonResult > 0 then
		slot0._isDrawing = true

		slot0._drawComp:resetDraw(SummonModel.getBestRare(slot0.summonResult), #slot0.summonResult > 1)

		if not SummonController.instance:getIsGuideAnim() then
			SummonController.instance:startPlayAnim()
		else
			slot0:handleAnimStartDraw()
		end
	end
end

function slot0.checkInitDrawComp(slot0)
	if slot0._drawComp == nil then
		slot0._drawComp = VirtualSummonScene.instance:getSummonScene().director:getDrawComp(SummonEnum.ResultType.Equip)
	end

	return slot0._drawComp ~= nil
end

function slot0.handleAnimStartDraw(slot0)
	gohelper.setActive(slot0._godrag.gameObject, true)
	SummonController.instance:forbidAnim()
	slot0:_initDragArea(SummonModel.getBestRare(slot0.summonResult))
	slot0:_showGuide()
end

function slot0._initDragArea(slot0, slot1)
	slot0._dragAreaInitialized = true
end

function slot0.onDragComplete(slot0)
	gohelper.setActive(slot0._godrag, false)
	slot0:_hideGuide()
	slot0:_summonStart()
end

function slot0._summonStart(slot0)
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_inscription_draw_card)
	gohelper.setActive(slot0._godrag.gameObject, false)

	if #slot0.summonResult > 1 then
		SummonController.instance:drawEquipAnim()
	else
		SummonController.instance:drawEquipOnlyAnim()
	end

	slot0:_boomEffect()
end

function slot0._summonMoniterAnimIn(slot0)
	slot0._animLight.enabled = true

	slot0._animMonitor:Play(SummonEnum.EquipUIAnim.RootGachaIn)

	if #slot0.summonResult > 1 then
		slot0._animLight:Play(SummonEnum.EquipUIAnim.LightGacha10)
	else
		slot0._animLight:Play(SummonEnum.EquipUIAnim.LightGacha1)
	end
end

function slot0._boomEffect(slot0)
	slot2, slot3 = nil

	if SummonModel.getBestRare(slot0.summonResult) == 2 then
		slot3 = SummonEnum.SummonPreloadPath.EquipBoomN
		slot2 = ((#slot0.summonResult <= 1 or SummonEnum.EquipUIAnim.RootGachaStart10Prefix) and SummonEnum.EquipUIAnim.RootGachaStart1Prefix) .. SummonEnum.EquipUIAnim.RootGachaStartRare3
	elseif slot1 == 3 then
		slot3 = SummonEnum.SummonPreloadPath.EquipBoomR
		slot2 = slot2 .. SummonEnum.EquipUIAnim.RootGachaStartRare4
	elseif slot1 == 4 then
		slot3 = SummonEnum.SummonPreloadPath.EquipBoomSR
		slot2 = slot2 .. SummonEnum.EquipUIAnim.RootGachaStartRare5
	elseif slot1 >= 5 then
		slot3 = SummonEnum.SummonPreloadPath.EquipBoomSSR
		slot2 = slot2 .. SummonEnum.EquipUIAnim.RootGachaStartRare5
	end

	if slot3 then
		slot0._boomEffectWrap = SummonEffectPool.getEffect(slot3, SummonController.instance:getBoomNode(SummonEnum.ResultType.Equip))

		slot0._boomEffectWrap:setAnimationName(SummonEnum.BoomEquipEffectAnimationName[slot3])
		slot0._boomEffectWrap:play()
	end

	slot0._animLight.enabled = false

	slot0._animMonitor:Play(slot2)
end

function slot0.onSummonAnimEnd(slot0)
	gohelper.setActive(slot0._goresult, true)
	gohelper.setActive(slot0._btnreturn.gameObject, false)
	gohelper.setActive(slot0._btnopenall.gameObject, #slot0.summonResult > 1)
end

function slot0._summonEnd(slot0)
	SummonController.instance:clearSummonPopupList()

	slot0.summonResult = {}

	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonNormal))
	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	gohelper.setActive(slot0._gosummon, true)
	gohelper.setActive(slot0._goresult, false)
	gohelper.setActive(slot0._gocontroller, false)

	if slot0._boomEffectWrap then
		SummonEffectPool.returnEffect(slot0._boomEffectWrap)

		slot0._boomEffectWrap = nil
	end

	SummonController.instance:resetAnim()
	SummonMainController.instance:openSummonView({
		jumpPoolId = SummonController.instance:getLastPoolId()
	})
	slot0:_gc()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonEquipEnd)
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
	slot0._lastDragTime = nil
	slot0._lastDragPos = nil
	slot0._lastDragPos = recthelper.screenPosToAnchorPos(slot2.position, slot0._godrag.transform)

	slot0._drawComp:startDrag()
end

function slot0.onDragEnd(slot0, slot1, slot2)
	slot0._lastDragPos = nil

	slot0._drawComp:endDrag()
end

function slot0.onDrag(slot0, slot1, slot2)
	if not slot0._dragAreaInitialized then
		return
	end

	slot3 = 0.2
	slot4 = recthelper.screenPosToAnchorPos(slot2.position, slot0._godrag.transform)

	if not slot0._lastDragPos then
		slot0._lastDragPos = slot4

		return
	end

	if slot3 < math.abs(slot4.y - slot0._lastDragPos.y) then
		slot0._drawComp:updateDistance(slot4.y - slot0._lastDragPos.y)

		slot0._lastDragPos = slot4
	end
end

function slot0.handleCloseView(slot0, slot1)
	if slot1 == ViewName.SummonEquipGainView then
		if slot0.summonResult then
			if #slot0.summonResult == 1 then
				slot0:_summonEnd()
			else
				SummonController.instance:nextSummonPopupParam()
			end
		end
	elseif slot1 == ViewName.CommonPropView and slot0.summonResult and #slot0.summonResult == 10 then
		slot0:_summonEnd()
	end
end

function slot0._gc(slot0)
	slot0._summonCount = (slot0._summonCount or 0) + (slot0.summonResult and #slot0.summonResult)

	if slot0._summonCount >= 10 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, slot0)

		slot0._summonCount = 0
	end
end

function slot0.onDestroyView(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end
end

return slot0
