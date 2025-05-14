module("modules.logic.fight.entity.comp.skill.FightTLEventCreateSpine", package.seeall)

local var_0_0 = class("FightTLEventCreateSpine")

function var_0_0.ctor(arg_1_0)
	arg_1_0._spineGO = nil
end

function var_0_0.getSkinSpineName(arg_2_0, arg_2_1)
	if string.nilorempty(arg_2_0) or arg_2_1 == 0 then
		return arg_2_0
	end

	local var_2_0 = string.split(arg_2_0, "#")
	local var_2_1 = var_2_0[1]

	if not (var_2_0[2] and var_2_0[2] == "1") then
		return var_2_1
	end

	if string.find(var_2_1, "%[") then
		var_2_1 = string.gsub(var_2_1, "%[%d-%]", arg_2_1)
	end

	local var_2_2 = lua_skin.configDict[arg_2_1]

	if var_2_2 and not string.nilorempty(var_2_2.spine) then
		local var_2_3 = string.split(var_2_2.spine, "_")
		local var_2_4 = string.split(var_2_1, "_")

		var_2_4[1] = var_2_3[1]

		return table.concat(var_2_4, "_")
	end

	return var_2_1
end

function var_0_0.handleSkillEvent(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._paramsArr = arg_3_3
	arg_3_0._attacker = FightHelper.getEntity(arg_3_1.fromId)

	local var_3_0 = string.split(arg_3_3[1], "#")
	local var_3_1 = arg_3_0._attacker:getMO()
	local var_3_2 = var_3_1 and var_3_1:getSpineSkinCO()

	arg_3_0._skinId = var_3_2 and var_3_2.id or 0

	local var_3_3 = var_3_2 and var_0_0.getSkinSpineName(arg_3_3[1], arg_3_0._skinId) or arg_3_3[1]
	local var_3_4 = arg_3_3[2]
	local var_3_5 = 0
	local var_3_6 = 0
	local var_3_7 = 0

	if not string.nilorempty(arg_3_3[3]) then
		local var_3_8 = string.splitToNumber(arg_3_3[3], ",")

		var_3_5 = var_3_8[1] or var_3_5
		var_3_6 = var_3_8[2] or var_3_6
		var_3_7 = var_3_8[3] or var_3_7
	end

	local var_3_9 = tonumber(arg_3_3[4]) or -1
	local var_3_10 = tonumber(arg_3_3[5]) or 1
	local var_3_11 = arg_3_1.stepUid .. "_" .. (string.nilorempty(arg_3_3[6]) and var_3_3 or arg_3_3[6])
	local var_3_12 = tonumber(arg_3_3[7]) or 1
	local var_3_13 = tonumber(arg_3_3[8]) or 0

	if not arg_3_0._attacker:isMySide() and arg_3_3[9] ~= "4" then
		var_3_5 = -var_3_5
	end

	local var_3_14 = arg_3_0:_getHangPointGO(arg_3_1, var_3_12)
	local var_3_15 = 0

	if var_3_9 == -1 then
		var_3_15 = (FightRenderOrderMgr.instance:getOrder(arg_3_1.fromId) or 0) / FightEnum.OrderRegion * FightEnum.OrderRegion
		var_3_15 = var_3_15 + 1
	elseif var_3_9 == -2 then
		var_3_15 = (FightRenderOrderMgr.instance:getOrder(arg_3_1.toId) or 0) / FightEnum.OrderRegion * FightEnum.OrderRegion
		var_3_15 = var_3_15 + (tonumber(arg_3_3[13]) or 0)
	else
		var_3_15 = var_3_9 * FightEnum.OrderRegion
	end

	local var_3_16 = {}

	if arg_3_3[10] == "1" then
		var_3_16 = FightHelper.getDefenders(arg_3_1, true)
	else
		table.insert(var_3_16, FightHelper.getEntity(arg_3_1.toId))
	end

	arg_3_0._spineEntityList = {}

	local var_3_17 = arg_3_3[10] == "1" and #var_3_16 or 1

	for iter_3_0 = 1, var_3_17 do
		local var_3_18 = var_3_16[iter_3_0]
		local var_3_19 = 0
		local var_3_20 = 0
		local var_3_21 = 0

		if arg_3_3[9] == "1" then
			if var_3_12 == 1 then
				var_3_19, var_3_20, var_3_21 = transformhelper.getLocalPos(arg_3_0._attacker.go.transform)
			else
				var_3_19, var_3_20, var_3_21 = transformhelper.getPos(arg_3_0._attacker.go.transform)
			end
		elseif arg_3_3[9] == "2" and var_3_18 then
			if var_3_12 == 1 then
				var_3_19, var_3_20, var_3_21 = transformhelper.getLocalPos(var_3_18.go.transform)
			else
				var_3_19, var_3_20, var_3_21 = transformhelper.getPos(var_3_18.go.transform)
			end
		end

		local var_3_22 = var_3_5 + var_3_19
		local var_3_23 = var_3_6 + var_3_20
		local var_3_24 = var_3_7 + var_3_21
		local var_3_25 = arg_3_3[10] == "1" and var_3_11 .. "_multi_" .. iter_3_0 or var_3_11

		arg_3_0:_createSpine(var_3_3, var_3_25, var_3_13, var_3_10, var_3_22, var_3_23, var_3_24, var_3_14, var_3_15, var_3_4)
	end

	arg_3_0:_setupEntityLookAt(arg_3_3[11])
end

function var_0_0.handleSkillEventEnd(arg_4_0)
	arg_4_0:_clear()
end

function var_0_0._setupEntityLookAt(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1 == "1" then
		TaskDispatcher.runRepeat(arg_5_0._onTickLookAtCamera, arg_5_0, 0.01)
	end
end

function var_0_0._onTickLookAtCamera(arg_6_0)
	local var_6_0 = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._spineEntityList) do
		var_6_0:adjustSpineLookRotation(iter_6_1)
	end
end

function var_0_0._createSpine(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7, arg_7_8, arg_7_9, arg_7_10)
	local var_7_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_7_1 = arg_7_0._attacker:getSide()
	local var_7_2 = var_7_0:buildTempSpineByName(arg_7_1, arg_7_2, var_7_1, arg_7_3 == 1)

	var_7_2.variantHeart:setEntity(arg_7_0._attacker)
	var_7_2:setScale(arg_7_4)

	if arg_7_8 then
		gohelper.addChild(arg_7_8, var_7_2.go)
	end

	if arg_7_0._paramsArr[7] == "3" or arg_7_0._paramsArr[7] == "4" then
		transformhelper.setPos(var_7_2.go.transform, arg_7_5, arg_7_6, arg_7_7)
	else
		transformhelper.setLocalPos(var_7_2.go.transform, arg_7_5, arg_7_6, arg_7_7)
	end

	var_7_2:setRenderOrder(arg_7_9)

	if not string.nilorempty(arg_7_10) then
		var_7_2.spine:play(arg_7_10)

		if arg_7_0._attacker and arg_7_0._attacker.skill and arg_7_0._attacker.skill:sameSkillPlaying() and not string.nilorempty(arg_7_0._paramsArr[12]) then
			var_7_2.spine._skeletonAnim:Jump2Time(tonumber(arg_7_0._paramsArr[12]))
		end
	end

	if arg_7_0._paramsArr[14] == "1" then
		FightController.instance:dispatchEvent(FightEvent.EntrustTempEntity, var_7_2)
	end

	if not string.nilorempty(arg_7_0._paramsArr[15]) then
		GameSceneMgr.instance:getCurScene().entityMgr:removeUnitData(var_7_2:getTag(), var_7_2.id)
		FightMsgMgr.sendMsg(FightMsgId.SetBossEvolution, var_7_2, tonumber(arg_7_0._paramsArr[15]))
		FightController.instance:dispatchEvent(FightEvent.SetBossEvolution, var_7_2, tonumber(arg_7_0._paramsArr[15]))
	end

	table.insert(arg_7_0._spineEntityList, var_7_2)
end

function var_0_0._getHangPointGO(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == 2 then
		return CameraMgr.instance:getCameraTraceGO()
	elseif arg_8_2 == 3 then
		local var_8_0 = FightHelper.getEntity(arg_8_1.fromId)

		return var_8_0 and var_8_0.go
	elseif arg_8_2 == 4 then
		local var_8_1 = FightHelper.getEntity(arg_8_1.toId)

		return var_8_1 and var_8_1.go
	end
end

function var_0_0.reset(arg_9_0)
	arg_9_0:_clear()
end

function var_0_0.dispose(arg_10_0)
	arg_10_0:_clear()
end

function var_0_0._clear(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._onTickLookAtCamera, arg_11_0)

	if arg_11_0._spineEntityList then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._spineEntityList) do
			local var_11_0 = GameSceneMgr.instance:getCurScene().entityMgr
			local var_11_1 = true

			if arg_11_0._paramsArr[14] == "1" then
				var_11_1 = false
			end

			if not string.nilorempty(arg_11_0._paramsArr[15]) then
				var_11_1 = false
			end

			if var_11_1 then
				var_11_0:removeUnit(iter_11_1:getTag(), iter_11_1.id)
			end

			iter_11_1 = nil
		end
	end

	arg_11_0._spineEntityList = nil
end

return var_0_0
