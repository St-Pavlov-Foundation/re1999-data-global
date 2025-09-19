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

		var_1_1 = FightHelper.getAllSideEntitys(var_1_2:getSide())
	elseif var_1_0 == "4" then
		local var_1_3 = FightDataHelper.entityMgr:getById(arg_1_1.toId)

		var_1_1 = var_1_3 and FightHelper.getAllSideEntitys(var_1_3.side) or {}
	elseif var_1_0 == "5" then
		local var_1_4 = FightHelper.getEntity(arg_1_1.fromId)

		var_1_1 = FightHelper.getAllSideEntitys(var_1_4:getSide())

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			if iter_1_1.id == arg_1_1.fromId then
				table.remove(var_1_1, iter_1_0)

				break
			end
		end
	elseif var_1_0 == "6" then
		local var_1_5 = FightHelper.getEntity(arg_1_1.toId)

		var_1_1 = FightHelper.getAllSideEntitys(var_1_5:getSide())

		for iter_1_2, iter_1_3 in ipairs(var_1_1) do
			if iter_1_3.id == arg_1_1.toId then
				table.remove(var_1_1, iter_1_2)

				if FightHelper.isAssembledMonster(iter_1_3) then
					for iter_1_4 = #var_1_1, 1, -1 do
						if FightHelper.isAssembledMonster(var_1_1[iter_1_4]) then
							table.remove(var_1_1, iter_1_4)
						end
					end
				end

				break
			end
		end
	end

	if not string.nilorempty(arg_1_3[4]) then
		local var_1_6 = arg_1_0:com_sendMsg(FightMsgId.GetDeadEntityMgr)

		var_1_1 = {}

		local var_1_7 = string.splitToNumber(arg_1_3[4], "#")

		for iter_1_5, iter_1_6 in pairs(var_1_6.entityDic) do
			local var_1_8 = iter_1_6:getMO()

			if var_1_8 and tabletool.indexOf(var_1_7, var_1_8.skin) then
				table.insert(var_1_1, iter_1_6)
			end
		end
	end

	local var_1_9 = string.splitToNumber(arg_1_3[2], "#")
	local var_1_10 = arg_1_3[3] == "1"

	if #var_1_1 > 0 then
		for iter_1_7, iter_1_8 in ipairs(var_1_1) do
			local var_1_11 = iter_1_8.spine
			local var_1_12 = var_1_11 and var_1_11:getSpineTr()

			if var_1_12 then
				if var_1_10 then
					transformhelper.setLocalPos(var_1_12, 0, 0, 0)
					FightController.instance:dispatchEvent(FightEvent.SetSpinePosByTimeline, iter_1_8.id, 0, 0, 0)
				else
					transformhelper.setLocalPos(var_1_12, var_1_9[1] or 0, var_1_9[2] or 0, var_1_9[3] or 0)
					FightController.instance:dispatchEvent(FightEvent.SetSpinePosByTimeline, iter_1_8.id, var_1_9[1] or 0, var_1_9[2] or 0, var_1_9[3] or 0)
				end
			end
		end
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

return var_0_0
