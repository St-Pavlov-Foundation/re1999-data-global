module("modules.logic.versionactivity2_5.liangyue.view.LiangYueAttributeItem", package.seeall)

local var_0_0 = class("LiangYueAttributeItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._go_Target1 = gohelper.findChild(arg_1_1, "#go_Target1")
	arg_1_0._go_Target2 = gohelper.findChild(arg_1_1, "#go_Target2")
	arg_1_0._go_Target3 = gohelper.findChild(arg_1_1, "#go_Target3")

	arg_1_0:initComp()
end

function var_0_0.initComp(arg_2_0)
	arg_2_0._descItemList = {}
	arg_2_0._targetObjList = {
		arg_2_0._go_Target1,
		arg_2_0._go_Target2,
		arg_2_0._go_Target3
	}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._targetObjList) do
		local var_2_0 = LiangYueAttributeDescItem.New()

		var_2_0:init(iter_2_1)
		table.insert(arg_2_0._descItemList, var_2_0)
	end
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0.go, arg_3_1)
end

function var_0_0.setInfo(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._descItemList) do
		if not arg_4_1[iter_4_0] then
			iter_4_1:setActive(false)
		else
			local var_4_0 = arg_4_1[iter_4_0]

			iter_4_1:setActive(true)
			iter_4_1:setInfo(var_4_0[2], var_4_0[3])
		end
	end
end

function var_0_0.setItemPos(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.yPos = arg_5_1
	arg_5_0.columnCount = arg_5_2
end

function var_0_0.onDestroy(arg_6_0)
	return
end

return var_0_0
