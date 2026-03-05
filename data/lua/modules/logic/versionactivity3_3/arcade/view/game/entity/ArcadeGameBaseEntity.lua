-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/ArcadeGameBaseEntity.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.ArcadeGameBaseEntity", package.seeall)

local ArcadeGameBaseEntity = class("ArcadeGameBaseEntity", LuaCompBase)

function ArcadeGameBaseEntity:ctor(param)
	self.id = param.id
	self.uid = param.uid

	self:onCtor(param)
end

function ArcadeGameBaseEntity:init(go)
	self.go = go
	self.trans = self.go.transform
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)
	self.animator = self.go:GetComponent(gohelper.Type_Animation)
	self.goScale = gohelper.findChild(self.go, "ani/scale")
	self.transScale = self.goScale.transform
	self._playingStateAnimName = nil
	self._playingStateEffectDict = {}

	self:initComponents()

	local mo = self:getMO()
	local delayTime = mo and mo.delayTimeShow

	if delayTime and delayTime > 0 then
		gohelper.setActive(go, false)
		TaskDispatcher.runDelay(self._onDelayShow, self, delayTime)
	else
		self:playStateShow()
	end

	if mo then
		local scaleX, scaleY = mo:getScale()

		if scaleX and scaleY then
			transformhelper.setLocalScale(self.transScale, scaleX, scaleY, 1)
		end

		local posX, posY = mo:getPosOffset()

		if posX and posY then
			transformhelper.setLocalPosXY(self.transScale, posX, posY)
		end
	end
end

function ArcadeGameBaseEntity:initComponents()
	self:_clearComps()
	self:_addComp("effectComp", ArcadeEntityEffectComp, true)
	self:_addComp("bezierComp", ArcadeEntityBezierComp, false)

	local mo = self:getMO()
	local haveHpBar = mo and mo:getIsHaveHPBar()

	if haveHpBar then
		self:_addComp("hpComp", ArcadeGameHPComp, true)
	end
end

function ArcadeGameBaseEntity:_clearComps()
	if self._compList then
		for _, comp in ipairs(self._compList) do
			local compName = comp:getCompName()

			self[compName] = nil

			comp:clear()
		end
	end

	self._compList = {}
end

function ArcadeGameBaseEntity:_addComp(compName, compClass, useNewGO)
	local go = self.go

	if useNewGO then
		go = gohelper.create3d(self.go, compName)
	end

	local compInst = MonoHelper.addNoUpdateLuaComOnceToGo(go, compClass, {
		entity = self,
		compName = compName
	})

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function ArcadeGameBaseEntity:_onDelayShow()
	gohelper.setActive(self.go, true)
	self:playStateShow()
end

local DEFAULT_IDLE_ANIMA_NAME = "idle_loop"

function ArcadeGameBaseEntity:playStateShow()
	local mo = self:getMO()

	if not mo then
		return
	end

	local stateAnimName
	local effectIdList = mo:getStateEffectIdList()

	for _, effectId in ipairs(effectIdList) do
		if effectId and effectId ~= 0 then
			if not self._playingStateEffectDict[effectId] then
				if self.effectComp then
					self.effectComp:playEffect(effectId)
				end

				self._playingStateEffectDict[effectId] = true
			end

			local anim = ArcadeConfig.instance:getEffectAnim(effectId)

			if not string.nilorempty(anim) then
				stateAnimName = anim
			end
		end
	end

	if self.animatorPlayer then
		if string.nilorempty(stateAnimName) then
			stateAnimName = DEFAULT_IDLE_ANIMA_NAME
		end

		if self._playingStateAnimName ~= stateAnimName then
			self.animatorPlayer:Play(stateAnimName)

			self._playingStateAnimName = stateAnimName
		end
	end

	self:refreshDirection()
end

function ArcadeGameBaseEntity:stopStateLoopEffect(effectId)
	if not effectId or effectId == 0 then
		return
	end

	if self.effectComp then
		self.effectComp:removeEffect(effectId)
	end

	self._playingStateEffectDict[effectId] = nil

	self:playStateShow()
end

function ArcadeGameBaseEntity:playActionShow(showId, direction, showParam, cb, cbObj, cbParam)
	local mo = self:getMO()
	local isRemoving = mo and mo:getIsRemoving()

	if isRemoving then
		return
	end

	local effectIdList, bulletEffect = ArcadeGameHelper.getActionShowEffect(showId, showParam)

	self._actionEffectIdList = effectIdList

	if bulletEffect and bulletEffect ~= 0 and self.effectComp then
		self.effectComp:playBulletEffect(bulletEffect)
	end

	self._actionDirection = direction
	self._actionShowFinishCb = cb
	self._actionShowFinishCbObj = cbObj
	self._actionShowFinishCbParam = cbParam

	self:_playNextActionEffect()
	self:refreshDirection()
end

function ArcadeGameBaseEntity:_playNextActionEffect()
	if not self._actionEffectIdList or #self._actionEffectIdList <= 0 then
		ArcadeGameHelper.callCallbackFunc(self._actionShowFinishCb, self._actionShowFinishCbObj, self._actionShowFinishCbParam)
		self:_clearActionEffList()
		self:playStateShow()
	else
		local effectId = table.remove(self._actionEffectIdList, 1)

		self:_playActionEffect(effectId, self._actionDirection, self._playNextActionEffect, self)
	end
end

function ArcadeGameBaseEntity:_playActionEffect(effectId, animDir, animCb, animCbObj, animCbParam)
	local resName = ArcadeConfig.instance:getEffectResName(effectId)

	if string.nilorempty(resName) then
		local audioId = ArcadeConfig.instance:getEffectAudio(effectId)

		if audioId and audioId > 0 then
			AudioMgr.instance:trigger(audioId)
		end
	elseif self.effectComp then
		self.effectComp:playEffect(effectId)
	end

	local animName = ArcadeConfig.instance:getEffectAnim(effectId, animDir)

	if self.animatorPlayer and not string.nilorempty(animName) then
		self._playingStateAnimName = nil

		self.animatorPlayer:Play(animName, animCb, animCbObj, animCbParam)
	else
		ArcadeGameHelper.callCallbackFunc(animCb, animCbObj, animCbObj)
	end
end

function ArcadeGameBaseEntity:_clearActionEffList()
	self._actionDirection = nil
	self._actionShowFinishCb = nil
	self._actionShowFinishCbObj = nil
	self._actionShowFinishCbParam = nil
	self._actionEffectIdList = nil
end

function ArcadeGameBaseEntity:refreshPosition(isPlay, cb, cbObj, cbParam)
	local mo = self:getMO()

	if not mo then
		return
	end

	self:_killMoveTween()

	local gridX, gridY = mo:getGridPos()

	if gridX and gridY then
		if isPlay then
			self:_doMove(cb, cbObj, cbParam)
		else
			local x, y = ArcadeGameHelper.getGridPos(gridX, gridY)

			transformhelper.setLocalPos(self.trans, x, y, 0)
			self:refreshShowHpBar()
		end
	else
		local id = mo:getId()

		logError(string.format("ArcadeGameBaseEntity:refreshPosition error, no gridPos,id:%s", id))
	end
end

function ArcadeGameBaseEntity:_doMove(finishCb, finishCbObj, finishCbParam)
	local mo = self:getMO()

	if not mo then
		return
	end

	local gridX, gridY = mo:getGridPos()
	local targetPosX, targetPosY = ArcadeGameHelper.getGridPos(gridX, gridY)
	local curPosX, curPosY, curPosZ = self:getPosition(true)

	if curPosX == targetPosX and curPosY == targetPosY then
		ArcadeGameHelper.callCallbackFunc(finishCb, finishCbObj, finishCbParam)

		return
	end

	self:playActionShow(ArcadeGameEnum.ActionShowId.Move)
	self:_killMoveTween()

	self._finishMoveCb = finishCb
	self._finishMoveCbObj = finishCbObj
	self._finishMoveCbParam = finishCbParam
	self._moveTweenId = ZProj.TweenHelper.DOLocalMove(self.trans, targetPosX, targetPosY, curPosZ, ArcadeHallEnum.HeroMoveSpeed, self._onMoveTweenFinish, self, nil, EaseType.OutExpo)

	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnEntityTweenMove, mo:getEntityType(), mo:getUid(), true)
end

function ArcadeGameBaseEntity:_onMoveTweenFinish()
	self:refreshPosition()
	ArcadeGameHelper.callCallbackFunc(self._finishMoveCb, self._finishMoveCbObj, self._finishMoveCbParam)

	self._finishMoveCb = nil
	self._finishMoveCbObj = nil
	self._finishMoveCbParam = nil

	local mo = self:getMO()

	if mo then
		ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnEntityTweenMove, mo:getEntityType(), mo:getUid(), false)
	end
end

function ArcadeGameBaseEntity:_killMoveTween()
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end
end

function ArcadeGameBaseEntity:isTweenMoving()
	return self._moveTweenId
end

function ArcadeGameBaseEntity:refreshShowHpBar()
	if self.hpComp then
		self.hpComp:refreshShow()
	end
end

function ArcadeGameBaseEntity:getPosition(isLocal)
	local posX, posY, posZ = 0, 0, 0

	if isLocal then
		posX, posY, posZ = transformhelper.getLocalPos(self.trans)
	else
		posX, posY, posZ = transformhelper.getPos(self.trans)
	end

	return posX, posY, posZ
end

function ArcadeGameBaseEntity:destroy()
	gohelper.destroy(self.go)
end

function ArcadeGameBaseEntity:onDestroy()
	self:_clearActionEffList()
	self:_clearComps()
	self:_killMoveTween()
	TaskDispatcher.cancelTask(self._onDelayShow, self)

	self._finishMoveCb = nil
	self._finishMoveCbObj = nil
	self._finishMoveCbParam = nil
end

function ArcadeGameBaseEntity:onCtor(param)
	return
end

function ArcadeGameBaseEntity:addEventListeners()
	return
end

function ArcadeGameBaseEntity:removeEventListeners()
	return
end

function ArcadeGameBaseEntity:refreshDirection()
	return
end

function ArcadeGameBaseEntity:getMO()
	logError("ArcadeGameBaseEntity.getMO error, need override this func")
end

return ArcadeGameBaseEntity
