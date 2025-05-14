module("modules.logic.prototest.view.ProtoReqListItem", package.seeall)

local var_0_0 = class("ProtoReqListItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._imgGO1 = gohelper.findChild(arg_1_1, "img1")
	arg_1_0._imgGO2 = gohelper.findChild(arg_1_1, "img2")
	arg_1_0._txtModule = gohelper.findChildText(arg_1_1, "txtModule")
	arg_1_0._txtCmd = gohelper.findChildText(arg_1_1, "txtCmd")
	arg_1_0._txtReq = gohelper.findChildText(arg_1_1, "txtReq")
	arg_1_0._click = gohelper.findChildClick(arg_1_1, "")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._txtModule.text = arg_4_1.module
	arg_4_0._txtCmd.text = arg_4_1.cmd
	arg_4_0._txtReq.text = arg_4_1.req

	gohelper.setActive(arg_4_0._imgGO1, arg_4_0._index % 2 == 0)
	gohelper.setActive(arg_4_0._imgGO2, arg_4_0._index % 2 == 1)
end

function var_0_0._onClickThis(arg_5_0)
	ProtoTestMgr.instance:dispatchEvent(ProtoEnum.OnClickReqListItem, arg_5_0._mo)
end

return var_0_0
