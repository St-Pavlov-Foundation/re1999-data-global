module("modules.logic.gm.view.yeshumei.GMYeShuMeiOrder", package.seeall)

local var_0_0 = class("GMYeShuMeiOrder", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtorder = gohelper.findChildText(arg_1_1, "#txt_order")
	arg_1_0._btndelete = gohelper.findChildButton(arg_1_1, "#btn_delete")
	arg_1_0._btnswitch = gohelper.findChildButton(arg_1_1, "#btn_switch")
	arg_1_0._gobg = gohelper.findChild(arg_1_1, "image")

	gohelper.setActive(arg_1_0.go, true)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btndelete:AddClickListener(arg_2_0._onClickBtnDelete, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._onClickBtnSwitch, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btndelete:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
end

function var_0_0.initOrder(arg_4_0, arg_4_1)
	arg_4_0.order = arg_4_1
	arg_4_0._txtorder.text = "连线顺序：" .. arg_4_1
end

function var_0_0.getOrder(arg_5_0)
	return arg_5_0.order
end

function var_0_0.updateOrder(arg_6_0)
	gohelper.setActive(arg_6_0._gobg, arg_6_0.order == GMYeShuMeiModel.instance:getCurLevelOrder())
end

function var_0_0._onClickBtnDelete(arg_7_0)
	arg_7_0._deleteCb(arg_7_0._deleteObj, arg_7_0.order)
end

function var_0_0._onClickBtnSwitch(arg_8_0)
	arg_8_0._switchCb(arg_8_0._switchObj, arg_8_0.order)
end

function var_0_0.addDeleteCb(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._deleteCb = arg_9_1
	arg_9_0._deleteObj = arg_9_2
end

function var_0_0.addSwitchCb(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._switchCb = arg_10_1
	arg_10_0._switchObj = arg_10_2
end

function var_0_0.onDestroy(arg_11_0)
	gohelper.destroy(arg_11_0.go)
end

return var_0_0
