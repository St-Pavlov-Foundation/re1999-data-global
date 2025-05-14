module("modules.logic.fight.fightcomponent.FightDragComponent", package.seeall)

local var_0_0 = class("FightDragComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._dragDic = {}
end

function var_0_0.registDragBegin(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = arg_2_1:GetInstanceID()

	arg_2_0._dragDic[var_2_0] = arg_2_1

	arg_2_1:AddDragBeginListener(arg_2_2, arg_2_3, arg_2_4)
end

function var_0_0.registDrag(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_1:GetInstanceID()

	arg_3_0._dragDic[var_3_0] = arg_3_1

	arg_3_1:AddDragListener(arg_3_2, arg_3_3, arg_3_4)
end

function var_0_0.registDragEnd(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = arg_4_1:GetInstanceID()

	arg_4_0._dragDic[var_4_0] = arg_4_1

	arg_4_1:AddDragEndListener(arg_4_2, arg_4_3, arg_4_4)
end

function var_0_0.removeDragBegin(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetInstanceID()

	if arg_5_0._dragDic[var_5_0] then
		arg_5_0._dragDic[var_5_0]:RemoveDragBeginListener()
	end
end

function var_0_0.removeDrag(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:GetInstanceID()

	if arg_6_0._dragDic[var_6_0] then
		arg_6_0._dragDic[var_6_0]:RemoveDragListener()
	end
end

function var_0_0.removeDragEnd(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetInstanceID()

	if arg_7_0._dragDic[var_7_0] then
		arg_7_0._dragDic[var_7_0]:RemoveDragEndListener()
	end
end

function var_0_0.onDestructor(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._dragDic) do
		iter_8_1:RemoveDragBeginListener()
		iter_8_1:RemoveDragListener()
		iter_8_1:RemoveDragEndListener()
	end
end

return var_0_0
