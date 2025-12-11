module("modules.logic.fight.entity.BaseFightEntity", package.seeall)

local var_0_0 = class("BaseFightEntity", BaseUnitSpawn)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0._isActive = true
	arg_1_0.isDead = false
	arg_1_0.deadBySkillId = nil
	arg_1_0.needLookCamera = true
	arg_1_0.createStage = FightEnum.EntityCreateStage.None
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)
	arg_2_0:initHangPointDict()
	FightRenderOrderMgr.instance:register(arg_2_0.id)
end

function var_0_0.initHangPointDict(arg_3_0)
	arg_3_0._hangPointDict = arg_3_0:getUserDataTb_()
end

function var_0_0.setCreateStage(arg_4_0, arg_4_1)
	arg_4_0.createStage = arg_4_1
end

function var_0_0.getCreateStage(arg_5_0)
	return arg_5_0.createStage
end

function var_0_0.initComponents(arg_6_0)
	arg_6_0:addComp("spine", arg_6_0:getSpineClass())
	arg_6_0:addComp("spineRenderer", UnitSpineRenderer)
	arg_6_0:addComp("mover", UnitMoverEase)
	arg_6_0:addComp("parabolaMover", UnitMoverParabola)
	arg_6_0:addComp("bezierMover", UnitMoverBezier)
	arg_6_0:addComp("curveMover", UnitMoverCurve)
	arg_6_0:addComp("moveHandler", UnitMoverHandler)
	arg_6_0:addComp("skill", FightSkillComp)
	arg_6_0:addComp("effect", FightEffectComp)
	arg_6_0:addComp("buff", FightBuffComp)
	arg_6_0:addComp("skinSpineAction", FightSkinSpineAction)
	arg_6_0:addComp("skinSpineEffect", FightSkinSpineEffect)
	arg_6_0:addComp("totalDamage", FightTotalDamageComp)
	arg_6_0:addComp("uniqueEffect", FightUniqueEffectComp)
	arg_6_0:addComp("skinCustomComp", FightSkinCustomComp)

	local var_6_0 = arg_6_0:getMO()

	if BossRushController.instance:isInBossRushInfiniteFight(true) then
		arg_6_0:addComp("nameUI", BossRushFightNameUI)
	elseif var_6_0:isAssistBoss() then
		-- block empty
	elseif var_6_0:isAct191Boss() then
		-- block empty
	else
		arg_6_0:addComp("nameUI", FightNameUI)
	end

	arg_6_0:initCompDone()
end

function var_0_0.addComp(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.filterComp and arg_7_0.filterComp[arg_7_1] then
		return
	end

	var_0_0.super.addComp(arg_7_0, arg_7_1, arg_7_2)
end

function var_0_0.getMO(arg_8_0)
	local var_8_0 = FightDataHelper.entityMgr:getById(arg_8_0.id)

	arg_8_0.entityMO = var_8_0 or arg_8_0.entityMO

	return var_8_0 or arg_8_0.entityMO
end

function var_0_0.getSide(arg_9_0)
	local var_9_0 = arg_9_0:getMO()

	if var_9_0 then
		return var_9_0.side
	end

	return FightEnum.EntitySide.BothSide
end

function var_0_0.isMySide(arg_10_0)
	return arg_10_0:getSide() == FightEnum.EntitySide.MySide
end

function var_0_0.isEnemySide(arg_11_0)
	return arg_11_0:getSide() == FightEnum.EntitySide.EnemySide
end

function var_0_0.isActive(arg_12_0)
	return arg_12_0._isActive
end

function var_0_0.setRenderOrder(arg_13_0, arg_13_1)
	if arg_13_0.spine then
		arg_13_0.spine:setRenderOrder(arg_13_1)
	end
end

function var_0_0.loadSpine(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0.spine then
		if arg_14_0.spine:getSpineGO() then
			arg_14_0:initHangPointDict()
		end

		arg_14_0._callback = arg_14_1
		arg_14_0._callbackObj = arg_14_2

		arg_14_0.spine:setResPath(arg_14_3 or arg_14_0:getSpineUrl(), arg_14_0._onSpineLoaded, arg_14_0)
	end
end

function var_0_0.getSpineUrl(arg_15_0, arg_15_1)
	local var_15_0 = ResUrl.getSpineFightPrefabBySkin(arg_15_1 or arg_15_0:getMO():getSpineSkinCO())

	if FightHelper.XingTiSpineUrl2Special[var_15_0] and FightHelper.detectXingTiSpecialUrl(arg_15_0) then
		var_15_0 = FightHelper.XingTiSpineUrl2Special[var_15_0]
	end

	return var_15_0
end

function var_0_0._onSpineLoaded(arg_16_0, arg_16_1)
	if arg_16_0.spineRenderer then
		arg_16_0.spineRenderer:setSpine(arg_16_1)
	end

	arg_16_0:registClasses()

	if arg_16_0._callback then
		if arg_16_0._callbackObj then
			arg_16_0._callback(arg_16_0._callbackObj, arg_16_1, arg_16_0)
		else
			arg_16_0._callback(arg_16_1, arg_16_0)
		end
	end

	arg_16_0._callback = nil
	arg_16_0._callbackObj = nil

	arg_16_0:setupLookAtCamera()
end

function var_0_0.setupLookAtCamera(arg_17_0)
	if arg_17_0.needLookCamera then
		ZProj.TransformListener.Get(arg_17_0.go):AddPositionCallback(arg_17_0._onTransformChange, arg_17_0)
	end
end

function var_0_0._onTransformChange(arg_18_0)
	GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:adjustSpineLookRotation(arg_18_0)
end

function var_0_0.setActive(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_2 or arg_19_1 ~= arg_19_0._isActive then
		arg_19_0._isActive = arg_19_1

		gohelper.setActive(arg_19_0.go, arg_19_0._isActive)

		local var_19_0 = arg_19_0:getCompList()

		if var_19_0 then
			for iter_19_0, iter_19_1 in ipairs(var_19_0) do
				if iter_19_1.setActive then
					iter_19_1:setActive(arg_19_1)
				end
			end
		end
	end
end

function var_0_0.setVisibleByPos(arg_20_0, arg_20_1)
	if not arg_20_0.go then
		logError("找不到entity实体GameObject~~~~~~~~~~~~~~~~~~~~~")

		return
	end

	if arg_20_1 then
		arg_20_0:resetStandPos()
	else
		transformhelper.setLocalPos(arg_20_0.go.transform, 9999, 9999, 9999)
	end
end

function var_0_0.setAlpha(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.marked_alpha = arg_21_1

	if arg_21_0.spineRenderer then
		arg_21_0.spineRenderer:setAlpha(arg_21_1, arg_21_2)
	end

	if arg_21_0.buff then
		if arg_21_1 == 0 then
			arg_21_0.buff:hideBuffEffects()
		elseif arg_21_1 == 1 then
			arg_21_0.buff:showBuffEffects()
		end
	end

	if arg_21_0.skinSpineEffect then
		if arg_21_1 == 0 then
			arg_21_0.skinSpineEffect:hideEffects()
		else
			arg_21_0.skinSpineEffect:showEffects()
		end
	end

	if arg_21_0.effect then
		if arg_21_1 == 0 then
			arg_21_0.effect:hideSpecialEffects()
		else
			arg_21_0.effect:showSpecialEffects()
		end
	end

	FightController.instance:dispatchEvent(FightEvent.SetEntityAlpha, arg_21_0.id, arg_21_1 ~= 0)
end

function var_0_0.resetEntity(arg_22_0)
	if gohelper.isNil(arg_22_0.go) then
		return
	end

	local var_22_0 = arg_22_0:getMO()

	if var_22_0 then
		if FightEntityDataHelper.isPlayerUid(var_22_0.id) then
			return
		end

		if arg_22_0.skill and arg_22_0.skill:sameSkillPlaying() then
			return
		end

		local var_22_1 = FightHelper.getEntitySpineLookDir(var_22_0)

		if arg_22_0.spine then
			arg_22_0.spine:changeLookDir(var_22_1)
		end

		arg_22_0:resetAnimState()
		arg_22_0:resetSpineMat()
		arg_22_0:resetStandPos()
		arg_22_0:resetSpineRotate()

		local var_22_2, var_22_3, var_22_4, var_22_5 = FightHelper.getEntityStandPos(var_22_0)

		arg_22_0:setScale(var_22_5)
	end
end

function var_0_0.resetAnimState(arg_23_0)
	if arg_23_0.isDead then
		return
	end

	local var_23_0 = arg_23_0:getDefaultAnim()

	if not string.nilorempty(var_23_0) and arg_23_0.spine then
		arg_23_0.spine:removeAnimEventCallback(arg_23_0._onChange2AnimEvent, arg_23_0)

		local var_23_1 = SpineAnimState.change2

		if var_23_0 == SpineAnimState.idle1 and arg_23_0.spine:getAnimState() == SpineAnimState.posture and arg_23_0.spine:hasAnimation(var_23_1) then
			arg_23_0.spine:addAnimEventCallback(arg_23_0._onChange2AnimEvent, arg_23_0)
			arg_23_0.spine:play(var_23_1, false, true)
		elseif arg_23_0.spine:hasAnimation(var_23_0) then
			arg_23_0.spine:play(var_23_0, true, false)
		else
			arg_23_0.spine:play(SpineAnimState.idle1, true, true)
		end
	end
end

function var_0_0._onChange2AnimEvent(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if (arg_24_0.spine and arg_24_0.spine:getAnimState()) == arg_24_1 and arg_24_1 == SpineAnimState.change2 and arg_24_2 == SpineAnimEvent.ActionComplete then
		arg_24_0.spine:removeAnimEventCallback(arg_24_0._onChange2AnimEvent, arg_24_0)
		arg_24_0.spine:play(SpineAnimState.idle1, true, true)
	end
end

function var_0_0.resetStandPos(arg_25_0)
	local var_25_0 = arg_25_0:getMO()

	if var_25_0 and not gohelper.isNil(arg_25_0.go) then
		transformhelper.setLocalPos(arg_25_0.go.transform, FightHelper.getEntityStandPos(var_25_0))
	end
end

function var_0_0.resetSpineRotate(arg_26_0)
	local var_26_0 = arg_26_0.spine and arg_26_0.spine:getSpineTr()

	if not gohelper.isNil(var_26_0) then
		transformhelper.setLocalRotation(var_26_0, 0, 0, 0)
	end
end

function var_0_0.resetSpineMat(arg_27_0)
	if not arg_27_0.spine or not arg_27_0.spine:getSpineGO() then
		return
	end

	local var_27_0 = arg_27_0:getDefaultMatName()

	if var_27_0 then
		if not string.nilorempty(var_27_0) and var_27_0 ~= arg_27_0._curMatName then
			arg_27_0._curMatName = var_27_0

			local var_27_1 = FightSpineMatPool.getMat(var_27_0)

			if var_27_1 then
				var_27_1.name = var_27_0

				arg_27_0.spineRenderer:replaceSpineMat(var_27_1)
			end
		end
	else
		arg_27_0._curMatName = nil

		arg_27_0.spineRenderer:resetSpineMat()
	end

	FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, arg_27_0.id, arg_27_0.spineRenderer:getReplaceMat())
end

function var_0_0.getScale(arg_28_0)
	local var_28_0, var_28_1, var_28_2 = transformhelper.getLocalScale(arg_28_0.go.transform)

	return var_28_0
end

function var_0_0.setScale(arg_29_0, arg_29_1)
	if gohelper.isNil(arg_29_0.go) then
		return
	end

	transformhelper.setLocalScale(arg_29_0.go.transform, arg_29_1, arg_29_1, arg_29_1)
end

function var_0_0.setSpeed(arg_30_0, arg_30_1)
	if arg_30_0.spine then
		arg_30_0.spine:setTimeScale(arg_30_1)
	end

	if arg_30_0.mover then
		arg_30_0.mover:setTimeScale(arg_30_1)
	end

	if arg_30_0.parabolaMover then
		arg_30_0.parabolaMover:setTimeScale(arg_30_1)
	end

	if arg_30_0.bezierMover then
		arg_30_0.bezierMover:setTimeScale(arg_30_1)
	end

	if arg_30_0.curveMover then
		arg_30_0.curveMover:setTimeScale(arg_30_1)
	end

	if arg_30_0.skill then
		arg_30_0.skill:setTimeScale(arg_30_1)
	end

	if arg_30_0.effect then
		arg_30_0.effect:setTimeScale(arg_30_1)
	end
end

function var_0_0.getDefaultAnim(arg_31_0)
	local var_31_0 = arg_31_0:getBuffAnim()

	if var_31_0 then
		return var_31_0
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play and FightPlayCardModel.instance:isPlayerHasSkillToPlay(arg_31_0.id) then
		return SpineAnimState.posture
	end

	return SpineAnimState.idle1
end

function var_0_0.getBuffAnim(arg_32_0)
	if arg_32_0.buff then
		local var_32_0 = arg_32_0.buff:getBuffAnim()

		if var_32_0 then
			return var_32_0
		end
	end
end

function var_0_0.getDefaultMatName(arg_33_0)
	if arg_33_0.buff then
		return arg_33_0.buff:getBuffMatName()
	end
end

function var_0_0.playBeHitMatEffect(arg_34_0, arg_34_1)
	if arg_34_0.spine then
		local var_34_0 = arg_34_0.spineRenderer:getReplaceMat()

		if not gohelper.isNil(var_34_0) then
			var_34_0:EnableKeyword("_BEHIT_ON")
			TaskDispatcher.cancelTask(arg_34_0._delayDisableBeHit, arg_34_0)

			if arg_34_1 > 0 then
				arg_34_0._beHitMat = var_34_0

				TaskDispatcher.runDelay(arg_34_0._delayDisableBeHit, arg_34_0, arg_34_1)
			else
				var_34_0:DisableKeyword("_BEHIT_ON")
				logError("play be hit error, duration < 0")
			end
		end
	end
end

function var_0_0._delayDisableBeHit(arg_35_0)
	if not gohelper.isNil(arg_35_0._beHitMat) then
		arg_35_0._beHitMat:DisableKeyword("_BEHIT_ON")

		arg_35_0._beHitMat = nil
	end
end

function var_0_0.beforeDestroy(arg_36_0)
	if arg_36_0._hasDestroy then
		return
	end

	arg_36_0._hasDestroy = true

	arg_36_0:releaseClasses()

	if arg_36_0.spine then
		arg_36_0.spine:removeAnimEventCallback(arg_36_0._onChange2AnimEvent, arg_36_0)
	end

	FightRenderOrderMgr.instance:unregister(arg_36_0.id)
	TaskDispatcher.cancelTask(arg_36_0._delayDisableBeHit, arg_36_0)

	local var_36_0 = arg_36_0:getCompList()

	if var_36_0 then
		for iter_36_0, iter_36_1 in ipairs(var_36_0) do
			if iter_36_1.beforeDestroy then
				iter_36_1:beforeDestroy()
			end
		end
	end

	GameSceneMgr.instance:getCurScene().bloom:removeEntity(arg_36_0)

	if arg_36_0.go then
		ZProj.TransformListener.Get(arg_36_0.go):RemovePositionCallback()
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeEntityDestroy, arg_36_0)
end

function var_0_0.getHangPoint(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0._hangPointDict[arg_37_1]

	if var_37_0 then
		return var_37_0
	else
		local var_37_1 = arg_37_0.spine and arg_37_0.spine:getSpineGO()

		if not var_37_1 then
			return arg_37_0.go
		end

		local var_37_2 = arg_37_0.go

		if not string.nilorempty(arg_37_1) then
			local var_37_3
			local var_37_4 = gohelper.findChild(var_37_1, ModuleEnum.SpineHangPointRoot)

			if arg_37_1 == ModuleEnum.SpineHangPointRoot then
				var_37_3 = var_37_4
			elseif string.find(arg_37_1, ModuleEnum.SpineHangPoint.BodyStatic) then
				var_37_3 = gohelper.create3d(var_37_4, arg_37_1)

				transformhelper.setLocalPos(var_37_3.transform, FightHelper.getEntityLocalCenterPos(arg_37_0))
			elseif string.find(arg_37_1, ModuleEnum.SpineHangPoint.HeadStatic) then
				var_37_3 = gohelper.create3d(var_37_4, arg_37_1)

				transformhelper.setLocalPos(var_37_3.transform, FightHelper.getEntityLocalTopPos(arg_37_0))
			else
				var_37_3 = gohelper.findChild(var_37_4, arg_37_1)
			end

			if var_37_3 then
				var_37_2 = var_37_3
			else
				var_37_2 = var_37_4

				local var_37_5 = string.find(var_37_1.name, "(Clone)", 1)
				local var_37_6 = var_37_5 and string.sub(var_37_1.name, 1, var_37_5 - 2) or var_37_1.name

				if isDebugBuild then
					logError(var_37_6 .. " 缺少挂点: " .. arg_37_1)
				end
			end

			arg_37_0._hangPointDict[arg_37_1] = var_37_2
		end

		return var_37_2
	end
end

function var_0_0.initCompDone(arg_38_0)
	local var_38_0 = arg_38_0:getCompList()

	if var_38_0 then
		for iter_38_0, iter_38_1 in ipairs(var_38_0) do
			if iter_38_1.onInitCompDone then
				iter_38_1:onInitCompDone()
			end
		end
	end
end

function var_0_0.getSpineClass(arg_39_0)
	return FightUnitSpine
end

function var_0_0.registClasses(arg_40_0)
	local var_40_0 = arg_40_0:getMO()

	if not var_40_0 then
		return
	end

	if FightEntityDataHelper.isPlayerUid(var_40_0.id) then
		return
	end

	if arg_40_0._instantiateClass then
		return
	end

	arg_40_0._instantiateClass = {}

	arg_40_0:newClass(FightEntitySummonedComp, arg_40_0)
	arg_40_0:newClass(FightEntityBuffSpecialPrecessComp, arg_40_0)
end

function var_0_0.newClass(arg_41_0, arg_41_1, ...)
	local var_41_0 = arg_41_1.New(...)

	table.insert(arg_41_0._instantiateClass, var_41_0)

	return var_41_0
end

function var_0_0.releaseClasses(arg_42_0)
	if arg_42_0._instantiateClass then
		for iter_42_0, iter_42_1 in ipairs(arg_42_0._instantiateClass) do
			if not iter_42_1.INVOKEDDISPOSE then
				iter_42_1:disposeSelf()
			end
		end
	end

	arg_42_0._instantiateClass = nil
end

return var_0_0
