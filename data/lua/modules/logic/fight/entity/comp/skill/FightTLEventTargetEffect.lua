module("modules.logic.fight.entity.comp.skill.FightTLEventTargetEffect", package.seeall)

local var_0_0 = class("FightTLEventTargetEffect", FightTimelineTrackItem)
local var_0_1 = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.FIGHTSTEP] = true
}

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.paramsArr = arg_1_3
	arg_1_0.fightStepData = arg_1_1
	arg_1_0._delayReleaseEffect = not string.nilorempty(arg_1_3[8]) and tonumber(arg_1_3[8])

	if arg_1_0._delayReleaseEffect then
		arg_1_0._delayReleaseEffect = arg_1_0._delayReleaseEffect / FightModel.instance:getSpeed()
	end

	local var_1_0 = arg_1_3[1]

	if string.nilorempty(var_1_0) then
		logError("目标特效名称不能为空")

		return
	end

	arg_1_0._tokenRelease = not string.nilorempty(arg_1_0.paramsArr[12])

	local var_1_1 = arg_1_3[2]
	local var_1_2 = arg_1_3[3]
	local var_1_3 = 0
	local var_1_4 = 0
	local var_1_5 = 0

	if arg_1_3[4] then
		local var_1_6 = string.split(arg_1_3[4], ",")

		var_1_3 = var_1_6[1] and tonumber(var_1_6[1]) or var_1_3
		var_1_4 = var_1_6[2] and tonumber(var_1_6[2]) or var_1_4
		var_1_5 = var_1_6[3] and tonumber(var_1_6[3]) or var_1_5
	end

	local var_1_7 = tonumber(arg_1_3[5]) or -1
	local var_1_8 = {}

	if string.nilorempty(arg_1_3[6]) or arg_1_3[6] == "1" then
		local var_1_9 = FightHelper.getEntity(arg_1_1.toId)

		if var_1_9 then
			table.insert(var_1_8, var_1_9)
		end
	elseif not string.nilorempty(arg_1_3[9]) then
		local var_1_10 = string.splitToNumber(arg_1_3[9], "#")
		local var_1_11 = {}

		for iter_1_0, iter_1_1 in ipairs(var_1_10) do
			var_1_11[iter_1_1] = iter_1_1
		end

		for iter_1_2, iter_1_3 in ipairs(arg_1_1.actEffect) do
			if var_1_11[iter_1_3.effectType] then
				local var_1_12 = FightHelper.getEntity(iter_1_3.targetId)

				if var_1_12 then
					local var_1_13 = FightHelper.getEntity(arg_1_0.fightStepData.fromId)
					local var_1_14 = false

					if arg_1_3[6] == "2" then
						var_1_14 = true
					elseif arg_1_3[6] == "3" then
						var_1_14 = var_1_12:getSide() == var_1_13:getSide()
					elseif arg_1_3[6] == "4" then
						var_1_14 = var_1_12:getSide() ~= var_1_13:getSide()
					end

					if var_1_14 and not tabletool.indexOf(var_1_8, var_1_12) then
						table.insert(var_1_8, var_1_12)
					end
				end
			end
		end
	else
		for iter_1_4, iter_1_5 in ipairs(arg_1_1.actEffect) do
			local var_1_15 = false
			local var_1_16 = iter_1_5

			if var_1_16.effectType == FightEnum.EffectType.SHIELD and not FightHelper.checkShieldHit(var_1_16) then
				var_1_15 = true
			end

			if not var_1_15 and not var_0_1[iter_1_5.effectType] then
				local var_1_17 = FightHelper.getEntity(iter_1_5.targetId)

				if var_1_17 then
					local var_1_18 = FightHelper.getEntity(arg_1_0.fightStepData.fromId)
					local var_1_19 = false

					if arg_1_3[6] == "2" then
						var_1_19 = true
					elseif arg_1_3[6] == "3" then
						var_1_19 = var_1_17:getSide() == var_1_18:getSide()
					elseif arg_1_3[6] == "4" then
						var_1_19 = var_1_17:getSide() ~= var_1_18:getSide()
					end

					if var_1_19 and not tabletool.indexOf(var_1_8, var_1_17) then
						table.insert(var_1_8, var_1_17)
					end
				end
			end
		end
	end

	if not string.nilorempty(arg_1_3[7]) then
		var_1_8 = {}

		local var_1_20 = arg_1_0:com_sendMsg(FightMsgId.GetDeadEntityMgr)
		local var_1_21 = string.splitToNumber(arg_1_3[7], "#")

		for iter_1_6, iter_1_7 in pairs(var_1_20.entityDic) do
			local var_1_22 = iter_1_7:getMO()

			if var_1_22 and tabletool.indexOf(var_1_21, var_1_22.skin) then
				table.insert(var_1_8, iter_1_7)
			end
		end
	end

	local var_1_23 = arg_1_3[13]

	var_1_23 = not string.nilorempty(var_1_23) and var_1_23

	if var_1_23 then
		for iter_1_8, iter_1_9 in ipairs(var_1_8) do
			iter_1_9.effect:_onInvokeTokenRelease(var_1_23)
		end

		return
	end

	if #var_1_8 > 0 then
		arg_1_0._effectWrapDict = {}

		local var_1_24 = tonumber(arg_1_3[10])

		for iter_1_10, iter_1_11 in ipairs(var_1_8) do
			local var_1_25 = arg_1_0:_createEffect(iter_1_11, var_1_0, var_1_1, var_1_2, var_1_3, var_1_4, var_1_5)

			arg_1_0:_setRenderOrder(iter_1_11.id, var_1_25, var_1_7)

			arg_1_0._effectWrapDict[iter_1_11] = var_1_25

			if var_1_24 then
				AudioMgr.instance:trigger(var_1_24)
			end
		end
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:_removeEffect()
end

function var_0_0._createEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	local var_3_0 = FightHelper.getEntity(arg_3_0.fightStepData.fromId)
	local var_3_1

	if not string.nilorempty(arg_3_3) then
		var_3_1 = arg_3_1.effect:addHangEffect(arg_3_2, arg_3_3, var_3_0:getSide(), arg_3_0._delayReleaseEffect)

		var_3_1:setLocalPos(arg_3_5, arg_3_6, arg_3_7)

		local var_3_2 = tonumber(arg_3_0.paramsArr[11])

		if var_3_2 then
			local var_3_3 = var_3_1.containerTr

			if var_3_3 then
				local var_3_4, var_3_5, var_3_6 = transformhelper.getPos(var_3_3)

				var_3_1:setWorldPos(var_3_4, var_3_2, var_3_6)
			end
		end
	else
		var_3_1 = arg_3_1.effect:addGlobalEffect(arg_3_2, var_3_0:getSide(), arg_3_0._delayReleaseEffect)

		local var_3_7
		local var_3_8
		local var_3_9

		if arg_3_4 == "0" then
			var_3_7, var_3_8, var_3_9 = FightHelper.getEntityWorldBottomPos(arg_3_1)
		elseif arg_3_4 == "1" then
			var_3_7, var_3_8, var_3_9 = FightHelper.getEntityWorldCenterPos(arg_3_1)
		elseif arg_3_4 == "2" then
			var_3_7, var_3_8, var_3_9 = FightHelper.getEntityWorldTopPos(arg_3_1)
		elseif arg_3_4 == "3" then
			var_3_7, var_3_8, var_3_9 = FightHelper.getProcessEntitySpinePos(arg_3_1)
		else
			local var_3_10 = not string.nilorempty(arg_3_4) and arg_3_1:getHangPoint(arg_3_4)

			if var_3_10 then
				local var_3_11 = var_3_10.transform.position

				var_3_7, var_3_8, var_3_9 = var_3_11.x, var_3_11.y, var_3_11.z
			else
				var_3_7, var_3_8, var_3_9 = FightHelper.getEntityWorldCenterPos(arg_3_1)
			end
		end

		local var_3_12 = arg_3_1:isMySide() and -arg_3_5 or arg_3_5

		var_3_1:setWorldPos(var_3_7 + var_3_12, var_3_8 + arg_3_6, var_3_9 + arg_3_7)

		local var_3_13 = tonumber(arg_3_0.paramsArr[11])

		if var_3_13 then
			local var_3_14 = var_3_1.containerTr

			if var_3_14 then
				local var_3_15, var_3_16, var_3_17 = transformhelper.getPos(var_3_14)

				var_3_1:setWorldPos(var_3_15, var_3_13, var_3_17)
			end
		end
	end

	if arg_3_0._tokenRelease then
		arg_3_1.effect:addTokenRelease(arg_3_0.paramsArr[12], var_3_1)
	end

	return var_3_1
end

function var_0_0._setRenderOrder(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 == -1 then
		FightRenderOrderMgr.instance:onAddEffectWrap(arg_4_1, arg_4_2)
	else
		FightRenderOrderMgr.instance:setEffectOrder(arg_4_2, arg_4_3)
	end
end

function var_0_0.onDestructor(arg_5_0)
	arg_5_0:_removeEffect()
end

function var_0_0._removeEffect(arg_6_0)
	if arg_6_0._effectWrapDict and not arg_6_0._delayReleaseEffect and not arg_6_0._tokenRelease then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._effectWrapDict) do
			FightRenderOrderMgr.instance:onRemoveEffectWrap(iter_6_0.id, iter_6_1)
			iter_6_0.effect:removeEffect(iter_6_1)
		end
	end

	arg_6_0._effectWrapDict = nil
end

return var_0_0
