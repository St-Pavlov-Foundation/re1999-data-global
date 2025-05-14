module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessPieceSkillMO", package.seeall)

local var_0_0 = class("WarChessPieceSkillMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.tag = arg_1_1.tag
	arg_1_0.currGrowUpTime = arg_1_1.currGrowUpTime
	arg_1_0.growUpTime = arg_1_1.growUpTime
	arg_1_0.canGrowUp = arg_1_1.canGrowUp
end

function var_0_0.updateSkillGrowUp(arg_2_0, arg_2_1)
	arg_2_0.currGrowUpTime = math.max(arg_2_0.currGrowUpTime + arg_2_1, 0)
end

function var_0_0.needShowGrowUp(arg_3_0)
	return arg_3_0.growUpTime ~= 0
end

function var_0_0.getGrowUpProgress(arg_4_0)
	return (arg_4_0.growUpTime - arg_4_0.currGrowUpTime) / arg_4_0.growUpTime
end

return var_0_0
