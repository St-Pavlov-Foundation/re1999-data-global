module("modules.logic.fight.entity.comp.FightUnitSpine", package.seeall)

local var_0_0 = class("FightUnitSpine", UnitSpine)

function var_0_0._onResLoaded(arg_1_0, arg_1_1)
	if gohelper.isNil(arg_1_0._gameObj) then
		return
	end

	var_0_0.super._onResLoaded(arg_1_0, arg_1_1)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)
	arg_2_0:reInitDefaultAnimState()
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate, arg_2_0)
	FightController.instance:registerCallback(FightEvent.SkillEditorRefreshBuff, arg_2_0.detectRefreshAct, arg_2_0)
end

function var_0_0.reInitDefaultAnimState(arg_3_0)
	local var_3_0 = arg_3_0.unitSpawn:getMO()

	if not var_3_0 then
		return
	end

	if not var_3_0:isMonster() then
		return
	end

	local var_3_1 = var_3_0:getSpineSkinCO()

	if not var_3_1 then
		return
	end

	local var_3_2 = lua_fight_monster_skin_idle_map.configDict[var_3_1.id]

	if not var_3_2 then
		return
	end

	arg_3_0._defaultAnimState = var_3_2.idleAnimName
end

function var_0_0.play(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	if arg_4_0.lockAct then
		return
	end

	arg_4_1 = arg_4_0:replaceAnimState(arg_4_1)

	if not arg_4_4 then
		arg_4_1 = FightHelper.processEntityActionName(arg_4_0.unitSpawn, arg_4_1, arg_4_5)
	end

	if arg_4_0:_cannotPlay(arg_4_1) then
		arg_4_0:_onAnimCallback(arg_4_1, SpineAnimEvent.ActionComplete)

		return
	end

	if arg_4_0._tran_to_ani == arg_4_1 then
		return
	else
		arg_4_0._tran_to_ani = nil
	end

	local var_4_0, var_4_1 = FightHelper.needPlayTransitionAni(arg_4_0.unitSpawn, arg_4_1)

	if var_4_0 then
		if var_4_1 == "0" then
			arg_4_0:setAnimation(arg_4_1, arg_4_2)

			return
		elseif var_4_1 == "-1" then
			arg_4_0:_onAnimCallback(arg_4_1, SpineAnimEvent.ActionComplete)

			return
		else
			arg_4_0._tran_to_ani = arg_4_1
			arg_4_0._tran_loop = arg_4_2
			arg_4_0._tran_reStart = arg_4_3
			arg_4_0._tran_ani = var_4_1

			arg_4_0:addAnimEventCallback(arg_4_0._onTransitionAnimEvent, arg_4_0)
			var_0_0.super.play(arg_4_0, arg_4_0._tran_ani, false, true)

			return
		end
	end

	arg_4_0._tran_ani = nil

	var_0_0.super.play(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0.replaceAnimState(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.unitSpawn:getMO()

	if not var_5_0 then
		return arg_5_1
	end

	if not var_5_0:isMonster() then
		return arg_5_1
	end

	local var_5_1 = var_5_0:getSpineSkinCO()

	if not var_5_1 then
		return arg_5_1
	end

	local var_5_2 = lua_fight_monster_skin_idle_map.configDict[var_5_1.id]

	if not var_5_2 then
		return arg_5_1
	end

	local var_5_3 = var_5_2[arg_5_1 .. "AnimName"]

	if string.nilorempty(var_5_3) then
		return arg_5_1
	else
		return var_5_3
	end
end

function var_0_0._onTransitionAnimEvent(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 == arg_6_0._tran_ani and arg_6_2 == SpineAnimEvent.ActionComplete then
		arg_6_0:removeAnimEventCallback(arg_6_0._onTransitionAnimEvent, arg_6_0)
		var_0_0.super.play(arg_6_0, arg_6_0._tran_to_ani, arg_6_0._tran_loop, arg_6_0._tran_reStart)

		arg_6_0._tran_to_ani = nil
	end
end

function var_0_0.tryPlay(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0:hasAnimation(arg_7_1) then
		return false
	end

	local var_7_0 = arg_7_0.unitSpawn:getMO():getBuffDic()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_1 = iter_7_1.buffId

		if FightBuffHelper.isStoneBuff(var_7_1) then
			return
		end

		if FightBuffHelper.isDizzyBuff(var_7_1) then
			return
		end

		if FightBuffHelper.isSleepBuff(var_7_1) then
			return
		end

		if FightBuffHelper.isFrozenBuff(var_7_1) then
			return
		end
	end

	arg_7_0:play(arg_7_1, arg_7_2, arg_7_3)

	return true
end

function var_0_0._cannotPlay(arg_8_0, arg_8_1)
	if arg_8_0.unitSpawn.buff then
		local var_8_0 = FightConfig.instance:getRejectActBuffTypeList(arg_8_1)

		if var_8_0 then
			for iter_8_0, iter_8_1 in ipairs(var_8_0) do
				if arg_8_0.unitSpawn.buff:haveBuffTypeId(iter_8_1) then
					return true
				end
			end
		end
	end

	if arg_8_0.unitSpawn.buff and arg_8_0.unitSpawn.buff:haveBuffId(2112031) and arg_8_1 ~= "innate3" then
		return true
	end
end

function var_0_0.playAnim(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	var_0_0.super.playAnim(arg_9_0, arg_9_1, arg_9_2, arg_9_3)

	if arg_9_0._specialSpine then
		arg_9_0._specialSpine:playAnim(arg_9_1, arg_9_2, arg_9_3)
	end
end

function var_0_0.setFreeze(arg_10_0, arg_10_1)
	var_0_0.super.setFreeze(arg_10_0, arg_10_1)

	if arg_10_0._specialSpine then
		arg_10_0._specialSpine:setFreeze(arg_10_1)
	end
end

function var_0_0.setTimeScale(arg_11_0, arg_11_1)
	var_0_0.super.setTimeScale(arg_11_0, arg_11_1)

	if arg_11_0._specialSpine then
		arg_11_0._specialSpine:setTimeScale(arg_11_1)
	end
end

function var_0_0.setLayer(arg_12_0, arg_12_1, arg_12_2)
	var_0_0.super.setLayer(arg_12_0, arg_12_1, arg_12_2)

	if arg_12_0._specialSpine then
		arg_12_0._specialSpine:setLayer(arg_12_1, arg_12_2)
	end
end

function var_0_0.setRenderOrder(arg_13_0, arg_13_1, arg_13_2)
	var_0_0.super.setRenderOrder(arg_13_0, arg_13_1, arg_13_2)

	if arg_13_0._specialSpine then
		arg_13_0._specialSpine:setRenderOrder(arg_13_1, arg_13_2)
	end
end

function var_0_0.changeLookDir(arg_14_0, arg_14_1)
	var_0_0.super.changeLookDir(arg_14_0, arg_14_1)

	if arg_14_0._specialSpine then
		arg_14_0._specialSpine:changeLookDir(arg_14_1)
	end
end

function var_0_0._changeLookDir(arg_15_0)
	var_0_0.super._changeLookDir(arg_15_0)

	if arg_15_0._specialSpine then
		arg_15_0._specialSpine:_changeLookDir()
	end
end

function var_0_0.setActive(arg_16_0, arg_16_1)
	var_0_0.super.setActive(arg_16_0, arg_16_1)

	if arg_16_0._specialSpine then
		arg_16_0._specialSpine:setActive(arg_16_1)
	end
end

function var_0_0.setAnimation(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0._skeletonAnim then
		arg_17_0._skeletonAnim.loop = arg_17_2
		arg_17_0._skeletonAnim.CurAnimName = arg_17_1
	end

	var_0_0.super.setAnimation(arg_17_0, arg_17_1, arg_17_2, arg_17_3)

	if arg_17_0._specialSpine then
		arg_17_0._specialSpine:setAnimation(arg_17_1, arg_17_2, arg_17_3)
	end
end

function var_0_0._initSpine(arg_18_0, arg_18_1)
	var_0_0.super._initSpine(arg_18_0, arg_18_1)
	arg_18_0:_initSpecialSpine()
	arg_18_0:detectDisplayInScreen()
end

function var_0_0._initSpecialSpine(arg_19_0)
	if arg_19_0.unitSpawn:getMO() then
		if arg_19_0.LOCK_SPECIALSPINE then
			return
		end

		local var_19_0 = "FightEntitySpecialSpine" .. arg_19_0.unitSpawn:getMO().modelId

		if _G[var_19_0] then
			arg_19_0._specialSpine = _G[var_19_0].New(arg_19_0.unitSpawn)
		end
	end
end

function var_0_0.detectDisplayInScreen(arg_20_0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return true
	end

	local var_20_0 = arg_20_0:getSpineTr()

	if var_20_0 then
		local var_20_1 = FightDataHelper.entityMgr:getById(arg_20_0.unitSpawn.id)

		if var_20_1 then
			local var_20_2 = var_20_1.modelId
			local var_20_3 = lua_fight_monster_display_condition.configDict[var_20_2]

			if var_20_3 then
				local var_20_4 = false
				local var_20_5 = var_20_1:getBuffDic()

				for iter_20_0, iter_20_1 in pairs(var_20_5) do
					if iter_20_1.buffId == var_20_3.buffId then
						var_20_4 = true

						break
					end
				end

				if var_20_4 then
					transformhelper.setLocalPos(var_20_0, 0, 0, 0)
				else
					transformhelper.setLocalPos(var_20_0, 20000, 0, 0)

					return false
				end
			end
		end
	end

	return true
end

function var_0_0.detectRefreshAct(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.unitSpawn:getMO()

	if var_21_0 then
		local var_21_1 = lua_fight_buff_replace_spine_act.configDict[var_21_0.skin]

		if var_21_1 and var_21_1[arg_21_1] then
			arg_21_0.unitSpawn:resetAnimState()
		end
	end
end

function var_0_0._onBuffUpdate(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_1 == arg_22_0.unitSpawn.id then
		arg_22_0:detectDisplayInScreen()
		arg_22_0:detectRefreshAct(arg_22_3)
	end
end

function var_0_0.releaseSpecialSpine(arg_23_0)
	if arg_23_0._specialSpine then
		arg_23_0._specialSpine:releaseSelf()

		arg_23_0._specialSpine = nil
	end
end

function var_0_0._clear(arg_24_0)
	arg_24_0:releaseSpecialSpine()
	arg_24_0:removeAnimEventCallback(arg_24_0._onTransitionAnimEvent, arg_24_0)
	var_0_0.super._clear(arg_24_0)
end

function var_0_0.beforeDestroy(arg_25_0)
	if var_0_0.super.beforeDestroy then
		var_0_0.super.beforeDestroy(arg_25_0)
	end

	FightController.instance:unregisterCallback(FightEvent.SkillEditorRefreshBuff, arg_25_0.detectRefreshAct, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_25_0._onBuffUpdate, arg_25_0)
end

return var_0_0
