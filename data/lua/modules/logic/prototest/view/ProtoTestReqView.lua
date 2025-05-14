module("modules.logic.prototest.view.ProtoTestReqView", package.seeall)

local var_0_0 = class("ProtoTestReqView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._panelNew = gohelper.findChild(arg_1_0.viewGO, "Panel_testcase/Panel_new")
	arg_1_0._bgGO = gohelper.findChild(arg_1_0.viewGO, "Panel_testcase/Panel_new/bg")
	arg_1_0._bgTr = arg_1_0._bgGO.transform
	arg_1_0._inpRequest = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "Panel_testcase/Panel_new/bg/inpRequest")
	arg_1_0._btnNewCase = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel_testcase/Panel_oprator/Btn_NewCase")
	arg_1_0._click = gohelper.getClick(arg_1_0._panelNew)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickMask, arg_2_0)
	arg_2_0._btnNewCase:AddClickListener(arg_2_0._onClickBtnNewCase, arg_2_0)
	arg_2_0._inpRequest:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
	arg_2_0:addEventCb(ProtoTestMgr.instance, ProtoEnum.OnClickReqListItem, arg_2_0._onClickReqListItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btnNewCase:RemoveClickListener()
	arg_3_0._inpRequest:RemoveOnValueChanged()
	arg_3_0:removeEventCb(ProtoTestMgr.instance, ProtoEnum.OnClickReqListItem, arg_3_0._onClickReqListItem, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._panelNew, false)
end

function var_0_0._onClickMask(arg_5_0)
	gohelper.setActive(arg_5_0._panelNew, false)
end

function var_0_0._onClickBtnNewCase(arg_6_0)
	gohelper.setActive(arg_6_0._panelNew, true)
	arg_6_0:_updateListView()
end

function var_0_0._onValueChanged(arg_7_0, arg_7_1)
	arg_7_0:_updateListView()
end

function var_0_0._onClickReqListItem(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._panelNew, false)

	local var_8_0 = ProtoParamHelper.buildProtoByStructName(arg_8_1.req)
	local var_8_1 = ProtoTestCaseMO.New()

	var_8_1:initFromProto(arg_8_1.cmd, var_8_0)
	ProtoTestCaseModel.instance:addAtLast(var_8_1)
end

function var_0_0._updateListView(arg_9_0)
	local var_9_0 = ProtoReqListModel.instance:getFilterList(arg_9_0._inpRequest:GetText())
	local var_9_1 = #var_9_0

	var_9_1 = var_9_1 > 10 and 10 or var_9_1
	var_9_1 = var_9_1 < 1 and 1 or var_9_1

	recthelper.setHeight(arg_9_0._bgTr, 40 + var_9_1 * 60)
	ProtoReqListModel.instance:setList(var_9_0)
end

return var_0_0
