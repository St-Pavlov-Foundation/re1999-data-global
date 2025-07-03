module("modules.logic.fight.entity.comp.skill.FightTLEventAtkSpineLookDir", package.seeall)

local var_0_0 = class("FightTLEventAtkSpineLookDir", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = string.nilorempty(arg_1_3[2]) and "1" or arg_1_3[2]
	local var_1_1 = arg_1_3[3] == "1"
	local var_1_2 = arg_1_0._getEntitys(arg_1_1, var_1_0)
	local var_1_3 = FightHelper.getEntity(arg_1_1.fromId).spine:getLookDir()

	for iter_1_0, iter_1_1 in ipairs(var_1_2) do
		if var_1_1 then
			local var_1_4 = iter_1_1:getMO()
			local var_1_5 = FightHelper.getEntitySpineLookDir(var_1_4)

			if iter_1_1.spine then
				iter_1_1.spine:changeLookDir(var_1_5)
			end
		else
			local var_1_6 = iter_1_1.spine:getLookDir()
			local var_1_7 = var_1_6

			if arg_1_3[1] == "1" then
				var_1_7 = 1
			elseif arg_1_3[1] == "2" then
				var_1_7 = -1
			elseif arg_1_3[1] == "3" then
				var_1_7 = var_1_3
			elseif arg_1_3[1] == "4" then
				var_1_7 = -var_1_3
			end

			if var_1_7 ~= var_1_6 then
				iter_1_1.spine:changeLookDir(var_1_7)
			end
		end
	end
end

function var_0_0._getEntitys(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = FightHelper.getEntity(arg_2_0.fromId)
	local var_2_2 = FightHelper.getEntity(arg_2_0.toId)

	if arg_2_1 == "1" then
		table.insert(var_2_0, var_2_1)
	elseif arg_2_1 == "2" then
		local var_2_3 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.actEffect) do
			local var_2_4 = FightHelper.getEntity(iter_2_1.targetId)

			if var_2_4 and var_2_4:getSide() ~= var_2_1:getSide() and not var_2_3[iter_2_1.targetId] then
				table.insert(var_2_0, var_2_4)

				var_2_3[iter_2_1.targetId] = true
			end
		end
	elseif arg_2_1 == "3" then
		var_2_0 = FightHelper.getSideEntitys(var_2_1:getSide(), false)
	elseif arg_2_1 == "4" then
		var_2_0 = FightHelper.getSideEntitys(var_2_2:getSide(), false)
	elseif arg_2_1 == "5" then
		local var_2_5 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)
		local var_2_6 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)

		tabletool.addValues(var_2_0, var_2_5)
		tabletool.addValues(var_2_0, var_2_6)
	elseif arg_2_1 == "6" then
		table.insert(var_2_0, var_2_2)
	else
		local var_2_7 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_2_8 = arg_2_0.stepUid .. "_" .. arg_2_1

		table.insert(var_2_0, var_2_7:getUnit(SceneTag.UnitNpc, var_2_8))
	end

	return var_2_0
end

return var_0_0
