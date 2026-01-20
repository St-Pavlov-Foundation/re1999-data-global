-- chunkname: @modules/logic/fight/entity/BaseFightEntity.lua

module("modules.logic.fight.entity.BaseFightEntity", package.seeall)

local BaseFightEntity = class("BaseFightEntity", BaseUnitSpawn)

function BaseFightEntity:ctor(entityId)
	self.id = entityId
	self._isActive = true
	self.isDead = false
	self.deadBySkillId = nil
	self.needLookCamera = true
	self.createStage = FightEnum.EntityCreateStage.None
end

function BaseFightEntity:init(go)
	BaseFightEntity.super.init(self, go)
	self:initHangPointDict()
	FightRenderOrderMgr.instance:register(self.id)
end

function BaseFightEntity:initHangPointDict()
	self._hangPointDict = self:getUserDataTb_()
end

function BaseFightEntity:setCreateStage(stage)
	self.createStage = stage
end

function BaseFightEntity:getCreateStage()
	return self.createStage
end

function BaseFightEntity:initComponents()
	self:addComp("spine", self:getSpineClass())
	self:addComp("spineRenderer", UnitSpineRenderer)
	self:addComp("mover", UnitMoverEase)
	self:addComp("parabolaMover", UnitMoverParabola)
	self:addComp("bezierMover", UnitMoverBezier)
	self:addComp("curveMover", UnitMoverCurve)
	self:addComp("moveHandler", UnitMoverHandler)
	self:addComp("skill", FightSkillComp)
	self:addComp("effect", FightEffectComp)
	self:addComp("buff", FightBuffComp)
	self:addComp("skinSpineAction", FightSkinSpineAction)
	self:addComp("skinSpineEffect", FightSkinSpineEffect)
	self:addComp("totalDamage", FightTotalDamageComp)
	self:addComp("uniqueEffect", FightUniqueEffectComp)
	self:addComp("skinCustomComp", FightSkinCustomComp)

	local mo = self:getMO()

	if BossRushController.instance:isInBossRushInfiniteFight(true) then
		self:addComp("nameUI", BossRushFightNameUI)
	elseif mo:isAssistBoss() then
		-- block empty
	elseif mo:isAct191Boss() then
		-- block empty
	else
		self:addComp("nameUI", FightNameUI)
	end

	self:initCompDone()
end

function BaseFightEntity:addComp(compName, compClass)
	if self.filterComp and self.filterComp[compName] then
		return
	end

	BaseFightEntity.super.addComp(self, compName, compClass)
end

function BaseFightEntity:getMO()
	local entityMO = FightDataHelper.entityMgr:getById(self.id)

	self.entityMO = entityMO or self.entityMO

	return entityMO or self.entityMO
end

function BaseFightEntity:getSide()
	local mo = self:getMO()

	if mo then
		return mo.side
	end

	return FightEnum.EntitySide.BothSide
end

function BaseFightEntity:isMySide()
	return self:getSide() == FightEnum.EntitySide.MySide
end

function BaseFightEntity:isEnemySide()
	return self:getSide() == FightEnum.EntitySide.EnemySide
end

function BaseFightEntity:isActive()
	return self._isActive
end

function BaseFightEntity:setRenderOrder(order)
	if self.spine then
		self.spine:setRenderOrder(order)
	end
end

function BaseFightEntity:loadSpine(callback, callbackObj, customUrl)
	if self.spine then
		if self.spine:getSpineGO() then
			self:initHangPointDict()
		end

		self._callback = callback
		self._callbackObj = callbackObj

		self.spine:setResPath(customUrl or self:getSpineUrl(), self._onSpineLoaded, self)
	end
end

function BaseFightEntity:getSpineUrl(skinConfig)
	local spinePath = ResUrl.getSpineFightPrefabBySkin(skinConfig or self:getMO():getSpineSkinCO())

	if FightHelper.XingTiSpineUrl2Special[spinePath] and FightHelper.detectXingTiSpecialUrl(self) then
		spinePath = FightHelper.XingTiSpineUrl2Special[spinePath]
	end

	return spinePath
end

function BaseFightEntity:_onSpineLoaded(spine)
	if self.spineRenderer then
		self.spineRenderer:setSpine(spine)
	end

	self:registClasses()

	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj, spine, self)
		else
			self._callback(spine, self)
		end
	end

	self._callback = nil
	self._callbackObj = nil

	self:setupLookAtCamera()
end

function BaseFightEntity:setupLookAtCamera()
	if self.needLookCamera then
		local transformListener = ZProj.TransformListener.Get(self.go)

		transformListener:AddPositionCallback(self._onTransformChange, self)
	end
end

function BaseFightEntity:_onTransformChange()
	local entityMgr = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr

	entityMgr:adjustSpineLookRotation(self)
end

function BaseFightEntity:setActive(isActive, isForce)
	if isForce or isActive ~= self._isActive then
		self._isActive = isActive

		gohelper.setActive(self.go, self._isActive)

		local compList = self:getCompList()

		if compList then
			for _, comp in ipairs(compList) do
				if comp.setActive then
					comp:setActive(isActive)
				end
			end
		end
	end
end

function BaseFightEntity:setVisibleByPos(isVisible)
	if not self.go then
		logError("找不到entity实体GameObject~~~~~~~~~~~~~~~~~~~~~")

		return
	end

	if isVisible then
		self:resetStandPos()
	else
		transformhelper.setLocalPos(self.go.transform, 9999, 9999, 9999)
	end
end

function BaseFightEntity:setAlpha(alpha, duration)
	self.marked_alpha = alpha

	if self.spineRenderer then
		self.spineRenderer:setAlpha(alpha, duration)
	end

	if self.buff then
		if alpha == 0 then
			self.buff:hideBuffEffects()
		elseif alpha == 1 then
			self.buff:showBuffEffects()
		end
	end

	if self.skinSpineEffect then
		if alpha == 0 then
			self.skinSpineEffect:hideEffects()
		else
			self.skinSpineEffect:showEffects()
		end
	end

	if self.effect then
		if alpha == 0 then
			self.effect:hideSpecialEffects()
		else
			self.effect:showSpecialEffects()
		end
	end

	FightController.instance:dispatchEvent(FightEvent.SetEntityAlpha, self.id, alpha ~= 0)
end

function BaseFightEntity:resetEntity()
	if gohelper.isNil(self.go) then
		return
	end

	local mo = self:getMO()

	if not mo then
		return
	end

	if mo:isRouge2Music() then
		return
	end

	if mo:isVorpalith() then
		return
	end

	if FightEntityDataHelper.isPlayerUid(mo.id) then
		return
	end

	if self.skill and self.skill:sameSkillPlaying() then
		return
	end

	local lookDir = FightHelper.getEntitySpineLookDir(mo)

	if self.spine then
		self.spine:changeLookDir(lookDir)
	end

	self:resetAnimState()
	self:resetSpineMat()
	self:resetStandPos()
	self:resetSpineRotate()

	local _, _, _, scale = FightHelper.getEntityStandPos(mo)

	self:setScale(scale)
end

function BaseFightEntity:resetAnimState()
	if self.isDead then
		return
	end

	local animName = self:getDefaultAnim()

	if not string.nilorempty(animName) and self.spine then
		self.spine:removeAnimEventCallback(self._onChange2AnimEvent, self)

		local change2 = SpineAnimState.change2

		if animName == SpineAnimState.idle1 and self.spine:getAnimState() == SpineAnimState.posture and self.spine:hasAnimation(change2) then
			self.spine:addAnimEventCallback(self._onChange2AnimEvent, self)
			self.spine:play(change2, false, true)
		elseif self.spine:hasAnimation(animName) then
			self.spine:play(animName, true, false)
		else
			self.spine:play(SpineAnimState.idle1, true, true)
		end
	end
end

function BaseFightEntity:_onChange2AnimEvent(actionName, eventName, eventArgs)
	local curAniName = self.spine and self.spine:getAnimState()

	if curAniName == actionName and actionName == SpineAnimState.change2 and eventName == SpineAnimEvent.ActionComplete then
		self.spine:removeAnimEventCallback(self._onChange2AnimEvent, self)
		self.spine:play(SpineAnimState.idle1, true, true)
	end
end

function BaseFightEntity:resetStandPos()
	local mo = self:getMO()

	if mo and not gohelper.isNil(self.go) then
		transformhelper.setLocalPos(self.go.transform, FightHelper.getEntityStandPos(mo))
	end
end

function BaseFightEntity:resetSpineRotate()
	local spineTr = self.spine and self.spine:getSpineTr()

	if not gohelper.isNil(spineTr) then
		transformhelper.setLocalRotation(spineTr, 0, 0, 0)
	end
end

function BaseFightEntity:resetSpineMat()
	if not self.spine or not self.spine:getSpineGO() then
		return
	end

	local matName = self:getDefaultMatName()

	if matName then
		if not string.nilorempty(matName) and matName ~= self._curMatName then
			self._curMatName = matName

			local newMat = FightSpineMatPool.getMat(matName)

			if newMat then
				newMat.name = matName

				self.spineRenderer:replaceSpineMat(newMat)
			end
		end
	else
		self._curMatName = nil

		self.spineRenderer:resetSpineMat()
	end

	FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, self.id, self.spineRenderer:getReplaceMat())
end

function BaseFightEntity:getScale()
	local x, _, _ = transformhelper.getLocalScale(self.go.transform)

	return x
end

function BaseFightEntity:setScale(scale)
	if gohelper.isNil(self.go) then
		return
	end

	transformhelper.setLocalScale(self.go.transform, scale, scale, scale)
end

function BaseFightEntity:setSpeed(speed)
	if self.spine then
		self.spine:setTimeScale(speed)
	end

	if self.mover then
		self.mover:setTimeScale(speed)
	end

	if self.parabolaMover then
		self.parabolaMover:setTimeScale(speed)
	end

	if self.bezierMover then
		self.bezierMover:setTimeScale(speed)
	end

	if self.curveMover then
		self.curveMover:setTimeScale(speed)
	end

	if self.skill then
		self.skill:setTimeScale(speed)
	end

	if self.effect then
		self.effect:setTimeScale(speed)
	end
end

function BaseFightEntity:getDefaultAnim()
	local buffAnim = self:getBuffAnim()

	if buffAnim then
		return buffAnim
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play and FightPlayCardModel.instance:isPlayerHasSkillToPlay(self.id) then
		return SpineAnimState.posture
	end

	return SpineAnimState.idle1
end

function BaseFightEntity:getBuffAnim()
	if self.buff then
		local buffAnim = self.buff:getBuffAnim()

		if buffAnim then
			return buffAnim
		end
	end
end

function BaseFightEntity:getDefaultMatName()
	if self.buff then
		return self.buff:getBuffMatName()
	end
end

function BaseFightEntity:playBeHitMatEffect(duration)
	if self.spine then
		local spineMat = self.spineRenderer:getReplaceMat()

		if not gohelper.isNil(spineMat) then
			spineMat:EnableKeyword("_BEHIT_ON")
			TaskDispatcher.cancelTask(self._delayDisableBeHit, self)

			if duration > 0 then
				self._beHitMat = spineMat

				TaskDispatcher.runDelay(self._delayDisableBeHit, self, duration)
			else
				spineMat:DisableKeyword("_BEHIT_ON")
				logError("play be hit error, duration < 0")
			end
		end
	end
end

function BaseFightEntity:_delayDisableBeHit()
	if not gohelper.isNil(self._beHitMat) then
		self._beHitMat:DisableKeyword("_BEHIT_ON")

		self._beHitMat = nil
	end
end

function BaseFightEntity:beforeDestroy()
	if self._hasDestroy then
		return
	end

	self._hasDestroy = true

	self:releaseClasses()

	if self.spine then
		self.spine:removeAnimEventCallback(self._onChange2AnimEvent, self)
	end

	FightRenderOrderMgr.instance:unregister(self.id)
	TaskDispatcher.cancelTask(self._delayDisableBeHit, self)

	local compList = self:getCompList()

	if compList then
		for _, comp in ipairs(compList) do
			if comp.beforeDestroy then
				comp:beforeDestroy()
			end
		end
	end

	FightGameMgr.bloomMgr:removeEntity(self)

	if self.go then
		local transformListener = ZProj.TransformListener.Get(self.go)

		transformListener:RemovePositionCallback()
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeEntityDestroy, self)
end

function BaseFightEntity:getHangPoint(hangPointName, noProcess)
	local existHangPoint = self._hangPointDict[hangPointName]

	if existHangPoint then
		return existHangPoint
	else
		local spineGO = self.spine and self.spine:getSpineGO()

		if not spineGO then
			return self.go
		end

		local hangPointGO = self.go

		if not string.nilorempty(hangPointName) then
			local findHangPointGO
			local hangPointRootGO = gohelper.findChild(spineGO, ModuleEnum.SpineHangPointRoot)

			if hangPointName == ModuleEnum.SpineHangPointRoot then
				findHangPointGO = hangPointRootGO
			elseif string.find(hangPointName, ModuleEnum.SpineHangPoint.BodyStatic) then
				findHangPointGO = gohelper.create3d(hangPointRootGO, hangPointName)

				transformhelper.setLocalPos(findHangPointGO.transform, FightHelper.getEntityLocalCenterPos(self))
			elseif string.find(hangPointName, ModuleEnum.SpineHangPoint.HeadStatic) then
				findHangPointGO = gohelper.create3d(hangPointRootGO, hangPointName)

				transformhelper.setLocalPos(findHangPointGO.transform, FightHelper.getEntityLocalTopPos(self))
			else
				findHangPointGO = gohelper.findChild(hangPointRootGO, hangPointName)
			end

			if findHangPointGO then
				hangPointGO = findHangPointGO
			else
				hangPointGO = hangPointRootGO

				local begin = string.find(spineGO.name, "(Clone)", 1)
				local spineName = begin and string.sub(spineGO.name, 1, begin - 2) or spineGO.name

				if isDebugBuild then
					logError(spineName .. " 缺少挂点: " .. hangPointName)
				end
			end

			self._hangPointDict[hangPointName] = hangPointGO
		end

		return hangPointGO
	end
end

function BaseFightEntity:initCompDone()
	local compList = self:getCompList()

	if compList then
		for _, comp in ipairs(compList) do
			if comp.onInitCompDone then
				comp:onInitCompDone()
			end
		end
	end
end

function BaseFightEntity:getSpineClass()
	return FightUnitSpine
end

function BaseFightEntity:registClasses()
	local entityMO = self:getMO()

	if not entityMO then
		return
	end

	if FightEntityDataHelper.isPlayerUid(entityMO.id) then
		return
	end

	if self._instantiateClass then
		return
	end

	self._instantiateClass = {}

	self:newClass(FightEntitySummonedComp, self)
	self:newClass(FightEntityBuffSpecialPrecessComp, self)
end

function BaseFightEntity:newClass(class, ...)
	local obj = class.New(...)

	table.insert(self._instantiateClass, obj)

	return obj
end

function BaseFightEntity:releaseClasses()
	if self._instantiateClass then
		for i, v in ipairs(self._instantiateClass) do
			if not v.INVOKEDDISPOSE then
				v:disposeSelf()
			end
		end
	end

	self._instantiateClass = nil
end

return BaseFightEntity
