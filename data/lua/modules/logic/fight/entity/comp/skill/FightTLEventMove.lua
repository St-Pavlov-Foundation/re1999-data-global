module("modules.logic.fight.entity.comp.skill.FightTLEventMove", package.seeall)

local var_0_0 = class("FightTLEventMove", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_2 = arg_1_2 * FightModel.instance:getSpeed()
	arg_1_0._paramsArr = arg_1_3

	local var_1_0 = arg_1_3[1]
	local var_1_1 = tonumber(arg_1_3[2]) or 0
	local var_1_2 = tonumber(arg_1_3[3]) or 0
	local var_1_3 = GameUtil.splitString2(arg_1_3[4], true, "#", ",")
	local var_1_4 = arg_1_3[5]

	if arg_1_3[6] == "1" then
		arg_1_2 = 0
	end

	local var_1_5 = var_0_0._getMoveEntitys(arg_1_1, var_1_0)

	if #var_1_5 > 0 then
		local var_1_6 = false

		if var_1_0 == "2" or var_1_0 == "4" then
			for iter_1_0, iter_1_1 in ipairs(var_1_5) do
				local var_1_7 = iter_1_1:getMO()

				if var_1_7 then
					local var_1_8 = FightConfig.instance:getSkinCO(var_1_7.skin)

					if var_1_8 and var_1_8.canHide == 1 then
						var_1_6 = true
					end
				end
			end
		end

		if var_1_6 then
			arg_1_0._combinative_entitys = {}
			arg_1_0._combinative_pos_offsets = {}

			for iter_1_2, iter_1_3 in ipairs(FightHelper.getSideEntitys(var_1_5[1]:getSide())) do
				local var_1_9 = iter_1_3:getMO()

				if var_1_9 then
					local var_1_10 = FightConfig.instance:getSkinCO(var_1_9.skin)

					if var_1_10 and var_1_10.mainBody == 1 then
						arg_1_0._follow_entity = iter_1_3
					else
						table.insert(arg_1_0._combinative_entitys, iter_1_3)
					end
				end
			end

			if not arg_1_0._follow_entity then
				arg_1_0._follow_entity = FightHelper.getEntity(arg_1_1.toId)

				tabletool.removeValue(arg_1_0._combinative_entitys, arg_1_0._follow_entity)
			end

			local var_1_11, var_1_12, var_1_13 = FightHelper.getEntityStandPos(arg_1_0._follow_entity:getMO())
			local var_1_14 = Vector3.New(var_1_11, var_1_12, var_1_13)

			for iter_1_4, iter_1_5 in ipairs(arg_1_0._combinative_entitys) do
				local var_1_15, var_1_16, var_1_17 = FightHelper.getEntityStandPos(iter_1_5:getMO())
				local var_1_18 = Vector3.New(var_1_15, var_1_16, var_1_17)

				table.insert(arg_1_0._combinative_pos_offsets, var_1_18 - var_1_14)
			end

			var_1_5 = {
				arg_1_0._follow_entity
			}

			TaskDispatcher.runRepeat(arg_1_0._setCombinativeEntitysPos, arg_1_0, 0.0001)
		end
	end

	if #var_1_5 > 1 then
		table.sort(var_1_5, function(arg_2_0, arg_2_1)
			if arg_2_0:getSide() ~= arg_2_1:getSide() then
				return arg_2_0:isMySide()
			end

			local var_2_0 = arg_2_0:getMO()
			local var_2_1 = arg_2_1:getMO()

			if var_2_0 and var_2_1 and var_2_0.position ~= var_2_1.position then
				return var_2_0.position < var_2_1.position
			end

			return tonumber(arg_2_0.id) > tonumber(arg_2_1.id)
		end)
	end

	local var_1_19

	if not string.nilorempty(arg_1_0._paramsArr[8]) and #var_1_5 == 1 then
		local var_1_20 = var_1_5[1]
		local var_1_21 = FightStrUtil.instance:getSplitCache(arg_1_0._paramsArr[8], "|")

		if #var_1_21 > 1 then
			local var_1_22 = false

			for iter_1_6 = 2, #var_1_21 do
				local var_1_23 = FightStrUtil.instance:getSplitCache(var_1_21[iter_1_6], "_")
				local var_1_24 = var_1_20:getMO()

				if var_1_24 and var_1_24.skin == tonumber(var_1_23[1]) then
					var_1_19 = FightStrUtil.instance:getSplitToNumberCache(var_1_23[2], ",")
					var_1_22 = true

					break
				end
			end

			if not var_1_22 then
				var_1_19 = FightStrUtil.instance:getSplitToNumberCache(var_1_21[1], ",")
			end
		else
			var_1_19 = FightStrUtil.instance:getSplitToNumberCache(arg_1_0._paramsArr[8], ",")
		end
	end

	for iter_1_7, iter_1_8 in ipairs(var_1_5) do
		if not gohelper.isNil(iter_1_8.go) then
			local var_1_25, var_1_26, var_1_27 = transformhelper.getPos(iter_1_8.go.transform)
			local var_1_28, var_1_29, var_1_30 = arg_1_0:_getEndPosXYZ(arg_1_1, iter_1_8, var_1_3, var_1_0, var_1_1, iter_1_7)

			if var_1_19 then
				var_1_28 = var_1_19[1] and (iter_1_8:isMySide() and var_1_19[1] or -var_1_19[1]) or 0
				var_1_29 = var_1_19[2] or 0
				var_1_30 = var_1_19[3] or 0
			end

			var_0_0._setupEntityMove(iter_1_8, var_1_25, var_1_26, var_1_27, var_1_28, var_1_29, var_1_30, arg_1_2, var_1_2, var_1_4)
		end
	end
end

function var_0_0._getEndPosXYZ(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	local var_3_0 = FightHelper.getEntity(arg_3_1.fromId)
	local var_3_1 = FightHelper.getEntity(arg_3_1.toId)
	local var_3_2 = arg_3_3[1]

	if arg_3_4 == "3" or arg_3_4 == "4" then
		var_3_2 = arg_3_3[arg_3_2:getMO().position]
	elseif arg_3_4 == "2" then
		var_3_2 = arg_3_3[arg_3_6]
	end

	local var_3_3 = var_3_2 and var_3_2[1] or 0
	local var_3_4 = var_3_2 and var_3_2[2] or 0
	local var_3_5 = var_3_2 and var_3_2[3] or 0
	local var_3_6 = 0
	local var_3_7 = 0
	local var_3_8 = 0

	if arg_3_5 == 3 then
		local var_3_9 = arg_3_2:getMO()

		if var_3_9 then
			var_3_6, var_3_7, var_3_8 = FightHelper.getEntityStandPos(var_3_9)
		else
			var_3_6, var_3_7, var_3_8 = 0, 0, 0
		end
	elseif arg_3_5 == 1 or arg_3_5 == 2 then
		local var_3_10 = arg_3_5 == 1 and var_3_0 or var_3_1

		if var_3_10 then
			var_3_6, var_3_7, var_3_8 = FightHelper.getProcessEntityStancePos(var_3_10:getMO())
			var_3_6 = var_3_10:isMySide() and var_3_6 - var_3_3 or var_3_6 + var_3_3
			var_3_7 = var_3_7 + var_3_4
			var_3_8 = var_3_8 + var_3_5
		else
			logNormal("targetEntity not exist: " .. (arg_3_5 == 1 and arg_3_1.fromId or arg_3_1.toId))
		end
	elseif arg_3_5 == 0 then
		var_3_6 = tonumber(arg_3_4) and arg_3_2:isMySide() and var_3_6 - var_3_3 or var_3_6 + var_3_3
		var_3_7 = var_3_4
		var_3_8 = var_3_5
	elseif arg_3_5 == 4 then
		var_3_6 = var_3_3
		var_3_7 = var_3_4
		var_3_8 = var_3_5
	elseif arg_3_5 == 5 then
		local var_3_11
		local var_3_12 = FightStrUtil.instance:getSplitCache(arg_3_0._paramsArr[7], "|")

		if #var_3_12 > 1 then
			local var_3_13 = false

			for iter_3_0 = 2, #var_3_12 do
				local var_3_14 = FightStrUtil.instance:getSplitCache(var_3_12[iter_3_0], "_")
				local var_3_15 = arg_3_2:getMO()

				if var_3_15 and var_3_15.skin == tonumber(var_3_14[1]) then
					var_3_11 = FightStrUtil.instance:getSplitToNumberCache(var_3_14[2], ",")
					var_3_13 = true

					break
				end
			end

			if not var_3_13 then
				var_3_11 = FightStrUtil.instance:getSplitToNumberCache(var_3_12[1], ",")
			end
		else
			var_3_11 = FightStrUtil.instance:getSplitToNumberCache(arg_3_0._paramsArr[7], ",")
		end

		local var_3_16, var_3_17, var_3_18 = transformhelper.getPos(arg_3_2.go.transform)
		local var_3_19 = arg_3_2:isMySide()

		var_3_6 = var_3_16 + (var_3_11[1] and (var_3_19 and var_3_11[1] or -var_3_11[1]) or 0)
		var_3_7 = var_3_17 + (var_3_11[2] or 0)
		var_3_8 = var_3_18 + (var_3_11[3] or 0)
	end

	return var_3_6, var_3_7, var_3_8
end

function var_0_0._getMoveEntitys(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = FightHelper.getEntity(arg_4_0.fromId)
	local var_4_2 = FightHelper.getEntity(arg_4_0.toId)

	if arg_4_1 == "1" then
		table.insert(var_4_0, var_4_1)
	elseif arg_4_1 == "2" then
		local var_4_3 = {}

		for iter_4_0, iter_4_1 in ipairs(arg_4_0.actEffect) do
			local var_4_4 = FightHelper.getEntity(iter_4_1.targetId)

			if not var_4_4 and iter_4_1.effectType ~= FightEnum.EffectType.INDICATORCHANGE then
				-- block empty
			end

			local var_4_5 = false

			if var_4_4 and (var_4_4.id == FightEntityScene.MySideId or var_4_4.id == FightEntityScene.EnemySideId) then
				var_4_5 = true
			end

			if not var_4_5 and var_4_4 and var_4_4:getSide() ~= var_4_1:getSide() and not var_4_3[iter_4_1.targetId] then
				table.insert(var_4_0, var_4_4)

				var_4_3[iter_4_1.targetId] = true
			end
		end
	elseif arg_4_1 == "3" then
		var_4_0 = FightHelper.getSideEntitys(var_4_1:getSide(), false)
	elseif arg_4_1 == "4" then
		if var_4_2 then
			var_4_0 = FightHelper.getSideEntitys(var_4_2:getSide(), false)
		end
	elseif arg_4_1 == "5" then
		local var_4_6 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)
		local var_4_7 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)

		tabletool.addValues(var_4_0, var_4_6)
		tabletool.addValues(var_4_0, var_4_7)
	elseif arg_4_1 == "6" then
		if var_4_2 then
			table.insert(var_4_0, var_4_2)
		end
	else
		local var_4_8 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_4_9 = arg_4_0.stepUid .. "_" .. arg_4_1

		table.insert(var_4_0, var_4_8:getUnit(SceneTag.UnitNpc, var_4_9))
	end

	return var_4_0
end

function var_0_0._setupEntityMove(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7, arg_5_8, arg_5_9)
	if arg_5_8 > 0 then
		arg_5_0.parabolaMover:simpleMove(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7, arg_5_8)
	else
		if arg_5_9 and arg_5_0.mover.setEaseType then
			arg_5_0.mover:setEaseType(EaseType.Str2Type(arg_5_9))
		end

		arg_5_0.mover:simpleMove(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	end
end

function var_0_0._setCombinativeEntitysPos(arg_6_0)
	if arg_6_0._combinative_entitys then
		local var_6_0

		for iter_6_0, iter_6_1 in ipairs(arg_6_0._combinative_entitys) do
			local var_6_1 = FightHelper.getEntity(iter_6_1.id)

			if var_6_1 then
				local var_6_2 = var_6_1:getScale()

				if not gohelper.isNil(var_6_1.go) and not gohelper.isNil(arg_6_0._follow_entity.go) then
					var_6_1.go.transform.position = arg_6_0._follow_entity.go.transform.position + arg_6_0._combinative_pos_offsets[iter_6_0] * var_6_2
				end
			end
		end
	end
end

function var_0_0.onTrackEnd(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._setCombinativeEntitysPos, arg_7_0)
end

function var_0_0.reset(arg_8_0)
	arg_8_0._combinative_entitys = nil
end

return var_0_0
