module("modules.logic.fight.entity.comp.buff.FightBuffCardAreaRedOrBlueBuff", package.seeall)

local var_0_0 = class("FightBuffCardAreaRedOrBlueBuff")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onBuffStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:clearEffectAndEntity()

	arg_2_0.entity = arg_2_1
	arg_2_0.entityMo = arg_2_1:getMO()
	arg_2_0.side = arg_2_0.entityMo.side

	local var_2_0 = GameSceneMgr.instance:getCurScene()

	arg_2_0.sceneEntityMgr = var_2_0 and var_2_0.entityMgr
	arg_2_0.effectCo = FightHeroSpEffectConfig.instance:getLYEffectCo(arg_2_0.entityMo.originSkin)
	arg_2_0.buffRes = arg_2_0.effectCo.path
	arg_2_0.spine1EffectRes = arg_2_0.effectCo.spine1EffectRes
	arg_2_0.spine2EffectRes = arg_2_0.effectCo.spine2EffectRes
	arg_2_0.spine1Res = arg_2_0:getFullSpineResPath(arg_2_0.effectCo.spine1Res)
	arg_2_0.spine2Res = arg_2_0:getFullSpineResPath(arg_2_0.effectCo.spine2Res)
	arg_2_0.playingUniqueSkill = false

	FightController.instance:registerCallback(FightEvent.BeforePlayUniqueSkill, arg_2_0.onBeforePlayUniqueSkill, arg_2_0)
	FightController.instance:registerCallback(FightEvent.AfterPlayUniqueSkill, arg_2_0.onAfterPlayUniqueSkill, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ReleaseAllEntrustedEntity, arg_2_0.onReleaseAllEntrustedEntity, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnCameraFocusChanged, arg_2_0.onCameraFocusChanged, arg_2_0)

	arg_2_0.loaded = false

	arg_2_0:startLoadRes()

	if arg_2_0.side == FightEnum.EntitySide.MySide then
		FightDataHelper.LYDataMgr:setLYCardAreaBuff(arg_2_2)
	end
end

function var_0_0.startLoadRes(arg_3_0)
	arg_3_0:clearLoader()

	arg_3_0.resLoader = MultiAbLoader.New()

	arg_3_0.resLoader:addPath(arg_3_0:getEffectAbPath(arg_3_0.buffRes))
	arg_3_0.resLoader:addPath(arg_3_0:getEffectAbPath(arg_3_0.spine1EffectRes))
	arg_3_0.resLoader:addPath(arg_3_0:getEffectAbPath(arg_3_0.spine2EffectRes))
	arg_3_0.resLoader:addPath(arg_3_0.spine1Res)
	arg_3_0.resLoader:addPath(arg_3_0.spine2Res)
	arg_3_0.resLoader:startLoad(arg_3_0.onResLoaded, arg_3_0)

	local var_3_0 = arg_3_0.effectCo.audioId

	if var_3_0 and var_3_0 ~= 0 then
		AudioMgr.instance:trigger(var_3_0)
	end
end

function var_0_0.getEffectAbPath(arg_4_0, arg_4_1)
	local var_4_0 = FightHelper.getEffectUrlWithLod(arg_4_1)

	return FightHelper.getEffectAbPath(var_4_0)
end

function var_0_0.getEffectPos(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.effectCo.pos

	if arg_5_1 == FightEnum.EntitySide.EnemySide then
		return -var_5_0[1], var_5_0[2], var_5_0[3]
	else
		return var_5_0[1], var_5_0[2], var_5_0[3]
	end
end

function var_0_0.onResLoaded(arg_6_0, arg_6_1)
	arg_6_0.loaded = true

	local var_6_0 = arg_6_0.entity:getSide()
	local var_6_1 = "LY_Spine_" .. (var_6_0 == FightEnum.EntitySide.MySide and "R" or "L")

	arg_6_0.spine1 = arg_6_0.sceneEntityMgr:buildTempSpine(arg_6_0.spine1Res, arg_6_0.entity.id .. "_1", var_6_0, UnityLayer.EffectMask, FightEntityLyTemp, var_6_1 .. "_1")
	arg_6_0.spine2 = arg_6_0.sceneEntityMgr:buildTempSpine(arg_6_0.spine2Res, arg_6_0.entity.id .. "_2", var_6_0, UnityLayer.EffectMask, FightEntityLyTemp, var_6_1 .. "_2")

	arg_6_0.spine1.spine:changeLookDir(SpineLookDir.Left)
	arg_6_0.spine2.spine:changeLookDir(SpineLookDir.Left)
	arg_6_0:hideEntity()

	arg_6_0.spine1Effect = arg_6_0.spine1.effect:addHangEffect(arg_6_0.spine1EffectRes, ModuleEnum.SpineHangPointRoot)
	arg_6_0.spine2Effect = arg_6_0.spine2.effect:addHangEffect(arg_6_0.spine2EffectRes, ModuleEnum.SpineHangPointRoot)
	arg_6_0.effectWrap = arg_6_0.entity.effect:addGlobalEffect(arg_6_0.buffRes)

	local var_6_2 = FightRenderOrderMgr.LYEffect * FightEnum.OrderRegion

	arg_6_0.spine1Effect:setRenderOrder(var_6_2)
	arg_6_0.spine2Effect:setRenderOrder(var_6_2)
	arg_6_0.effectWrap:setRenderOrder(var_6_2)

	local var_6_3 = arg_6_0.spine1Effect.effectGO and gohelper.findChild(arg_6_0.spine1Effect.effectGO, "root")

	arg_6_0.spine1EffectAnimator = var_6_3 and ZProj.ProjAnimatorPlayer.Get(var_6_3)

	local var_6_4 = arg_6_0.spine2Effect.effectGO and gohelper.findChild(arg_6_0.spine2Effect.effectGO, "root")

	arg_6_0.spine2EffectAnimator = var_6_4 and ZProj.ProjAnimatorPlayer.Get(var_6_4)

	local var_6_5 = arg_6_0.effectWrap.effectGO and gohelper.findChild(arg_6_0.effectWrap.effectGO, "root")

	arg_6_0.effectAnimator = var_6_5 and ZProj.ProjAnimatorPlayer.Get(var_6_5)

	arg_6_0.effectWrap:setWorldPos(arg_6_0:getEffectPos(var_6_0))
	arg_6_0:addEffect(arg_6_0.spine1, arg_6_0.spine1Effect, var_6_0)
	arg_6_0:addEffect(arg_6_0.spine2, arg_6_0.spine2Effect, var_6_0)
	arg_6_0:showEntity()
	arg_6_0.spine1.spine:addAnimEventCallback(arg_6_0.onAnimEventCallback, arg_6_0)
	arg_6_0:playAnim(SpineAnimState.born)
	arg_6_0:refreshEffectActive()
	FightController.instance:registerCallback(FightEvent.TimelineLYSpecialSpinePlayAniName, arg_6_0.playAnim, arg_6_0)
end

function var_0_0.addEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_2:setWorldPos(arg_7_0:getEffectPos(arg_7_3))
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_7_1.id, arg_7_2)
end

function var_0_0.playAnim(arg_8_0, arg_8_1)
	if not arg_8_0.loaded then
		return
	end

	if arg_8_0:isIdleAnim(arg_8_1) then
		arg_8_0.spine1.spine:play(arg_8_1, true, true)
	else
		arg_8_0.spine1.spine:play(arg_8_1, false, true)
	end
end

function var_0_0.onAnimEventCallback(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0:isIdleAnim(arg_9_1) then
		return
	end

	if arg_9_2 == SpineAnimEvent.ActionComplete then
		return arg_9_0:playAnim(SpineAnimState.idle1)
	end
end

function var_0_0.isIdleAnim(arg_10_0, arg_10_1)
	return SpineAnimState.idle1 == arg_10_1 or SpineAnimState.idle2 == arg_10_1
end

function var_0_0.onCameraFocusChanged(arg_11_0, arg_11_1)
	arg_11_0.focusing = arg_11_1

	arg_11_0:refreshEffectActive()
end

function var_0_0.onBeforePlayUniqueSkill(arg_12_0)
	arg_12_0.playingUniqueSkill = true

	arg_12_0:refreshEffectActive()
end

function var_0_0.onAfterPlayUniqueSkill(arg_13_0)
	arg_13_0.playingUniqueSkill = false

	arg_13_0:refreshEffectActive()
end

function var_0_0.refreshEffectActive(arg_14_0)
	if arg_14_0.loaded then
		local var_14_0 = not arg_14_0.playingUniqueSkill and not arg_14_0.focusing

		arg_14_0.spine1Effect:setActive(var_14_0)
		arg_14_0.spine2Effect:setActive(var_14_0)
		arg_14_0.effectWrap:setActive(var_14_0)

		if var_14_0 then
			arg_14_0:showEntity()
		else
			arg_14_0:hideEntity()
		end
	end
end

function var_0_0.setEntityAlpha(arg_15_0, arg_15_1)
	if not arg_15_0.loaded then
		return
	end

	arg_15_0.spine1.spineRenderer:setAlpha(arg_15_1)
	arg_15_0.spine2.spineRenderer:setAlpha(arg_15_1)
end

function var_0_0.hideEntity(arg_16_0)
	arg_16_0:setEntityAlpha(0)
end

function var_0_0.showEntity(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._showEntity, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0._showEntity, arg_17_0, 0.01)
end

function var_0_0._showEntity(arg_18_0)
	if arg_18_0.playingUniqueSkill then
		arg_18_0:setEntityAlpha(0)
	else
		arg_18_0:setEntityAlpha(1)
	end
end

function var_0_0.getFullSpineResPath(arg_19_0, arg_19_1)
	return string.format("roles/%s.prefab", arg_19_1)
end

function var_0_0.onReleaseAllEntrustedEntity(arg_20_0)
	arg_20_0:clear()
end

function var_0_0.clearLoader(arg_21_0)
	if arg_21_0.resLoader then
		arg_21_0.resLoader:dispose()

		arg_21_0.resLoader = nil
	end
end

function var_0_0.clear(arg_22_0)
	arg_22_0:clearLoader()
	TaskDispatcher.cancelTask(arg_22_0._showEntity, arg_22_0)

	if arg_22_0.effectAnimator then
		local var_22_0 = arg_22_0.effectCo and arg_22_0.effectCo.fadeAudioId

		if var_22_0 and var_22_0 ~= 0 then
			AudioMgr.instance:trigger(var_22_0)
		end

		arg_22_0.spine1EffectAnimator:Play("close")
		arg_22_0.spine2EffectAnimator:Play("close")
		arg_22_0.effectAnimator:Play("close", arg_22_0.clearEffectAndEntity, arg_22_0)
	else
		arg_22_0:clearEffectAndEntity()
	end

	if arg_22_0.side == FightEnum.EntitySide.MySide then
		FightDataHelper.LYDataMgr:setLYCardAreaBuff(nil)
	end

	FightController.instance:unregisterCallback(FightEvent.TimelineLYSpecialSpinePlayAniName, arg_22_0.playAnim, arg_22_0)
	FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, arg_22_0.onBeforePlayUniqueSkill, arg_22_0)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, arg_22_0.onAfterPlayUniqueSkill, arg_22_0)
	FightController.instance:unregisterCallback(FightEvent.ReleaseAllEntrustedEntity, arg_22_0.onReleaseAllEntrustedEntity, arg_22_0)

	arg_22_0.loaded = false
end

function var_0_0.clearEffectAndEntity(arg_23_0)
	arg_23_0:clearSpine(arg_23_0.spine1, arg_23_0.spine1Effect)
	arg_23_0:clearSpine(arg_23_0.spine2, arg_23_0.spine2Effect)
	arg_23_0:clearEffect(arg_23_0.entity, arg_23_0.effectWrap)

	arg_23_0.spine1 = nil
	arg_23_0.spine2 = nil
	arg_23_0.spine1Effect = nil
	arg_23_0.spine2Effect = nil
	arg_23_0.effectWrap = nil
	arg_23_0.effectAnimator = nil
	arg_23_0.spine1EffectAnimator = nil
	arg_23_0.spine2EffectAnimator = nil
	arg_23_0.entity = nil
end

function var_0_0.clearSpine(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 then
		arg_24_0:clearEffect(arg_24_1, arg_24_2)
		arg_24_0.sceneEntityMgr:removeUnit(arg_24_1:getTag(), arg_24_1.id)
	end
end

function var_0_0.clearEffect(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 and arg_25_2 then
		arg_25_1.effect:removeEffect(arg_25_2)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_25_1.id, arg_25_2)
	end
end

function var_0_0.onBuffEnd(arg_26_0)
	arg_26_0:clear()
end

function var_0_0.dispose(arg_27_0)
	arg_27_0:clear()
end

return var_0_0
