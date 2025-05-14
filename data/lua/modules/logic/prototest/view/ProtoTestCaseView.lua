module("modules.logic.prototest.view.ProtoTestCaseView", package.seeall)

local var_0_0 = class("ProtoTestCaseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnRecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel_testcase/Panel_oprator/Btn_record")
	arg_1_0._btnStop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel_testcase/Panel_oprator/Btn_stop")
	arg_1_0._btnClear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel_testcase/Panel_oprator/Btn_clear")
	arg_1_0._btnSendAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel_testcase/Panel_oprator/Btn_SendAll")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnRecord:AddClickListener(arg_2_0._onClickBtnRecord, arg_2_0)
	arg_2_0._btnStop:AddClickListener(arg_2_0._onClickBtnStop, arg_2_0)
	arg_2_0._btnClear:AddClickListener(arg_2_0._onClickBtnClear, arg_2_0)
	arg_2_0._btnSendAll:AddClickListener(arg_2_0._onClickBtnSendAll, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnRecord:RemoveClickListener()
	arg_3_0._btnStop:RemoveClickListener()
	arg_3_0._btnClear:RemoveClickListener()
	arg_3_0._btnSendAll:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_3_0._onFrameSendProto, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_updateRecordBtn()
end

function var_0_0._updateRecordBtn(arg_5_0)
	local var_5_0 = ProtoTestMgr.instance:isRecording()

	gohelper.setActive(arg_5_0._btnRecord.gameObject, not var_5_0)
	gohelper.setActive(arg_5_0._btnStop.gameObject, var_5_0)
end

function var_0_0._onClickBtnRecord(arg_6_0)
	ProtoTestMgr.instance:startRecord()
	arg_6_0:_updateRecordBtn()
end

function var_0_0._onClickBtnStop(arg_7_0)
	ProtoTestMgr.instance:endRecord()
	arg_7_0:_updateRecordBtn()
end

function var_0_0._onClickBtnClear(arg_8_0)
	ProtoTestCaseModel.instance:clear()
end

function var_0_0._onClickBtnSendAll(arg_9_0)
	local var_9_0 = ProtoTestCaseModel.instance:getList()

	arg_9_0._toSendProtoList = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = iter_9_1:buildProtoMsg()

		table.insert(arg_9_0._toSendProtoList, var_9_1)
	end

	TaskDispatcher.runRepeat(arg_9_0._onFrameSendProto, arg_9_0, 0.033)
end

function var_0_0._onFrameSendProto(arg_10_0)
	if arg_10_0._toSendProtoList and #arg_10_0._toSendProtoList > 0 then
		local var_10_0 = table.remove(arg_10_0._toSendProtoList, 1)

		LuaSocketMgr.instance:sendMsg(var_10_0)
	end

	if not arg_10_0._toSendProtoList or #arg_10_0._toSendProtoList == 0 then
		arg_10_0._toSendProtoList = nil

		TaskDispatcher.cancelTask(arg_10_0._onFrameSendProto, arg_10_0)
	end
end

return var_0_0
