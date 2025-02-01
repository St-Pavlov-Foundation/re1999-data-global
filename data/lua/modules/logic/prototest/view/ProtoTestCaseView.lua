module("modules.logic.prototest.view.ProtoTestCaseView", package.seeall)

slot0 = class("ProtoTestCaseView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnRecord = gohelper.findChildButtonWithAudio(slot0.viewGO, "Panel_testcase/Panel_oprator/Btn_record")
	slot0._btnStop = gohelper.findChildButtonWithAudio(slot0.viewGO, "Panel_testcase/Panel_oprator/Btn_stop")
	slot0._btnClear = gohelper.findChildButtonWithAudio(slot0.viewGO, "Panel_testcase/Panel_oprator/Btn_clear")
	slot0._btnSendAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "Panel_testcase/Panel_oprator/Btn_SendAll")
end

function slot0.addEvents(slot0)
	slot0._btnRecord:AddClickListener(slot0._onClickBtnRecord, slot0)
	slot0._btnStop:AddClickListener(slot0._onClickBtnStop, slot0)
	slot0._btnClear:AddClickListener(slot0._onClickBtnClear, slot0)
	slot0._btnSendAll:AddClickListener(slot0._onClickBtnSendAll, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnRecord:RemoveClickListener()
	slot0._btnStop:RemoveClickListener()
	slot0._btnClear:RemoveClickListener()
	slot0._btnSendAll:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._onFrameSendProto, slot0)
end

function slot0.onOpen(slot0)
	slot0:_updateRecordBtn()
end

function slot0._updateRecordBtn(slot0)
	slot1 = ProtoTestMgr.instance:isRecording()

	gohelper.setActive(slot0._btnRecord.gameObject, not slot1)
	gohelper.setActive(slot0._btnStop.gameObject, slot1)
end

function slot0._onClickBtnRecord(slot0)
	ProtoTestMgr.instance:startRecord()
	slot0:_updateRecordBtn()
end

function slot0._onClickBtnStop(slot0)
	ProtoTestMgr.instance:endRecord()
	slot0:_updateRecordBtn()
end

function slot0._onClickBtnClear(slot0)
	ProtoTestCaseModel.instance:clear()
end

function slot0._onClickBtnSendAll(slot0)
	slot0._toSendProtoList = {}

	for slot5, slot6 in ipairs(ProtoTestCaseModel.instance:getList()) do
		table.insert(slot0._toSendProtoList, slot6:buildProtoMsg())
	end

	TaskDispatcher.runRepeat(slot0._onFrameSendProto, slot0, 0.033)
end

function slot0._onFrameSendProto(slot0)
	if slot0._toSendProtoList and #slot0._toSendProtoList > 0 then
		LuaSocketMgr.instance:sendMsg(table.remove(slot0._toSendProtoList, 1))
	end

	if not slot0._toSendProtoList or #slot0._toSendProtoList == 0 then
		slot0._toSendProtoList = nil

		TaskDispatcher.cancelTask(slot0._onFrameSendProto, slot0)
	end
end

return slot0
