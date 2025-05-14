module("modules.logic.prototest.view.ProtoTestFileItem", package.seeall)

local var_0_0 = class("ProtoTestFileItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtFileName = gohelper.findChildText(arg_1_1, "Txt_casefile")
	arg_1_0._btnRecover = gohelper.findChildButtonWithAudio(arg_1_1, "Btn_recover")
	arg_1_0._btnLoad = gohelper.findChildButtonWithAudio(arg_1_1, "Btn_load")
	arg_1_0._btnAppend = gohelper.findChildButtonWithAudio(arg_1_1, "Btn_append")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnRecover:AddClickListener(arg_2_0._onClickBtnRecover, arg_2_0)
	arg_2_0._btnLoad:AddClickListener(arg_2_0._onClickBtnLoad, arg_2_0)
	arg_2_0._btnAppend:AddClickListener(arg_2_0._onClickBtnAppend, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnRecover:RemoveClickListener()
	arg_3_0._btnLoad:RemoveClickListener()
	arg_3_0._btnAppend:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._txtFileName.text = arg_4_1.id .. ". " .. arg_4_1.fileName
end

function var_0_0._onClickBtnRecover(arg_5_0)
	local var_5_0 = ProtoTestCaseModel.instance:getList()

	ProtoTestMgr.instance:saveToFile(arg_5_0._mo.fileName, var_5_0)
end

function var_0_0._onClickBtnLoad(arg_6_0)
	local var_6_0 = ProtoTestMgr.instance:readFromFile(arg_6_0._mo.fileName)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		iter_6_1.id = iter_6_0
	end

	ProtoTestCaseModel.instance:setList(var_6_0)
end

function var_0_0._onClickBtnAppend(arg_7_0)
	local var_7_0 = ProtoTestMgr.instance:readFromFile(arg_7_0._mo.fileName)
	local var_7_1 = ProtoTestCaseModel.instance:getList()
	local var_7_2 = #var_7_1

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		iter_7_1.id = iter_7_0 + var_7_2

		table.insert(var_7_1, iter_7_1)
	end

	ProtoTestCaseModel.instance:setList(var_7_1)
end

return var_0_0
