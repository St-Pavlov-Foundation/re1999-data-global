module("modules.logic.fight.entity.BaseFightEntity", package.seeall)

local var_0_0 = class("BaseFightEntity", BaseUnitSpawn)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0._isActive = true
	arg_1_0.isDead = false
	arg_1_0.deadBySkillId = nil
	arg_1_0.needLookCamera = true
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)
	arg_2_0:initHangPointDict()
	FightRenderOrderMgr.instance:register(arg_2_0.id)
end

function var_0_0.initHangPointDict(arg_3_0)
	arg_3_0._hangPointDict = arg_3_0:getUserDataTb_()
end

function var_0_0.initComponents(arg_4_0)
	arg_4_0:addComp("spine", arg_4_0:getSpineClass())
	arg_4_0:addComp("spineRenderer", UnitSpineRenderer)
	arg_4_0:addComp("mover", UnitMoverEase)
	arg_4_0:addComp("parabolaMover", UnitMoverParabola)
	arg_4_0:addComp("bezierMover", UnitMoverBezier)
	arg_4_0:addComp("curveMover", UnitMoverCurve)
	arg_4_0:addComp("moveHandler", UnitMoverHandler)
	arg_4_0:addComp("skill", FightSkillComp)
	arg_4_0:addComp("effect", FightEffectComp)
	arg_4_0:addComp("buff", FightBuffComp)
	arg_4_0:addComp("skinSpineAction", FightSkinSpineAction)
	arg_4_0:addComp("skinSpineEffect", FightSkinSpineEffect)
	arg_4_0:addComp("totalDamage", FightTotalDamageComp)
	arg_4_0:addComp("uniqueEffect", FightUniqueEffectComp)

	local var_4_0 = arg_4_0:getMO()

	if BossRushController.instance:isInBossRushInfiniteFight(true) then
		arg_4_0:addComp("nameUI", BossRushFightNameUI)
	elseif var_4_0:isAssistBoss() then
		-- block empty
	else
		arg_4_0:addComp("nameUI", FightNameUI)
	end

	arg_4_0:initCompDone()
end

function var_0_0.addComp(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.filterComp and arg_5_0.filterComp[arg_5_1] then
		return
	end

	var_0_0.super.addComp(arg_5_0, arg_5_1, arg_5_2)
end

function var_0_0.getMO(arg_6_0)
	local var_6_0 = FightDataHelper.entityMgr:getById(arg_6_0.id)

	arg_6_0.entityMO = var_6_0 or arg_6_0.entityMO

	return var_6_0 or arg_6_0.entityMO
end

function var_0_0.getSide(arg_7_0)
	local var_7_0 = arg_7_0:getMO()

	if var_7_0 then
		return var_7_0.side
	end

	return FightEnum.EntitySide.BothSide
end

function var_0_0.isMySide(arg_8_0)
	return arg_8_0:getSide() == FightEnum.EntitySide.MySide
end

function var_0_0.isEnemySide(arg_9_0)
	return arg_9_0:getSide() == FightEnum.EntitySide.EnemySide
end

function var_0_0.isActive(arg_10_0)
	return arg_10_0._isActive
end

function var_0_0.setRenderOrder(arg_11_0, arg_11_1)
	if arg_11_0.spine then
		arg_11_0.spine:setRenderOrder(arg_11_1)
	end
end

function var_0_0.loadSpine(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0.spine then
		if arg_12_0.spine:getSpineGO() then
			arg_12_0:initHangPointDict()
		end

		arg_12_0._callback = arg_12_1
		arg_12_0._callbackObj = arg_12_2

		arg_12_0.spine:setResPath(arg_12_3 or arg_12_0:getSpineUrl(), arg_12_0._onSpineLoaded, arg_12_0)
	end
end

function var_0_0.getSpineUrl(arg_13_0, arg_13_1)
	local var_13_0 = ResUrl.getSpineFightPrefabBySkin(arg_13_1 or arg_13_0:getMO():getSpineSkinCO())

	if FightHelper.XingTiSpineUrl2Special[var_13_0] and FightHelper.detectXingTiSpecialUrl(arg_13_0) then
		var_13_0 = FightHelper.XingTiSpineUrl2Special[var_13_0]
	end

	return var_13_0
end

function var_0_0._onSpineLoaded(arg_14_0, arg_14_1)
	if arg_14_0.spineRenderer then
		arg_14_0.spineRenderer:setSpine(arg_14_1)
	end

	arg_14_0:registClasses()

	if arg_14_0._callback then
		if arg_14_0._callbackObj then
			arg_14_0._callback(arg_14_0._callbackObj, arg_14_1, arg_14_0)
		else
			arg_14_0._callback(arg_14_1, arg_14_0)
		end
	end

	arg_14_0._callback = nil
	arg_14_0._callbackObj = nil

	arg_14_0:setupLookAtCamera()
end

function var_0_0.setupLookAtCamera(arg_15_0)
	if arg_15_0.needLookCamera then
		ZProj.TransformListener.Get(arg_15_0.go):AddPositionCallback(arg_15_0._onTransformChange, arg_15_0)
	end
end

function var_0_0._onTransformChange(arg_16_0)
	GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:adjustSpineLookRotation(arg_16_0)
end

function var_0_0.setActive(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 or arg_17_1 ~= arg_17_0._isActive then
		arg_17_0._isActive = arg_17_1

		gohelper.setActive(arg_17_0.go, arg_17_0._isActive)

		local var_17_0 = arg_17_0:getCompList()

		if var_17_0 then
			for iter_17_0, iter_17_1 in ipairs(var_17_0) do
				if iter_17_1.setActive then
					iter_17_1:setActive(arg_17_1)
				end
			end
		end
	end
end

function var_0_0.setVisibleByPos(arg_18_0, arg_18_1)
	if not arg_18_0.go then
		logError("找不到entity实体GameObject~~~~~~~~~~~~~~~~~~~~~")

		return
	end

	if arg_18_1 then
		arg_18_0:resetStandPos()
	else
		transformhelper.setLocalPos(arg_18_0.go.transform, 9999, 9999, 9999)
	end
end

function var_0_0.setAlpha(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.marked_alpha = arg_19_1

	if arg_19_0.spineRenderer then
		arg_19_0.spineRenderer:setAlpha(arg_19_1, arg_19_2)
	end

	if arg_19_0.buff then
		if arg_19_1 == 0 then
			arg_19_0.buff:hideBuffEffects()
		elseif arg_19_1 == 1 then
			arg_19_0.buff:showBuffEffects()
		end
	end

	if arg_19_0.skinSpineEffect then
		if arg_19_1 == 0 then
			arg_19_0.skinSpineEffect:hideEffects()
		else
			arg_19_0.skinSpineEffect:showEffects()
		end
	end

	if arg_19_0.effect then
		if arg_19_1 == 0 then
			arg_19_0.effect:hideSpecialEffects()
		else
			arg_19_0.effect:showSpecialEffects()
		end
	end

	FightController.instance:dispatchEvent(FightEvent.SetEntityAlpha, arg_19_0.id, arg_19_1 ~= 0)
end

function var_0_0.resetEntity(arg_20_0)
	if gohelper.isNil(arg_20_0.go) then
		return
	end

	local var_20_0 = arg_20_0:getMO()

	if var_20_0 then
		if FightEntityDataHelper.isPlayerUid(var_20_0.id) then
			return
		end

		if arg_20_0.skill and arg_20_0.skill:sameSkillPlaying() then
			return
		end

		local var_20_1 = FightHelper.getEntitySpineLookDir(var_20_0)

		if arg_20_0.spine then
			arg_20_0.spine:changeLookDir(var_20_1)
		end

		arg_20_0:resetAnimState()
		arg_20_0:resetSpineMat()
		arg_20_0:resetStandPos()
		arg_20_0:resetSpineRotate()

		local var_20_2, var_20_3, var_20_4, var_20_5 = FightHelper.getEntityStandPos(var_20_0)

		arg_20_0:setScale(var_20_5)
	end
end

function var_0_0.resetAnimState(arg_21_0)
	if arg_21_0.isDead then
		return
	end

	local var_21_0 = arg_21_0:getDefaultAnim()

	if not string.nilorempty(var_21_0) and arg_21_0.spine then
		arg_21_0.spine:removeAnimEventCallback(arg_21_0._onChange2AnimEvent, arg_21_0)

		local var_21_1 = SpineAnimState.change2

		if var_21_0 == SpineAnimState.idle1 and arg_21_0.spine:getAnimState() == SpineAnimState.posture and arg_21_0.spine:hasAnimation(var_21_1) then
			arg_21_0.spine:addAnimEventCallback(arg_21_0._onChange2AnimEvent, arg_21_0)
			arg_21_0.spine:play(var_21_1, false, true)
		elseif arg_21_0.spine:hasAnimation(var_21_0) then
			arg_21_0.spine:play(var_21_0, true, false)
		else
			arg_21_0.spine:play(SpineAnimState.idle1, true, true)
		end
	end
end

function var_0_0._onChange2AnimEvent(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if (arg_22_0.spine and arg_22_0.spine:getAnimState()) == arg_22_1 and arg_22_1 == SpineAnimState.change2 and arg_22_2 == SpineAnimEvent.ActionComplete then
		arg_22_0.spine:removeAnimEventCallback(arg_22_0._onChange2AnimEvent, arg_22_0)
		arg_22_0.spine:play(SpineAnimState.idle1, true, true)
	end
end

function var_0_0.resetStandPos(arg_23_0)
	local var_23_0 = arg_23_0:getMO()

	if var_23_0 and not gohelper.isNil(arg_23_0.go) then
		transformhelper.setLocalPos(arg_23_0.go.transform, FightHelper.getEntityStandPos(var_23_0))
	end
end

function var_0_0.resetSpineRotate(arg_24_0)
	local var_24_0 = arg_24_0.spine and arg_24_0.spine:getSpineTr()

	if not gohelper.isNil(var_24_0) then
		transformhelper.setLocalRotation(var_24_0, 0, 0, 0)
	end
end

function var_0_0.resetSpineMat(arg_25_0)
	if not arg_25_0.spine or not arg_25_0.spine:getSpineGO() then
		return
	end

	local var_25_0 = arg_25_0:getDefaultMatName()

	if var_25_0 then
		if not string.nilorempty(var_25_0) and var_25_0 ~= arg_25_0._curMatName then
			arg_25_0._curMatName = var_25_0

			local var_25_1 = FightSpineMatPool.getMat(var_25_0)

			if var_25_1 then
				var_25_1.name = var_25_0

				arg_25_0.spineRenderer:replaceSpineMat(var_25_1)
			end
		end
	else
		arg_25_0._curMatName = nil

		arg_25_0.spineRenderer:resetSpineMat()
	end

	FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, arg_25_0.id, arg_25_0.spineRenderer:getReplaceMat())
end

function var_0_0.getScale(arg_26_0)
	local var_26_0, var_26_1, var_26_2 = transformhelper.getLocalScale(arg_26_0.go.transform)

	return var_26_0
end

function var_0_0.setScale(arg_27_0, arg_27_1)
	transformhelper.setLocalScale(arg_27_0.go.transform, arg_27_1, arg_27_1, arg_27_1)
end

function var_0_0.setSpeed(arg_28_0, arg_28_1)
	if arg_28_0.spine then
		arg_28_0.spine:setTimeScale(arg_28_1)
	end

	if arg_28_0.mover then
		arg_28_0.mover:setTimeScale(arg_28_1)
	end

	if arg_28_0.parabolaMover then
		arg_28_0.parabolaMover:setTimeScale(arg_28_1)
	end

	if arg_28_0.bezierMover then
		arg_28_0.bezierMover:setTimeScale(arg_28_1)
	end

	if arg_28_0.curveMover then
		arg_28_0.curveMover:setTimeScale(arg_28_1)
	end

	if arg_28_0.skill then
		arg_28_0.skill:setTimeScale(arg_28_1)
	end

	if arg_28_0.effect then
		arg_28_0.effect:setTimeScale(arg_28_1)
	end
end

function var_0_0.getDefaultAnim(arg_29_0)
	local var_29_0 = arg_29_0:getBuffAnim()

	if var_29_0 then
		return var_29_0
	end

	if FightModel.instance:getCurStage() == FightEnum.Stage.Play and FightPlayCardModel.instance:isPlayerHasSkillToPlay(arg_29_0.id) then
		return SpineAnimState.posture
	end

	return SpineAnimState.idle1
end

function var_0_0.getBuffAnim(arg_30_0)
	if arg_30_0.buff then
		local var_30_0 = arg_30_0.buff:getBuffAnim()

		if var_30_0 then
			return var_30_0
		end
	end
end

function var_0_0.getDefaultMatName(arg_31_0)
	if arg_31_0.buff then
		return arg_31_0.buff:getBuffMatName()
	end
end

function var_0_0.playBeHitMatEffect(arg_32_0, arg_32_1)
	if arg_32_0.spine then
		local var_32_0 = arg_32_0.spineRenderer:getReplaceMat()

		if not gohelper.isNil(var_32_0) then
			var_32_0:EnableKeyword("_BEHIT_ON")
			TaskDispatcher.cancelTask(arg_32_0._delayDisableBeHit, arg_32_0)

			if arg_32_1 > 0 then
				arg_32_0._beHitMat = var_32_0

				TaskDispatcher.runDelay(arg_32_0._delayDisableBeHit, arg_32_0, arg_32_1)
			else
				var_32_0:DisableKeyword("_BEHIT_ON")
				logError("play be hit error, duration < 0")
			end
		end
	end
end

function var_0_0._delayDisableBeHit(arg_33_0)
	if not gohelper.isNil(arg_33_0._beHitMat) then
		arg_33_0._beHitMat:DisableKeyword("_BEHIT_ON")

		arg_33_0._beHitMat = nil
	end
end

function var_0_0.beforeDestroy(arg_34_0)
	if arg_34_0._hasDestroy then
		return
	end

	arg_34_0._hasDestroy = true

	arg_34_0:releaseClasses()

	if arg_34_0.spine then
		arg_34_0.spine:removeAnimEventCallback(arg_34_0._onChange2AnimEvent, arg_34_0)
	end

	FightRenderOrderMgr.instance:unregister(arg_34_0.id)
	TaskDispatcher.cancelTask(arg_34_0._delayDisableBeHit, arg_34_0)

	local var_34_0 = arg_34_0:getCompList()

	if var_34_0 then
		for iter_34_0, iter_34_1 in ipairs(var_34_0) do
			if iter_34_1.beforeDestroy then
				iter_34_1:beforeDestroy()
			end
		end
	end

	GameSceneMgr.instance:getCurScene().bloom:removeEntity(arg_34_0)

	if arg_34_0.go then
		ZProj.TransformListener.Get(arg_34_0.go):RemovePositionCallback()
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeEntityDestroy, arg_34_0)
end

function var_0_0.getHangPoint(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0._hangPointDict[arg_35_1]

	if var_35_0 then
		return var_35_0
	else
		local var_35_1 = arg_35_0.spine and arg_35_0.spine:getSpineGO()

		if not var_35_1 then
			return arg_35_0.go
		end

		local var_35_2 = arg_35_0.go

		if not string.nilorempty(arg_35_1) then
			local var_35_3
			local var_35_4 = gohelper.findChild(var_35_1, ModuleEnum.SpineHangPointRoot)

			if arg_35_1 == ModuleEnum.SpineHangPointRoot then
				var_35_3 = var_35_4
			elseif string.find(arg_35_1, ModuleEnum.SpineHangPoint.BodyStatic) then
				var_35_3 = gohelper.create3d(var_35_4, arg_35_1)

				transformhelper.setLocalPos(var_35_3.transform, FightHelper.getEntityLocalCenterPos(arg_35_0))
			elseif string.find(arg_35_1, ModuleEnum.SpineHangPoint.HeadStatic) then
				var_35_3 = gohelper.create3d(var_35_4, arg_35_1)

				transformhelper.setLocalPos(var_35_3.transform, FightHelper.getEntityLocalTopPos(arg_35_0))
			else
				var_35_3 = gohelper.findChild(var_35_4, arg_35_1)
			end

			if var_35_3 then
				var_35_2 = var_35_3
			else
				var_35_2 = var_35_4

				local var_35_5 = string.find(var_35_1.name, "(Clone)", 1)
				local var_35_6 = var_35_5 and string.sub(var_35_1.name, 1, var_35_5 - 2) or var_35_1.name

				if isDebugBuild then
					logError(var_35_6 .. " 缺少挂点: " .. arg_35_1)
				end
			end

			arg_35_0._hangPointDict[arg_35_1] = var_35_2
		end

		return var_35_2
	end
end

function var_0_0.initCompDone(arg_36_0)
	local var_36_0 = arg_36_0:getCompList()

	if var_36_0 then
		for iter_36_0, iter_36_1 in ipairs(var_36_0) do
			if iter_36_1.onInitCompDone then
				iter_36_1:onInitCompDone()
			end
		end
	end
end

function var_0_0.getSpineClass(arg_37_0)
	return FightUnitSpine
end

function var_0_0.registClasses(arg_38_0)
	local var_38_0 = arg_38_0:getMO()

	if not var_38_0 then
		return
	end

	if FightEntityDataHelper.isPlayerUid(var_38_0.id) then
		return
	end

	if arg_38_0._instantiateClass then
		return
	end

	arg_38_0._instantiateClass = {}

	arg_38_0:newClass(FightEntitySummonedComp, arg_38_0)
	arg_38_0:newClass(FightEntityBuffSpecialPrecessComp, arg_38_0)
end

function var_0_0.newClass(arg_39_0, arg_39_1, ...)
	local var_39_0 = arg_39_1.New(...)

	table.insert(arg_39_0._instantiateClass, var_39_0)

	return var_39_0
end

function var_0_0.releaseClasses(arg_40_0)
	if arg_40_0._instantiateClass then
		for iter_40_0, iter_40_1 in ipairs(arg_40_0._instantiateClass) do
			if not iter_40_1.INVOKEDDISPOSE then
				iter_40_1:disposeSelf()
			end
		end
	end

	arg_40_0._instantiateClass = nil
end

return var_0_0
