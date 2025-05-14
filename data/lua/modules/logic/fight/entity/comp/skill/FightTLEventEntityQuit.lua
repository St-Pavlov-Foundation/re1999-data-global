module("modules.logic.fight.entity.comp.skill.FightTLEventEntityQuit", package.seeall)

local var_0_0 = class("FightTLEventEntityQuit")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_1.fromId
	local var_1_1 = arg_1_1.toId
	local var_1_2 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_1_3

	if arg_1_3[1] == "1" then
		var_1_3 = var_1_0
	elseif arg_1_3[1] == "2" then
		var_1_3 = var_1_1
	end

	local var_1_4 = var_1_2:getEntity(var_1_3)

	if var_1_4 then
		var_1_2:removeUnit(var_1_4:getTag(), var_1_4.id)
	end

	local var_1_5 = FightDataHelper.entityMgr:getById(var_1_3)
	local var_1_6 = FightEntityModel.instance:getModel(var_1_5.side)
	local var_1_7 = FightEntityModel.instance:getSubModel(var_1_5.side)

	if arg_1_3[2] == "1" then
		var_1_6:remove(var_1_5)
		var_1_7:remove(var_1_5)
	end

	if arg_1_3[3] == "1" and var_1_4 and not var_1_4.isDead then
		var_1_7:addAt(var_1_5, arg_1_1.subIndex or logError("找不到替补的数据下标"))
	end
end

function var_0_0.reset(arg_2_0)
	arg_2_0:dispose()
end

function var_0_0.dispose(arg_3_0)
	return
end

function var_0_0.onSkillEnd(arg_4_0)
	return
end

return var_0_0
