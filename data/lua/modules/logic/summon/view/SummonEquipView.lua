module("modules.logic.summon.view.SummonEquipView", package.seeall)

local var_0_0 = class("SummonEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goresult = gohelper.findChild(arg_1_0.viewGO, "#go_result")
	arg_1_0._goresultitem = gohelper.findChild(arg_1_0.viewGO, "#go_result/resultcontent/#go_resultitem")
	arg_1_0._btnopenall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#btn_openall")
	arg_1_0._btnreturn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#btn_return")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "#go_drag")
	arg_1_0._gocontroller = gohelper.findChild(arg_1_0.viewGO, "#go_controller")
	arg_1_0._goguide = gohelper.findChild(arg_1_0.viewGO, "#go_drag/#go_guide")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreturn:AddClickListener(arg_2_0._btnreturnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreturn:RemoveClickListener()
end

function var_0_0._btnreturnOnClick(arg_4_0)
	arg_4_0:_summonEnd()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:checkInitDrawComp()

	arg_5_0._animMonitor = arg_5_0._gocontroller:GetComponent(typeof(UnityEngine.Animation))
	arg_5_0._animLight = gohelper.findChild(arg_5_0._gocontroller, "shiying"):GetComponent(typeof(UnityEngine.Animation))

	local var_5_0

	arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_5_0._godrag)

	arg_5_0._drag:AddDragListener(arg_5_0.onDrag, arg_5_0)
	arg_5_0._drag:AddDragBeginListener(arg_5_0.onDragBegin, arg_5_0)
	arg_5_0._drag:AddDragEndListener(arg_5_0.onDragEnd, arg_5_0)
end

function var_0_0.handleSkip(arg_6_0)
	if not arg_6_0._isDrawing then
		return
	end

	arg_6_0:_hideGuide()

	if arg_6_0:checkInitDrawComp() then
		arg_6_0._drawComp:skip()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	SummonController.instance:playSkipAnimation(false)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_8_0.startDraw, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimEnterDraw, arg_8_0.handleAnimStartDraw, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonDraw, arg_8_0.onDragComplete, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, arg_8_0.onSummonAnimEnd, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonResultClose, arg_8_0._summonEnd, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonSkip, arg_8_0.handleSkip, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_8_0.handleCloseView, arg_8_0)
end

function var_0_0.onClose(arg_9_0)
	arg_9_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_9_0.startDraw, arg_9_0)
	arg_9_0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimEnterDraw, arg_9_0.handleAnimStartDraw, arg_9_0)
	arg_9_0:removeEventCb(SummonController.instance, SummonEvent.onSummonDraw, arg_9_0.onDragComplete, arg_9_0)
	arg_9_0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, arg_9_0.onSummonAnimEnd, arg_9_0)
	arg_9_0:removeEventCb(SummonController.instance, SummonEvent.onSummonResultClose, arg_9_0._summonEnd, arg_9_0)
	arg_9_0:removeEventCb(SummonController.instance, SummonEvent.onSummonSkip, arg_9_0.handleSkip, arg_9_0)
	arg_9_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_9_0.handleCloseView, arg_9_0)
end

function var_0_0.startDraw(arg_10_0)
	if not arg_10_0:checkInitDrawComp() then
		arg_10_0:handleSkip()
	end

	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonAward))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_callfor_open)
	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_inscription_amb)
	gohelper.setActive(arg_10_0._goresult, false)
	gohelper.setActive(arg_10_0._gocontroller, true)
	SummonController.instance:resetAnim()

	arg_10_0.summonResult = SummonModel.instance:getSummonResult(true)

	local var_10_0 = SummonModel.getBestRare(arg_10_0.summonResult)

	arg_10_0:_summonMoniterAnimIn()

	if arg_10_0.summonResult and #arg_10_0.summonResult > 0 then
		arg_10_0._isDrawing = true

		arg_10_0._drawComp:resetDraw(var_10_0, #arg_10_0.summonResult > 1)

		if not SummonController.instance:getIsGuideAnim() then
			SummonController.instance:startPlayAnim()
		else
			arg_10_0:handleAnimStartDraw()
		end
	end
end

function var_0_0.checkInitDrawComp(arg_11_0)
	if arg_11_0._drawComp == nil then
		arg_11_0._drawComp = VirtualSummonScene.instance:getSummonScene().director:getDrawComp(SummonEnum.ResultType.Equip)
	end

	return arg_11_0._drawComp ~= nil
end

function var_0_0.handleAnimStartDraw(arg_12_0)
	local var_12_0 = SummonModel.getBestRare(arg_12_0.summonResult)

	gohelper.setActive(arg_12_0._godrag.gameObject, true)
	SummonController.instance:forbidAnim()
	arg_12_0:_initDragArea(var_12_0)
	arg_12_0:_showGuide()
end

function var_0_0._initDragArea(arg_13_0, arg_13_1)
	arg_13_0._dragAreaInitialized = true
end

function var_0_0.onDragComplete(arg_14_0)
	gohelper.setActive(arg_14_0._godrag, false)
	arg_14_0:_hideGuide()
	arg_14_0:_summonStart()
end

function var_0_0._summonStart(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_inscription_draw_card)
	gohelper.setActive(arg_15_0._godrag.gameObject, false)

	if #arg_15_0.summonResult > 1 then
		SummonController.instance:drawEquipAnim()
	else
		SummonController.instance:drawEquipOnlyAnim()
	end

	arg_15_0:_boomEffect()
end

function var_0_0._summonMoniterAnimIn(arg_16_0)
	arg_16_0._animLight.enabled = true

	arg_16_0._animMonitor:Play(SummonEnum.EquipUIAnim.RootGachaIn)

	if #arg_16_0.summonResult > 1 then
		arg_16_0._animLight:Play(SummonEnum.EquipUIAnim.LightGacha10)
	else
		arg_16_0._animLight:Play(SummonEnum.EquipUIAnim.LightGacha1)
	end
end

function var_0_0._boomEffect(arg_17_0)
	local var_17_0 = SummonModel.getBestRare(arg_17_0.summonResult)
	local var_17_1
	local var_17_2

	if #arg_17_0.summonResult > 1 then
		var_17_1 = SummonEnum.EquipUIAnim.RootGachaStart10Prefix
	else
		var_17_1 = SummonEnum.EquipUIAnim.RootGachaStart1Prefix
	end

	if var_17_0 == 2 then
		var_17_2 = SummonEnum.SummonPreloadPath.EquipBoomN
		var_17_1 = var_17_1 .. SummonEnum.EquipUIAnim.RootGachaStartRare3
	elseif var_17_0 == 3 then
		var_17_2 = SummonEnum.SummonPreloadPath.EquipBoomR
		var_17_1 = var_17_1 .. SummonEnum.EquipUIAnim.RootGachaStartRare4
	elseif var_17_0 == 4 then
		var_17_2 = SummonEnum.SummonPreloadPath.EquipBoomSR
		var_17_1 = var_17_1 .. SummonEnum.EquipUIAnim.RootGachaStartRare5
	elseif var_17_0 >= 5 then
		var_17_2 = SummonEnum.SummonPreloadPath.EquipBoomSSR
		var_17_1 = var_17_1 .. SummonEnum.EquipUIAnim.RootGachaStartRare5
	end

	if var_17_2 then
		local var_17_3 = SummonController.instance:getBoomNode(SummonEnum.ResultType.Equip)

		arg_17_0._boomEffectWrap = SummonEffectPool.getEffect(var_17_2, var_17_3)

		arg_17_0._boomEffectWrap:setAnimationName(SummonEnum.BoomEquipEffectAnimationName[var_17_2])
		arg_17_0._boomEffectWrap:play()
	end

	arg_17_0._animLight.enabled = false

	arg_17_0._animMonitor:Play(var_17_1)
end

function var_0_0.onSummonAnimEnd(arg_18_0)
	gohelper.setActive(arg_18_0._goresult, true)
	gohelper.setActive(arg_18_0._btnreturn.gameObject, false)
	gohelper.setActive(arg_18_0._btnopenall.gameObject, #arg_18_0.summonResult > 1)
end

function var_0_0._summonEnd(arg_19_0)
	SummonController.instance:clearSummonPopupList()

	arg_19_0.summonResult = {}

	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonNormal))
	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	gohelper.setActive(arg_19_0._gosummon, true)
	gohelper.setActive(arg_19_0._goresult, false)
	gohelper.setActive(arg_19_0._gocontroller, false)

	if arg_19_0._boomEffectWrap then
		SummonEffectPool.returnEffect(arg_19_0._boomEffectWrap)

		arg_19_0._boomEffectWrap = nil
	end

	SummonController.instance:resetAnim()

	local var_19_0 = {
		jumpPoolId = SummonController.instance:getLastPoolId()
	}

	SummonMainController.instance:openSummonView(var_19_0)
	arg_19_0:_gc()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonEquipEnd)
end

function var_0_0._showGuide(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._showGuide, arg_20_0)
	gohelper.setActive(arg_20_0._goguide, true)
end

function var_0_0._hideGuide(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._showGuide, arg_21_0)
	gohelper.setActive(arg_21_0._goguide, false)
end

function var_0_0.onDragBegin(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._lastDragTime = nil
	arg_22_0._lastDragPos = nil
	arg_22_0._lastDragPos = recthelper.screenPosToAnchorPos(arg_22_2.position, arg_22_0._godrag.transform)

	arg_22_0._drawComp:startDrag()
end

function var_0_0.onDragEnd(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._lastDragPos = nil

	arg_23_0._drawComp:endDrag()
end

function var_0_0.onDrag(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_0._dragAreaInitialized then
		return
	end

	local var_24_0 = 0.2
	local var_24_1 = recthelper.screenPosToAnchorPos(arg_24_2.position, arg_24_0._godrag.transform)

	if not arg_24_0._lastDragPos then
		arg_24_0._lastDragPos = var_24_1

		return
	end

	if var_24_0 < math.abs(var_24_1.y - arg_24_0._lastDragPos.y) then
		arg_24_0._drawComp:updateDistance(var_24_1.y - arg_24_0._lastDragPos.y)

		arg_24_0._lastDragPos = var_24_1
	end
end

function var_0_0.handleCloseView(arg_25_0, arg_25_1)
	if arg_25_1 == ViewName.SummonEquipGainView then
		if arg_25_0.summonResult then
			if #arg_25_0.summonResult == 1 then
				arg_25_0:_summonEnd()
			else
				SummonController.instance:nextSummonPopupParam()
			end
		end
	elseif arg_25_1 == ViewName.CommonPropView and arg_25_0.summonResult and #arg_25_0.summonResult == 10 then
		arg_25_0:_summonEnd()
	end
end

function var_0_0._gc(arg_26_0)
	arg_26_0._summonCount = (arg_26_0._summonCount or 0) + (arg_26_0.summonResult and #arg_26_0.summonResult)

	if arg_26_0._summonCount >= 10 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, arg_26_0)

		arg_26_0._summonCount = 0
	end
end

function var_0_0.onDestroyView(arg_27_0)
	if arg_27_0._drag then
		arg_27_0._drag:RemoveDragListener()
		arg_27_0._drag:RemoveDragBeginListener()
		arg_27_0._drag:RemoveDragEndListener()

		arg_27_0._drag = nil
	end
end

return var_0_0
