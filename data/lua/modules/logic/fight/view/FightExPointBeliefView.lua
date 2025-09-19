module("modules.logic.fight.view.FightExPointBeliefView", package.seeall)

local var_0_0 = class("FightExPointBeliefView", FightBaseView)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.entityData = arg_1_1
	arg_1_0.entityId = arg_1_1.id
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.root1 = gohelper.findChild(arg_2_0.viewGO, "expointContainer/exPointLine1")
	arg_2_0.root2 = gohelper.findChild(arg_2_0.viewGO, "expointContainer/exPointLine2")
	arg_2_0.objItem = gohelper.findChild(arg_2_0.viewGO, "expointContainer/#go_pointItem")
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:com_registFightEvent(FightEvent.OnExpointMaxAdd, arg_3_0.onExPointMaxAdd)
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0.onGetExPointView(arg_5_0, arg_5_1)
	if arg_5_1 == arg_5_0.entityId then
		arg_5_0:com_replyMsg(FightMsgId.GetExPointView, arg_5_0)
	end
end

function var_0_0.onOpen(arg_6_0)
	gohelper.setActive(arg_6_0.objItem, false)

	arg_6_0.itemList = {}

	arg_6_0:createObjList()
end

function var_0_0.createObjList(arg_7_0)
	local var_7_0 = arg_7_0.entityData:getMaxExPoint()

	for iter_7_0 = 1, var_7_0 do
		if not arg_7_0.itemList[iter_7_0] then
			local var_7_1 = iter_7_0 <= 4 and arg_7_0.root1 or arg_7_0.root2
			local var_7_2 = gohelper.clone(arg_7_0.objItem, var_7_1, iter_7_0)

			arg_7_0.itemList[iter_7_0] = arg_7_0:com_openSubView(FightExPointBeliefItemView, var_7_2, var_7_1, iter_7_0, arg_7_0.entityData)
		end

		gohelper.setActive(arg_7_0.itemList[iter_7_0].viewGO, true)
	end

	for iter_7_1 = var_7_0 + 1, #arg_7_0.itemList do
		gohelper.setActive(arg_7_0.itemList[iter_7_1].viewGO, false)
	end
end

function var_0_0.onExPointMaxAdd(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= arg_8_0.entityId then
		return
	end

	arg_8_0:createObjList()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
