module("modules.logic.fight.entity.BaseFightEntity", package.seeall)

slot0 = class("BaseFightEntity", BaseUnitSpawn)

function slot0.ctor(slot0, slot1)
	slot0.id = slot1
	slot0._isActive = true
	slot0.isDead = false
	slot0.deadBySkillId = nil
	slot0.needLookCamera = true
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
	slot0:initHangPointDict()
	FightRenderOrderMgr.instance:register(slot0.id)
end

function slot0.initHangPointDict(slot0)
	slot0._hangPointDict = slot0:getUserDataTb_()
end

function slot0.initComponents(slot0)
	slot0:addComp("spine", slot0:getSpineClass())
	slot0:addComp("spineRenderer", UnitSpineRenderer)
	slot0:addComp("mover", UnitMoverEase)
	slot0:addComp("parabolaMover", UnitMoverParabola)
	slot0:addComp("bezierMover", UnitMoverBezier)
	slot0:addComp("curveMover", UnitMoverCurve)
	slot0:addComp("moveHandler", UnitMoverHandler)
	slot0:addComp("skill", FightSkillComp)
	slot0:addComp("effect", FightEffectComp)
	slot0:addComp("buff", FightBuffComp)
	slot0:addComp("skinSpineAction", FightSkinSpineAction)
	slot0:addComp("skinSpineEffect", FightSkinSpineEffect)
	slot0:addComp("totalDamage", FightTotalDamageComp)

	if BossRushController.instance:isInBossRushInfiniteFight(true) then
		slot0:addComp("nameUI", BossRushFightNameUI)
	else
		slot0:addComp("nameUI", FightNameUI)
	end

	slot0:initCompDone()
end

function slot0.addComp(slot0, slot1, slot2)
	if slot0.filterComp and slot0.filterComp[slot1] then
		return
	end

	uv0.super.addComp(slot0, slot1, slot2)
end

function slot0.getMO(slot0)
	slot0.entityMO = FightEntityModel.instance:getById(slot0.id) or slot0.entityMO

	return slot1 or slot0.entityMO
end

function slot0.getSide(slot0)
	if slot0:getMO() then
		return slot1.side
	end

	return FightEnum.EntitySide.BothSide
end

function slot0.isMySide(slot0)
	return slot0:getSide() == FightEnum.EntitySide.MySide
end

function slot0.isEnemySide(slot0)
	return slot0:getSide() == FightEnum.EntitySide.EnemySide
end

function slot0.isActive(slot0)
	return slot0._isActive
end

function slot0.setRenderOrder(slot0, slot1)
	if slot0.spine then
		slot0.spine:setRenderOrder(slot1)
	end
end

function slot0.loadSpine(slot0, slot1, slot2, slot3)
	if slot0.spine then
		if slot0.spine:getSpineGO() then
			slot0:initHangPointDict()
		end

		slot0._callback = slot1
		slot0._callbackObj = slot2

		slot0.spine:setResPath(slot3 or slot0:getSpineUrl(), slot0._onSpineLoaded, slot0)
	end
end

function slot0.getSpineUrl(slot0, slot1)
	if FightHelper.XingTiSpineUrl2Special[ResUrl.getSpineFightPrefabBySkin(slot1 or slot0:getMO():getSpineSkinCO())] and FightHelper.detectXingTiSpecialUrl(slot0) then
		slot2 = FightHelper.XingTiSpineUrl2Special[slot2]
	end

	return slot2
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot0.spineRenderer then
		slot0.spineRenderer:setSpine(slot1)
	end

	slot0:registClasses()

	if slot0._callback then
		if slot0._callbackObj then
			slot0._callback(slot0._callbackObj, slot1, slot0)
		else
			slot0._callback(slot1, slot0)
		end
	end

	slot0._callback = nil
	slot0._callbackObj = nil

	slot0:setupLookAtCamera()
end

function slot0.setupLookAtCamera(slot0)
	if slot0.needLookCamera then
		ZProj.TransformListener.Get(slot0.go):AddPositionCallback(slot0._onTransformChange, slot0)
	end
end

function slot0._onTransformChange(slot0)
	GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:adjustSpineLookRotation(slot0)
end

function slot0.setActive(slot0, slot1, slot2)
	if slot2 or slot1 ~= slot0._isActive then
		slot0._isActive = slot1

		gohelper.setActive(slot0.go, slot0._isActive)

		if slot0:getCompList() then
			for slot7, slot8 in ipairs(slot3) do
				if slot8.setActive then
					slot8:setActive(slot1)
				end
			end
		end
	end
end

function slot0.setVisibleByPos(slot0, slot1)
	if not slot0.go then
		logError("找不到entity实体GameObject~~~~~~~~~~~~~~~~~~~~~")

		return
	end

	if slot1 then
		slot0:resetStandPos()
	else
		transformhelper.setLocalPos(slot0.go.transform, 9999, 9999, 9999)
	end
end

function slot0.setAlpha(slot0, slot1, slot2)
	slot0.marked_alpha = slot1

	if slot0.spineRenderer then
		slot0.spineRenderer:setAlpha(slot1, slot2)
	end

	if slot0.buff then
		if slot1 == 0 then
			slot0.buff:hideBuffEffects()
		elseif slot1 == 1 then
			slot0.buff:showBuffEffects()
		end
	end

	if slot0.skinSpineEffect then
		if slot1 == 0 then
			slot0.skinSpineEffect:hideEffects()
		else
			slot0.skinSpineEffect:showEffects()
		end
	end

	if slot0.effect then
		if slot1 == 0 then
			slot0.effect:hideSpecialEffects()
		else
			slot0.effect:showSpecialEffects()
		end
	end

	FightController.instance:dispatchEvent(FightEvent.SetEntityAlpha, slot0.id, slot1 ~= 0)
end

function slot0.resetEntity(slot0)
	if slot0:getMO() then
		if slot0.skill and slot0.skill:sameSkillPlaying() then
			return
		end

		if slot0.spine then
			slot0.spine:changeLookDir(FightHelper.getEntitySpineLookDir(slot1))
		end

		slot0:resetAnimState()
		slot0:resetSpineMat()
		slot0:resetStandPos()
		slot0:resetSpineRotate()

		slot3, slot4, slot5, slot6 = FightHelper.getEntityStandPos(slot1)

		slot0:setScale(slot6)
	end
end

function slot0.resetAnimState(slot0)
	if slot0.isDead then
		return
	end

	if not string.nilorempty(slot0:getDefaultAnim()) and slot0.spine then
		slot0.spine:removeAnimEventCallback(slot0._onChange2AnimEvent, slot0)

		slot2 = SpineAnimState.change2

		if slot1 == SpineAnimState.idle1 and slot0.spine:getAnimState() == SpineAnimState.posture and slot0.spine:hasAnimation(slot2) then
			slot0.spine:addAnimEventCallback(slot0._onChange2AnimEvent, slot0)
			slot0.spine:play(slot2, false, true)
		elseif slot0.spine:hasAnimation(slot1) then
			slot0.spine:play(slot1, true, false)
		else
			slot0.spine:play(SpineAnimState.idle1, true, true)
		end
	end
end

function slot0._onChange2AnimEvent(slot0, slot1, slot2, slot3)
	if slot1 == SpineAnimState.change2 and slot2 == SpineAnimEvent.ActionComplete then
		slot0.spine:removeAnimEventCallback(slot0._onChange2AnimEvent, slot0)
		slot0.spine:play(SpineAnimState.idle1, true, true)
	end
end

function slot0.resetStandPos(slot0)
	if slot0:getMO() then
		transformhelper.setLocalPos(slot0.go.transform, FightHelper.getEntityStandPos(slot1))
	end
end

function slot0.resetSpineRotate(slot0)
	if not gohelper.isNil(slot0.spine and slot0.spine:getSpineTr()) then
		transformhelper.setLocalRotation(slot1, 0, 0, 0)
	end
end

function slot0.resetSpineMat(slot0)
	if not slot0.spine or not slot0.spine:getSpineGO() then
		return
	end

	if slot0:getDefaultMatName() then
		if not string.nilorempty(slot1) and slot1 ~= slot0._curMatName then
			slot0._curMatName = slot1

			if FightSpineMatPool.getMat(slot1) then
				slot2.name = slot1

				slot0.spineRenderer:replaceSpineMat(slot2)
			end
		end
	else
		slot0._curMatName = nil

		slot0.spineRenderer:resetSpineMat()
	end

	FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, slot0.id, slot0.spineRenderer:getReplaceMat())
end

function slot0.getScale(slot0)
	slot1, slot2, slot3 = transformhelper.getLocalScale(slot0.go.transform)

	return slot1
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.go.transform, slot1, slot1, slot1)
end

function slot0.setSpeed(slot0, slot1)
	if slot0.spine then
		slot0.spine:setTimeScale(slot1)
	end

	if slot0.mover then
		slot0.mover:setTimeScale(slot1)
	end

	if slot0.parabolaMover then
		slot0.parabolaMover:setTimeScale(slot1)
	end

	if slot0.bezierMover then
		slot0.bezierMover:setTimeScale(slot1)
	end

	if slot0.curveMover then
		slot0.curveMover:setTimeScale(slot1)
	end

	if slot0.skill then
		slot0.skill:setTimeScale(slot1)
	end

	if slot0.effect then
		slot0.effect:setTimeScale(slot1)
	end
end

function slot0.getDefaultAnim(slot0)
	if slot0:getBuffAnim() then
		return slot1
	end

	if FightModel.instance:getCurStage() == FightEnum.Stage.Play and FightPlayCardModel.instance:isPlayerHasSkillToPlay(slot0.id) then
		return SpineAnimState.posture
	end

	return SpineAnimState.idle1
end

function slot0.getBuffAnim(slot0)
	if slot0.buff and slot0.buff:getBuffAnim() then
		return slot1
	end
end

function slot0.getDefaultMatName(slot0)
	if slot0.buff then
		return slot0.buff:getBuffMatName()
	end
end

function slot0.playBeHitMatEffect(slot0, slot1)
	if slot0.spine and not gohelper.isNil(slot0.spineRenderer:getReplaceMat()) then
		slot2:EnableKeyword("_BEHIT_ON")
		TaskDispatcher.cancelTask(slot0._delayDisableBeHit, slot0)

		if slot1 > 0 then
			slot0._beHitMat = slot2

			TaskDispatcher.runDelay(slot0._delayDisableBeHit, slot0, slot1)
		else
			slot2:DisableKeyword("_BEHIT_ON")
			logError("play be hit error, duration < 0")
		end
	end
end

function slot0._delayDisableBeHit(slot0)
	if not gohelper.isNil(slot0._beHitMat) then
		slot0._beHitMat:DisableKeyword("_BEHIT_ON")

		slot0._beHitMat = nil
	end
end

function slot0.beforeDestroy(slot0)
	if slot0._hasDestroy then
		return
	end

	slot0._hasDestroy = true

	slot0:releaseClasses()

	if slot0.spine then
		slot0.spine:removeAnimEventCallback(slot0._onChange2AnimEvent, slot0)
	end

	FightRenderOrderMgr.instance:unregister(slot0.id)
	TaskDispatcher.cancelTask(slot0._delayDisableBeHit, slot0)

	if slot0:getCompList() then
		for slot5, slot6 in ipairs(slot1) do
			if slot6.beforeDestroy then
				slot6:beforeDestroy()
			end
		end
	end

	GameSceneMgr.instance:getCurScene().bloom:removeEntity(slot0)

	if slot0.go then
		ZProj.TransformListener.Get(slot0.go):RemovePositionCallback()
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeEntityDestroy, slot0)
end

function slot0.getHangPoint(slot0, slot1, slot2)
	if slot0._hangPointDict[slot1] then
		return slot3
	else
		if not (slot0.spine and slot0.spine:getSpineGO()) then
			return slot0.go
		end

		slot5 = slot0.go

		if not string.nilorempty(slot1) then
			slot6 = nil

			if slot1 == ModuleEnum.SpineHangPointRoot then
				slot6 = gohelper.findChild(slot4, ModuleEnum.SpineHangPointRoot)
			elseif string.find(slot1, ModuleEnum.SpineHangPoint.BodyStatic) then
				transformhelper.setLocalPos(gohelper.create3d(slot7, slot1).transform, FightHelper.getEntityLocalCenterPos(slot0))
			elseif string.find(slot1, ModuleEnum.SpineHangPoint.HeadStatic) then
				transformhelper.setLocalPos(gohelper.create3d(slot7, slot1).transform, FightHelper.getEntityLocalTopPos(slot0))
			else
				slot6 = gohelper.findChild(slot7, slot1)
			end

			if slot6 then
				slot5 = slot6
			else
				slot5 = slot7

				if isDebugBuild then
					logError((string.find(slot4.name, "(Clone)", 1) and string.sub(slot4.name, 1, slot8 - 2) or slot4.name) .. " 缺少挂点: " .. slot1)
				end
			end

			slot0._hangPointDict[slot1] = slot5
		end

		return slot5
	end
end

function slot0.initCompDone(slot0)
	if slot0:getCompList() then
		for slot5, slot6 in ipairs(slot1) do
			if slot6.onInitCompDone then
				slot6:onInitCompDone()
			end
		end
	end
end

function slot0.getSpineClass(slot0)
	return FightUnitSpine
end

function slot0.registClasses(slot0)
	if not slot0:getMO() then
		return
	end

	if slot0._instantiateClass then
		return
	end

	slot0._instantiateClass = {}

	slot0:registClass(FightEntitySummonedComp, slot0)
	slot0:registClass(FightEntityBuffSpecialPrecessComp, slot0)
end

function slot0.registClass(slot0, slot1, ...)
	slot2 = slot1.New(...)

	table.insert(slot0._instantiateClass, slot2)

	return slot2
end

function slot0.releaseClasses(slot0)
	if slot0._instantiateClass then
		for slot4, slot5 in ipairs(slot0._instantiateClass) do
			if not slot5.INVOKEDDISPOSE then
				slot5:disposeSelf()
			end
		end
	end

	slot0._instantiateClass = nil
end

return slot0
