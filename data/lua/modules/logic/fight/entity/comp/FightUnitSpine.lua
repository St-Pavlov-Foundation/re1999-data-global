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
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate, arg_2_0)
	FightController.instance:registerCallback(FightEvent.SkillEditorRefreshBuff, arg_2_0.detectRefreshAct, arg_2_0)
end

function var_0_0.play(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if arg_3_0.lockAct then
		return
	end

	if not arg_3_4 then
		arg_3_1 = FightHelper.processEntityActionName(arg_3_0.unitSpawn, arg_3_1, arg_3_5)
	end

	if arg_3_0:_cannotPlay(arg_3_1) then
		arg_3_0:_onAnimCallback(arg_3_1, SpineAnimEvent.ActionComplete)

		return
	end

	if arg_3_0._tran_to_ani == arg_3_1 then
		return
	else
		arg_3_0._tran_to_ani = nil
	end

	local var_3_0, var_3_1 = FightHelper.needPlayTransitionAni(arg_3_0.unitSpawn, arg_3_1)

	if var_3_0 then
		if var_3_1 == "0" then
			arg_3_0:setAnimation(arg_3_1, arg_3_2)

			return
		elseif var_3_1 == "-1" then
			arg_3_0:_onAnimCallback(arg_3_1, SpineAnimEvent.ActionComplete)

			return
		else
			arg_3_0._tran_to_ani = arg_3_1
			arg_3_0._tran_loop = arg_3_2
			arg_3_0._tran_reStart = arg_3_3
			arg_3_0._tran_ani = var_3_1

			arg_3_0:addAnimEventCallback(arg_3_0._onTransitionAnimEvent, arg_3_0)
			var_0_0.super.play(arg_3_0, arg_3_0._tran_ani, false, true)

			return
		end
	end

	arg_3_0._tran_ani = nil

	var_0_0.super.play(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
end

function var_0_0._onTransitionAnimEvent(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == arg_4_0._tran_ani and arg_4_2 == SpineAnimEvent.ActionComplete then
		arg_4_0:removeAnimEventCallback(arg_4_0._onTransitionAnimEvent, arg_4_0)
		var_0_0.super.play(arg_4_0, arg_4_0._tran_to_ani, arg_4_0._tran_loop, arg_4_0._tran_reStart)

		arg_4_0._tran_to_ani = nil
	end
end

function var_0_0.tryPlay(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0:hasAnimation(arg_5_1) then
		return false
	end

	local var_5_0 = arg_5_0.unitSpawn:getMO():getBuffDic()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_1 = iter_5_1.buffId

		if FightBuffHelper.isStoneBuff(var_5_1) then
			return
		end

		if FightBuffHelper.isDizzyBuff(var_5_1) then
			return
		end

		if FightBuffHelper.isSleepBuff(var_5_1) then
			return
		end

		if FightBuffHelper.isFrozenBuff(var_5_1) then
			return
		end
	end

	arg_5_0:play(arg_5_1, arg_5_2, arg_5_3)

	return true
end

function var_0_0._cannotPlay(arg_6_0, arg_6_1)
	if arg_6_0.unitSpawn.buff then
		local var_6_0 = FightConfig.instance:getRejectActBuffTypeList(arg_6_1)

		if var_6_0 then
			for iter_6_0, iter_6_1 in ipairs(var_6_0) do
				if arg_6_0.unitSpawn.buff:haveBuffTypeId(iter_6_1) then
					return true
				end
			end
		end
	end

	if arg_6_0.unitSpawn.buff and arg_6_0.unitSpawn.buff:haveBuffId(2112031) and arg_6_1 ~= "innate3" then
		return true
	end
end

function var_0_0.playAnim(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_0.super.playAnim(arg_7_0, arg_7_1, arg_7_2, arg_7_3)

	if arg_7_0._specialSpine then
		arg_7_0._specialSpine:playAnim(arg_7_1, arg_7_2, arg_7_3)
	end
end

function var_0_0.setFreeze(arg_8_0, arg_8_1)
	var_0_0.super.setFreeze(arg_8_0, arg_8_1)

	if arg_8_0._specialSpine then
		arg_8_0._specialSpine:setFreeze(arg_8_1)
	end
end

function var_0_0.setTimeScale(arg_9_0, arg_9_1)
	var_0_0.super.setTimeScale(arg_9_0, arg_9_1)

	if arg_9_0._specialSpine then
		arg_9_0._specialSpine:setTimeScale(arg_9_1)
	end
end

function var_0_0.setLayer(arg_10_0, arg_10_1, arg_10_2)
	var_0_0.super.setLayer(arg_10_0, arg_10_1, arg_10_2)

	if arg_10_0._specialSpine then
		arg_10_0._specialSpine:setLayer(arg_10_1, arg_10_2)
	end
end

function var_0_0.setRenderOrder(arg_11_0, arg_11_1, arg_11_2)
	var_0_0.super.setRenderOrder(arg_11_0, arg_11_1, arg_11_2)

	if arg_11_0._specialSpine then
		arg_11_0._specialSpine:setRenderOrder(arg_11_1, arg_11_2)
	end
end

function var_0_0.changeLookDir(arg_12_0, arg_12_1)
	var_0_0.super.changeLookDir(arg_12_0, arg_12_1)

	if arg_12_0._specialSpine then
		arg_12_0._specialSpine:changeLookDir(arg_12_1)
	end
end

function var_0_0._changeLookDir(arg_13_0)
	var_0_0.super._changeLookDir(arg_13_0)

	if arg_13_0._specialSpine then
		arg_13_0._specialSpine:_changeLookDir()
	end
end

function var_0_0.setActive(arg_14_0, arg_14_1)
	var_0_0.super.setActive(arg_14_0, arg_14_1)

	if arg_14_0._specialSpine then
		arg_14_0._specialSpine:setActive(arg_14_1)
	end
end

function var_0_0.setAnimation(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_0._skeletonAnim then
		arg_15_0._skeletonAnim.loop = arg_15_2
		arg_15_0._skeletonAnim.CurAnimName = arg_15_1
	end

	var_0_0.super.setAnimation(arg_15_0, arg_15_1, arg_15_2, arg_15_3)

	if arg_15_0._specialSpine then
		arg_15_0._specialSpine:setAnimation(arg_15_1, arg_15_2, arg_15_3)
	end
end

function var_0_0._initSpine(arg_16_0, arg_16_1)
	var_0_0.super._initSpine(arg_16_0, arg_16_1)
	arg_16_0:_initSpecialSpine()
	arg_16_0:detectDisplayInScreen()
end

function var_0_0._initSpecialSpine(arg_17_0)
	if arg_17_0.unitSpawn:getMO() then
		if arg_17_0.LOCK_SPECIALSPINE then
			return
		end

		local var_17_0 = "FightEntitySpecialSpine" .. arg_17_0.unitSpawn:getMO().modelId

		if _G[var_17_0] then
			arg_17_0._specialSpine = _G[var_17_0].New(arg_17_0.unitSpawn)
		end
	end
end

function var_0_0.detectDisplayInScreen(arg_18_0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return true
	end

	local var_18_0 = arg_18_0:getSpineTr()

	if var_18_0 then
		local var_18_1 = FightDataHelper.entityMgr:getById(arg_18_0.unitSpawn.id)

		if var_18_1 then
			local var_18_2 = var_18_1.modelId
			local var_18_3 = lua_fight_monster_display_condition.configDict[var_18_2]

			if var_18_3 then
				local var_18_4 = false
				local var_18_5 = var_18_1:getBuffDic()

				for iter_18_0, iter_18_1 in pairs(var_18_5) do
					if iter_18_1.buffId == var_18_3.buffId then
						var_18_4 = true

						break
					end
				end

				if var_18_4 then
					transformhelper.setLocalPos(var_18_0, 0, 0, 0)
				else
					transformhelper.setLocalPos(var_18_0, 20000, 0, 0)

					return false
				end
			end
		end
	end

	return true
end

function var_0_0.detectRefreshAct(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.unitSpawn:getMO()

	if var_19_0 then
		local var_19_1 = lua_fight_buff_replace_spine_act.configDict[var_19_0.skin]

		if var_19_1 and var_19_1[arg_19_1] then
			arg_19_0.unitSpawn:resetAnimState()
		end
	end
end

function var_0_0._onBuffUpdate(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 == arg_20_0.unitSpawn.id then
		arg_20_0:detectDisplayInScreen()
		arg_20_0:detectRefreshAct(arg_20_3)
	end
end

function var_0_0.releaseSpecialSpine(arg_21_0)
	if arg_21_0._specialSpine then
		arg_21_0._specialSpine:releaseSelf()

		arg_21_0._specialSpine = nil
	end
end

function var_0_0._clear(arg_22_0)
	arg_22_0:releaseSpecialSpine()
	arg_22_0:removeAnimEventCallback(arg_22_0._onTransitionAnimEvent, arg_22_0)
	var_0_0.super._clear(arg_22_0)
end

function var_0_0.beforeDestroy(arg_23_0)
	if var_0_0.super.beforeDestroy then
		var_0_0.super.beforeDestroy(arg_23_0)
	end

	FightController.instance:unregisterCallback(FightEvent.SkillEditorRefreshBuff, arg_23_0.detectRefreshAct, arg_23_0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_23_0._onBuffUpdate, arg_23_0)
end

return var_0_0
