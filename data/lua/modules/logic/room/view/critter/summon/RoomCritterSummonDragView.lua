module("modules.logic.room.view.critter.summon.RoomCritterSummonDragView", package.seeall)

local var_0_0 = class("RoomCritterSummonDragView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goresult = gohelper.findChild(arg_1_0.viewGO, "#go_result")
	arg_1_0._goresultitem = gohelper.findChild(arg_1_0.viewGO, "#go_result/resultcontent/#go_resultitem")
	arg_1_0._btnreturn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#btn_return")
	arg_1_0._btnopenall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#btn_openall")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "#go_drag")
	arg_1_0._goguide = gohelper.findChild(arg_1_0.viewGO, "#go_drag/#go_guide")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, arg_2_0._onSummonSkip, arg_2_0)
	arg_2_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCanDrag, arg_2_0._onCanDrag, arg_2_0)
	arg_2_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onEndSummon, arg_2_0._onSummonDragEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, arg_3_0._onSummonSkip, arg_3_0)
	arg_3_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCanDrag, arg_3_0._onCanDrag, arg_3_0)
	arg_3_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onEndSummon, arg_3_0._onSummonDragEnd, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._godrag)

	arg_4_0._drag:AddDragListener(arg_4_0.onDrag, arg_4_0)
	arg_4_0._drag:AddDragBeginListener(arg_4_0.onDragBegin, arg_4_0)
	arg_4_0._drag:AddDragEndListener(arg_4_0.onDragEnd, arg_4_0)
	gohelper.setActive(arg_4_0._goresultitem, false)
	gohelper.setActive(arg_4_0._goresult, false)
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0._godrag.gameObject, false)

	arg_5_0._lastDragAngle = nil
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._showGuide, arg_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._drag:RemoveDragListener()
	arg_7_0._drag:RemoveDragBeginListener()
	arg_7_0._drag:RemoveDragEndListener()
end

function var_0_0._runDelayShowGuide(arg_8_0)
	gohelper.setActive(arg_8_0._goguide, false)
	TaskDispatcher.runDelay(arg_8_0._showGuide, arg_8_0, 0.3)
end

function var_0_0._showGuide(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._showGuide, arg_9_0)
	gohelper.setActive(arg_9_0._goguide, true)
end

function var_0_0._hideGuide(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._showGuide, arg_10_0)
	gohelper.setActive(arg_10_0._goguide, false)
end

function var_0_0.onDragBegin(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._startPlayAnim then
		return
	end

	arg_11_0._lastDragAngle = arg_11_2.position

	arg_11_0:_hideGuide()
end

local var_0_1 = 1

function var_0_0.onDragEnd(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0._lastDragAngle or arg_12_0._startPlayAnim then
		return
	end

	if arg_12_0._lastDragAngle.y - arg_12_2.position.y > var_0_1 and arg_12_0.viewParam then
		local var_12_0 = arg_12_0.viewParam.critterMo and arg_12_0.viewParam.critterMo:getDefineCfg()

		if var_12_0 then
			arg_12_0._startPlayAnim = true

			CritterSummonController.instance:onSummonDragEnd(arg_12_0.viewParam.mode, var_12_0.rare)
			arg_12_0:_hideGuide()
			gohelper.setActive(arg_12_0._godrag.gameObject, false)

			local var_12_1 = arg_12_0.viewParam.mode
			local var_12_2 = RoomSummonEnum.SummonMode[var_12_1].AudioId

			arg_12_0._audioId = AudioMgr.instance:trigger(var_12_2)

			return
		end
	end

	arg_12_0:_runDelayShowGuide()
end

function var_0_0.onDrag(arg_13_0, arg_13_1, arg_13_2)
	return
end

function var_0_0._onSummonSkip(arg_14_0)
	arg_14_0:openSummonGetCritterView(arg_14_0.viewParam, true)

	if arg_14_0._audioId then
		AudioMgr.instance:stopPlayingID(arg_14_0._audioId)
	end
end

function var_0_0._onCanDrag(arg_15_0)
	gohelper.setActive(arg_15_0._godrag.gameObject, true)
	arg_15_0:_runDelayShowGuide()
end

function var_0_0._onSummonDragEnd(arg_16_0)
	arg_16_0:openSummonGetCritterView(arg_16_0.viewParam, false)
end

function var_0_0.openSummonGetCritterView(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1.mode == RoomSummonEnum.SummonType.Summon and arg_17_1.critterMOList and #arg_17_1.critterMOList > 1 then
		ViewMgr.instance:openView(ViewName.RoomCritterSummonResultView, arg_17_1)
		ViewMgr.instance:closeView(ViewName.RoomCritterSummonSkipView)
	else
		CritterSummonController.instance:openSummonGetCritterView(arg_17_1, arg_17_2)
	end
end

return var_0_0
