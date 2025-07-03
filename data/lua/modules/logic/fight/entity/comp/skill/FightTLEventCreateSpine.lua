module("modules.logic.fight.entity.comp.skill.FightTLEventCreateSpine", package.seeall)

local var_0_0 = class("FightTLEventCreateSpine", FightTimelineTrackItem)

function var_0_0.getSkinSpineName(arg_1_0, arg_1_1)
	if string.nilorempty(arg_1_0) or arg_1_1 == 0 then
		return arg_1_0
	end

	local var_1_0 = string.split(arg_1_0, "#")
	local var_1_1 = var_1_0[1]

	if not (var_1_0[2] and var_1_0[2] == "1") then
		return var_1_1
	end

	if string.find(var_1_1, "%[") then
		var_1_1 = string.gsub(var_1_1, "%[%d-%]", arg_1_1)
	end

	local var_1_2 = lua_skin.configDict[arg_1_1]

	if var_1_2 and not string.nilorempty(var_1_2.spine) then
		local var_1_3 = string.split(var_1_2.spine, "_")
		local var_1_4 = string.split(var_1_1, "_")

		var_1_4[1] = var_1_3[1]

		return table.concat(var_1_4, "_")
	end

	return var_1_1
end

function var_0_0.onTrackStart(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._paramsArr = arg_2_3
	arg_2_0._attacker = FightHelper.getEntity(arg_2_1.fromId)

	local var_2_0 = string.split(arg_2_3[1], "#")
	local var_2_1 = arg_2_0._attacker:getMO()
	local var_2_2 = var_2_1 and var_2_1:getSpineSkinCO()

	arg_2_0._skinId = var_2_2 and var_2_2.id or 0

	local var_2_3 = var_2_2 and var_0_0.getSkinSpineName(arg_2_3[1], arg_2_0._skinId) or arg_2_3[1]
	local var_2_4 = arg_2_3[2]
	local var_2_5 = 0
	local var_2_6 = 0
	local var_2_7 = 0

	if not string.nilorempty(arg_2_3[3]) then
		local var_2_8 = string.splitToNumber(arg_2_3[3], ",")

		var_2_5 = var_2_8[1] or var_2_5
		var_2_6 = var_2_8[2] or var_2_6
		var_2_7 = var_2_8[3] or var_2_7
	end

	local var_2_9 = tonumber(arg_2_3[4]) or -1
	local var_2_10 = tonumber(arg_2_3[5]) or 1
	local var_2_11 = arg_2_1.stepUid .. "_" .. (string.nilorempty(arg_2_3[6]) and var_2_3 or arg_2_3[6])
	local var_2_12 = tonumber(arg_2_3[7]) or 1
	local var_2_13 = tonumber(arg_2_3[8]) or 0

	if not arg_2_0._attacker:isMySide() and arg_2_3[9] ~= "4" then
		var_2_5 = -var_2_5
	end

	local var_2_14 = arg_2_0:_getHangPointGO(arg_2_1, var_2_12, arg_2_3)
	local var_2_15 = 0

	if var_2_9 == -1 then
		var_2_15 = (FightRenderOrderMgr.instance:getOrder(arg_2_1.fromId) or 0) / FightEnum.OrderRegion * FightEnum.OrderRegion
		var_2_15 = var_2_15 + 1
	elseif var_2_9 == -2 then
		var_2_15 = (FightRenderOrderMgr.instance:getOrder(arg_2_1.toId) or 0) / FightEnum.OrderRegion * FightEnum.OrderRegion
		var_2_15 = var_2_15 + (tonumber(arg_2_3[13]) or 0)
	else
		var_2_15 = var_2_9 * FightEnum.OrderRegion
	end

	local var_2_16 = {}

	if arg_2_3[10] == "1" then
		var_2_16 = FightHelper.getDefenders(arg_2_1, true)
	else
		table.insert(var_2_16, FightHelper.getEntity(arg_2_1.toId))
	end

	arg_2_0._spineEntityList = {}

	local var_2_17 = arg_2_3[10] == "1" and #var_2_16 or 1

	for iter_2_0 = 1, var_2_17 do
		local var_2_18 = var_2_16[iter_2_0]
		local var_2_19 = 0
		local var_2_20 = 0
		local var_2_21 = 0

		if arg_2_3[9] == "1" then
			if var_2_12 == 1 then
				var_2_19, var_2_20, var_2_21 = transformhelper.getLocalPos(arg_2_0._attacker.go.transform)
			else
				var_2_19, var_2_20, var_2_21 = transformhelper.getPos(arg_2_0._attacker.go.transform)
			end
		elseif arg_2_3[9] == "2" and var_2_18 then
			if var_2_12 == 1 then
				var_2_19, var_2_20, var_2_21 = transformhelper.getLocalPos(var_2_18.go.transform)
			else
				var_2_19, var_2_20, var_2_21 = transformhelper.getPos(var_2_18.go.transform)
			end
		end

		local var_2_22 = var_2_5 + var_2_19
		local var_2_23 = var_2_6 + var_2_20
		local var_2_24 = var_2_7 + var_2_21
		local var_2_25 = arg_2_3[10] == "1" and var_2_11 .. "_multi_" .. iter_2_0 or var_2_11

		arg_2_0:_createSpine(var_2_3, var_2_25, var_2_13, var_2_10, var_2_22, var_2_23, var_2_24, var_2_14, var_2_15, var_2_4)
	end

	arg_2_0:_setupEntityLookAt(arg_2_3[11])
end

function var_0_0.onTrackEnd(arg_3_0)
	arg_3_0:_clear()
end

function var_0_0._setupEntityLookAt(arg_4_0, arg_4_1)
	if arg_4_1 and arg_4_1 == "1" then
		TaskDispatcher.runRepeat(arg_4_0._onTickLookAtCamera, arg_4_0, 0.01)
	end
end

function var_0_0._onTickLookAtCamera(arg_5_0)
	local var_5_0 = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._spineEntityList) do
		var_5_0:adjustSpineLookRotation(iter_5_1)
	end
end

function var_0_0._createSpine(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7, arg_6_8, arg_6_9, arg_6_10)
	local var_6_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_6_1 = arg_6_0._attacker:getSide()
	local var_6_2 = {}

	if arg_6_0._paramsArr[17] == "1" then
		var_6_2 = {
			ingoreRainEffect = true
		}
	end

	local var_6_3 = var_6_0:buildTempSpineByName(arg_6_1, arg_6_2, var_6_1, arg_6_3 == 1, nil, var_6_2)

	var_6_3.variantHeart:setEntity(arg_6_0._attacker)
	var_6_3:setScale(arg_6_4)

	if arg_6_8 then
		gohelper.addChild(arg_6_8, var_6_3.go)
	end

	if arg_6_0._paramsArr[7] == "3" or arg_6_0._paramsArr[7] == "4" then
		transformhelper.setPos(var_6_3.go.transform, arg_6_5, arg_6_6, arg_6_7)
	else
		transformhelper.setLocalPos(var_6_3.go.transform, arg_6_5, arg_6_6, arg_6_7)
	end

	var_6_3:setRenderOrder(arg_6_9)

	if not string.nilorempty(arg_6_10) then
		var_6_3.spine:play(arg_6_10)

		if arg_6_0._attacker and arg_6_0._attacker.skill and arg_6_0._attacker.skill:sameSkillPlaying() and not string.nilorempty(arg_6_0._paramsArr[12]) then
			var_6_3.spine._skeletonAnim:Jump2Time(tonumber(arg_6_0._paramsArr[12]))
		end
	end

	if arg_6_0._paramsArr[14] == "1" then
		FightController.instance:dispatchEvent(FightEvent.EntrustTempEntity, var_6_3)
	end

	if not string.nilorempty(arg_6_0._paramsArr[15]) then
		GameSceneMgr.instance:getCurScene().entityMgr:removeUnitData(var_6_3:getTag(), var_6_3.id)
		FightMsgMgr.sendMsg(FightMsgId.SetBossEvolution, var_6_3, tonumber(arg_6_0._paramsArr[15]))
		FightController.instance:dispatchEvent(FightEvent.SetBossEvolution, var_6_3, tonumber(arg_6_0._paramsArr[15]))
	end

	table.insert(arg_6_0._spineEntityList, var_6_3)
end

function var_0_0._getHangPointGO(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_3[16]

	if not string.nilorempty(var_7_0) then
		local var_7_1 = CameraMgr.instance:getCameraRootGO()
		local var_7_2 = string.split(var_7_0, "#")
		local var_7_3 = var_7_2[arg_7_0._attacker:getSide()] or var_7_2[1]

		if var_7_3 then
			local var_7_4 = gohelper.findChild(var_7_1, var_7_3)

			if var_7_4 then
				return var_7_4
			end
		end
	end

	if arg_7_2 == 2 then
		return CameraMgr.instance:getCameraTraceGO()
	elseif arg_7_2 == 3 then
		local var_7_5 = FightHelper.getEntity(arg_7_1.fromId)

		return var_7_5 and var_7_5.go
	elseif arg_7_2 == 4 then
		local var_7_6 = FightHelper.getEntity(arg_7_1.toId)

		return var_7_6 and var_7_6.go
	end
end

function var_0_0.onDestructor(arg_8_0)
	arg_8_0:_clear()
end

function var_0_0._clear(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onTickLookAtCamera, arg_9_0)

	if arg_9_0._spineEntityList then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._spineEntityList) do
			local var_9_0 = GameSceneMgr.instance:getCurScene().entityMgr
			local var_9_1 = true

			if arg_9_0._paramsArr[14] == "1" then
				var_9_1 = false
			end

			if not string.nilorempty(arg_9_0._paramsArr[15]) then
				var_9_1 = false
			end

			if var_9_1 then
				var_9_0:removeUnit(iter_9_1:getTag(), iter_9_1.id)
			end

			iter_9_1 = nil
		end
	end

	arg_9_0._spineEntityList = nil
end

return var_0_0
