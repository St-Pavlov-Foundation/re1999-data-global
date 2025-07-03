module("modules.logic.fight.entity.comp.skill.FightTLEventSetSpinePos", package.seeall)

local var_0_0 = class("FightTLEventSetSpinePos", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_3[1]
	local var_1_1

	if var_1_0 == "1" then
		var_1_1 = {}

		table.insert(var_1_1, FightHelper.getEntity(arg_1_1.fromId))
	elseif var_1_0 == "2" then
		var_1_1 = FightHelper.getSkillTargetEntitys(arg_1_1)
	elseif var_1_0 == "3" then
		local var_1_2 = FightHelper.getEntity(arg_1_1.fromId)

		var_1_1 = FightHelper.getSideEntitys(var_1_2:getSide(), true)
	elseif var_1_0 == "4" then
		local var_1_3 = FightHelper.getEntity(arg_1_1.toId)

		var_1_1 = FightHelper.getSideEntitys(var_1_3:getSide(), true)
	elseif var_1_0 == "5" then
		local var_1_4 = FightHelper.getEntity(arg_1_1.fromId)

		var_1_1 = FightHelper.getSideEntitys(var_1_4:getSide(), true)

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			if iter_1_1.id == arg_1_1.fromId then
				table.remove(var_1_1, iter_1_0)

				break
			end
		end
	end

	if not string.nilorempty(arg_1_3[4]) then
		local var_1_5 = GameSceneMgr.instance:getCurScene().deadEntityMgr

		var_1_1 = {}

		local var_1_6 = string.splitToNumber(arg_1_3[4], "#")

		for iter_1_2, iter_1_3 in pairs(var_1_5._entityDic) do
			local var_1_7 = iter_1_3:getMO()

			if var_1_7 and tabletool.indexOf(var_1_6, var_1_7.skin) then
				table.insert(var_1_1, iter_1_3)
			end
		end
	end

	local var_1_8 = string.splitToNumber(arg_1_3[2], "#")
	local var_1_9 = arg_1_3[3] == "1"

	if #var_1_1 > 0 then
		for iter_1_4, iter_1_5 in ipairs(var_1_1) do
			local var_1_10 = iter_1_5.spine
			local var_1_11 = var_1_10 and var_1_10:getSpineTr()

			if var_1_11 then
				if var_1_9 then
					transformhelper.setLocalPos(var_1_11, 0, 0, 0)
				else
					transformhelper.setLocalPos(var_1_11, var_1_8[1] or 0, var_1_8[2] or 0, var_1_8[3] or 0)
				end
			end
		end
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

return var_0_0
