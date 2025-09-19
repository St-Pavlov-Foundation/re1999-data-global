module("modules.logic.fight.entity.comp.skill.FightTLEventAtkFullEffect", package.seeall)

local var_0_0 = class("FightTLEventAtkFullEffect", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not FightHelper.detectTimelinePlayEffectCondition(arg_1_1, arg_1_3[4]) then
		return
	end

	arg_1_0._attacker = FightHelper.getEntity(arg_1_1.fromId)

	if not arg_1_0._attacker then
		return
	end

	if not string.nilorempty(arg_1_3[10]) then
		arg_1_0._attacker.effect:_onInvokeTokenRelease(arg_1_3[10])

		return
	end

	local var_1_0 = arg_1_3[1]
	local var_1_1 = 0
	local var_1_2 = 0
	local var_1_3 = 0

	if arg_1_3[2] then
		local var_1_4 = string.split(arg_1_3[2], ",")

		var_1_1 = var_1_4[1] and tonumber(var_1_4[1]) or var_1_1

		if not arg_1_0._attacker:isMySide() and arg_1_3[5] ~= "1" then
			var_1_1 = -var_1_1
		end

		var_1_2 = var_1_4[2] and tonumber(var_1_4[2]) or var_1_2
		var_1_3 = var_1_4[3] and tonumber(var_1_4[3]) or var_1_3
	end

	if not string.nilorempty(arg_1_3[6]) then
		local var_1_5 = GameUtil.splitString2(arg_1_3[6], true)
		local var_1_6 = GameSceneMgr.instance:getCurScene():getCurLevelId()
		local var_1_7 = FightHelper.getEntityStanceId(arg_1_0._attacker:getMO())

		for iter_1_0, iter_1_1 in ipairs(var_1_5) do
			if var_1_6 == iter_1_1[1] and var_1_7 == iter_1_1[2] then
				var_1_1 = var_1_1 + iter_1_1[3] or 0
				var_1_2 = var_1_2 + iter_1_1[4] or 0
				var_1_3 = var_1_3 + iter_1_1[5] or 0
			end
		end
	end

	if not string.nilorempty(arg_1_3[7]) then
		local var_1_8 = arg_1_0._attacker:getSide() == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
		local var_1_9 = FightDataHelper.entityMgr:getNormalList(var_1_8)[1]

		if var_1_9 then
			local var_1_10 = GameUtil.splitString2(arg_1_3[7], true)
			local var_1_11 = GameSceneMgr.instance:getCurScene():getCurLevelId()
			local var_1_12 = FightHelper.getEntityStanceId(var_1_9)

			for iter_1_2, iter_1_3 in ipairs(var_1_10) do
				if var_1_11 == iter_1_3[1] and var_1_12 == iter_1_3[2] then
					var_1_1 = var_1_1 + iter_1_3[3] or 0
					var_1_2 = var_1_2 + iter_1_3[4] or 0
					var_1_3 = var_1_3 + iter_1_3[5] or 0
				end
			end
		end
	end

	if string.nilorempty(var_1_0) then
		logError("atk effect name is nil")
	else
		arg_1_0._releaseTime = nil

		if not string.nilorempty(arg_1_3[11]) and arg_1_3[11] ~= "0" then
			arg_1_0._releaseTime = tonumber(arg_1_3[11]) / FightModel.instance:getSpeed()
		end

		arg_1_0._effectWrap = arg_1_0._attacker.effect:addGlobalEffect(var_1_0, nil, arg_1_0._releaseTime)

		local var_1_13 = true

		if arg_1_3[13] == "1" then
			local var_1_14 = CameraMgr.instance:getMainCameraGO()

			gohelper.addChild(var_1_14, arg_1_0._effectWrap.containerGO)

			var_1_13 = false
		end

		local var_1_15 = tonumber(arg_1_3[3]) or -1

		if var_1_15 == -1 then
			FightRenderOrderMgr.instance:onAddEffectWrap(arg_1_0._attacker.id, arg_1_0._effectWrap)
		else
			FightRenderOrderMgr.instance:setEffectOrder(arg_1_0._effectWrap, var_1_15)
		end

		if var_1_13 then
			arg_1_0._effectWrap:setWorldPos(var_1_1, var_1_2, var_1_3)
		else
			arg_1_0._effectWrap:setLocalPos(var_1_1, var_1_2, var_1_3)
		end

		arg_1_0._releaseByServer = tonumber(arg_1_3[8])

		if arg_1_0._releaseByServer then
			arg_1_0._attacker.effect:addServerRelease(arg_1_0._releaseByServer, arg_1_0._effectWrap)
		end

		arg_1_0._tokenRelease = not string.nilorempty(arg_1_3[9])

		if arg_1_0._tokenRelease then
			arg_1_0._attacker.effect:addTokenRelease(arg_1_3[9], arg_1_0._effectWrap)
		end

		arg_1_0._roundRelease = not string.nilorempty(arg_1_3[12])

		if arg_1_0._roundRelease then
			arg_1_0._attacker.effect:addRoundRelease(tonumber(arg_1_3[12]), arg_1_0._effectWrap)
		end
	end

	local var_1_16 = tonumber(arg_1_3[14])

	if var_1_16 then
		AudioMgr.instance:trigger(var_1_16)
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:_removeEffect()
end

function var_0_0.onDestructor(arg_3_0)
	arg_3_0:_removeEffect()
end

function var_0_0._removeEffect(arg_4_0)
	local var_4_0 = true

	if arg_4_0._releaseByServer then
		var_4_0 = false
	end

	if arg_4_0._tokenRelease then
		var_4_0 = false
	end

	if arg_4_0._releaseTime then
		var_4_0 = false
	end

	if arg_4_0._roundRelease then
		var_4_0 = false
	end

	if var_4_0 and arg_4_0._effectWrap then
		arg_4_0._attacker.effect:removeEffect(arg_4_0._effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_4_0._attacker.id, arg_4_0._effectWrap)
	end

	arg_4_0._effectWrap = nil
	arg_4_0._attacker = nil
end

return var_0_0
