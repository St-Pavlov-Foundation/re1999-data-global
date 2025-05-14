module("modules.logic.mail.model.MailCategroyModel", package.seeall)

local var_0_0 = class("MailCategroyModel", ListScrollModel)

function var_0_0.setCategoryList(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._moList = {}

	if arg_1_1 then
		arg_1_0._moList = arg_1_1

		if arg_1_2 then
			table.sort(arg_1_0._moList, arg_1_0._sortFunction)
		end
	end

	arg_1_0:setList(arg_1_0._moList)
	arg_1_0:_refreshCount()
end

function var_0_0._sortFunction(arg_2_0, arg_2_1)
	local var_2_0 = 0
	local var_2_1 = 0

	if arg_2_0.state < arg_2_1.state then
		var_2_0 = 2
	elseif arg_2_0.state > arg_2_1.state then
		var_2_0 = -2
	end

	if arg_2_0.createTime < arg_2_1.createTime then
		var_2_1 = -1
	elseif arg_2_0.createTime > arg_2_1.createTime then
		var_2_1 = 1
	end

	return var_2_0 + var_2_1 > 0
end

function var_0_0.addMail(arg_3_0)
	arg_3_0:_refreshCount()
end

function var_0_0.refreshCategoryList(arg_4_0, arg_4_1)
	MailController.instance:dispatchEvent(MailEvent.OnMailDel, arg_4_1)
	arg_4_0:_refreshCount()
end

function var_0_0.refreshCategoryItem(arg_5_0, arg_5_1)
	MailController.instance:dispatchEvent(MailEvent.OnMailRead, arg_5_1)
	arg_5_0:_refreshCount()
end

function var_0_0._refreshCount(arg_6_0)
	MailController.instance:dispatchEvent(MailEvent.OnMailCountChange)
end

var_0_0.instance = var_0_0.New()

return var_0_0
