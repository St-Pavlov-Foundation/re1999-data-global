-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffCardAreaRedOrBlueBuff.lua

module("modules.logic.fight.entity.comp.buff.FightBuffCardAreaRedOrBlueBuff", package.seeall)

local FightBuffCardAreaRedOrBlueBuff = class("FightBuffCardAreaRedOrBlueBuff")

function FightBuffCardAreaRedOrBlueBuff:ctor()
	return
end

function FightBuffCardAreaRedOrBlueBuff:onBuffStart(entity, buffMo)
	self:clearEffectAndEntity()

	self.entity = entity
	self.entityMo = entity:getMO()
	self.side = self.entityMo.side

	local fightScene = GameSceneMgr.instance:getCurScene()

	self.sceneEntityMgr = fightScene and fightScene.entityMgr
	self.effectCo = FightHeroSpEffectConfig.instance:getLYEffectCo(self.entityMo.originSkin)
	self.buffRes = self.effectCo.path
	self.spine1EffectRes = self.effectCo.spine1EffectRes
	self.spine2EffectRes = self.effectCo.spine2EffectRes
	self.spine1Res = self:getFullSpineResPath(self.effectCo.spine1Res)
	self.spine2Res = self:getFullSpineResPath(self.effectCo.spine2Res)
	self.playingUniqueSkill = false

	FightController.instance:registerCallback(FightEvent.BeforePlayUniqueSkill, self.onBeforePlayUniqueSkill, self)
	FightController.instance:registerCallback(FightEvent.AfterPlayUniqueSkill, self.onAfterPlayUniqueSkill, self)
	FightController.instance:registerCallback(FightEvent.ReleaseAllEntrustedEntity, self.onReleaseAllEntrustedEntity, self)
	FightController.instance:registerCallback(FightEvent.OnCameraFocusChanged, self.onCameraFocusChanged, self)
	FightController.instance:registerCallback(FightEvent.SetLiangYueEffectVisible, self.onSetLiangYueEffectVisible, self)

	self.loaded = false

	self:startLoadRes()

	if self.side == FightEnum.EntitySide.MySide then
		FightDataHelper.LYDataMgr:setLYCardAreaBuff(buffMo)
	end
end

function FightBuffCardAreaRedOrBlueBuff:startLoadRes()
	self:clearLoader()

	self.resLoader = MultiAbLoader.New()

	self.resLoader:addPath(self:getEffectAbPath(self.buffRes))
	self.resLoader:addPath(self:getEffectAbPath(self.spine1EffectRes))
	self.resLoader:addPath(self:getEffectAbPath(self.spine2EffectRes))
	self.resLoader:addPath(self.spine1Res)
	self.resLoader:addPath(self.spine2Res)
	self.resLoader:startLoad(self.onResLoaded, self)

	local audioId = self.effectCo.audioId

	if audioId and audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function FightBuffCardAreaRedOrBlueBuff:getEffectAbPath(effectName)
	local effectFullPath = FightHelper.getEffectUrlWithLod(effectName)

	return FightHelper.getEffectAbPath(effectFullPath)
end

function FightBuffCardAreaRedOrBlueBuff:getEffectPos(side)
	local pos = self.effectCo.pos

	if side == FightEnum.EntitySide.EnemySide then
		return -pos[1], pos[2], pos[3]
	else
		return pos[1], pos[2], pos[3]
	end
end

function FightBuffCardAreaRedOrBlueBuff:onResLoaded(loader)
	self.loaded = true

	local side = self.entity:getSide()
	local goContainerName = "LY_Spine_" .. (side == FightEnum.EntitySide.MySide and "R" or "L")

	self.spine1 = self.sceneEntityMgr:buildTempSpine(self.spine1Res, self.entity.id .. "_1", side, UnityLayer.EffectMask, FightEntityLyTemp, goContainerName .. "_1")
	self.spine2 = self.sceneEntityMgr:buildTempSpine(self.spine2Res, self.entity.id .. "_2", side, UnityLayer.EffectMask, FightEntityLyTemp, goContainerName .. "_2")

	self.spine1.spine:changeLookDir(SpineLookDir.Left)
	self.spine2.spine:changeLookDir(SpineLookDir.Left)
	self:hideEntity()

	self.spine1Effect = self.spine1.effect:addHangEffect(self.spine1EffectRes, ModuleEnum.SpineHangPointRoot)
	self.spine2Effect = self.spine2.effect:addHangEffect(self.spine2EffectRes, ModuleEnum.SpineHangPointRoot)
	self.effectWrap = self.entity.effect:addGlobalEffect(self.buffRes)

	local LY_Order = FightRenderOrderMgr.LYEffect * FightEnum.OrderRegion

	self.spine1Effect:setRenderOrder(LY_Order)
	self.spine2Effect:setRenderOrder(LY_Order)
	self.effectWrap:setRenderOrder(LY_Order)

	local goSpine1Root = self.spine1Effect.effectGO and gohelper.findChild(self.spine1Effect.effectGO, "root")

	self.spine1EffectAnimator = goSpine1Root and ZProj.ProjAnimatorPlayer.Get(goSpine1Root)

	local goSpine2Root = self.spine2Effect.effectGO and gohelper.findChild(self.spine2Effect.effectGO, "root")

	self.spine2EffectAnimator = goSpine2Root and ZProj.ProjAnimatorPlayer.Get(goSpine2Root)

	local goEffectRoot = self.effectWrap.effectGO and gohelper.findChild(self.effectWrap.effectGO, "root")

	self.effectAnimator = goEffectRoot and ZProj.ProjAnimatorPlayer.Get(goEffectRoot)

	self.effectWrap:setWorldPos(self:getEffectPos(side))
	self:addEffect(self.spine1, self.spine1Effect, side)
	self:addEffect(self.spine2, self.spine2Effect, side)
	self:showEntity()
	self.spine1.spine:addAnimEventCallback(self.onAnimEventCallback, self)
	self:playAnim(SpineAnimState.born)
	self:refreshEffectActive()
	FightController.instance:registerCallback(FightEvent.TimelineLYSpecialSpinePlayAniName, self.playAnim, self)
end

function FightBuffCardAreaRedOrBlueBuff:addEffect(entity, effectWrap, side)
	effectWrap:setWorldPos(self:getEffectPos(side))
	FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)
end

function FightBuffCardAreaRedOrBlueBuff:playAnim(animName)
	if not self.loaded then
		return
	end

	if self:isIdleAnim(animName) then
		self.spine1.spine:play(animName, true, true)
	else
		self.spine1.spine:play(animName, false, true)
	end
end

function FightBuffCardAreaRedOrBlueBuff:onAnimEventCallback(actionName, eventName, eventArgs)
	if self:isIdleAnim(actionName) then
		return
	end

	if eventName == SpineAnimEvent.ActionComplete then
		return self:playAnim(SpineAnimState.idle1)
	end
end

function FightBuffCardAreaRedOrBlueBuff:isIdleAnim(animName)
	return SpineAnimState.idle1 == animName or SpineAnimState.idle2 == animName
end

function FightBuffCardAreaRedOrBlueBuff:onCameraFocusChanged(focus)
	self.focusing = focus

	self:refreshEffectActive()
end

function FightBuffCardAreaRedOrBlueBuff:onBeforePlayUniqueSkill()
	self.playingUniqueSkill = true

	self:refreshEffectActive()
end

function FightBuffCardAreaRedOrBlueBuff:onAfterPlayUniqueSkill()
	self.playingUniqueSkill = false

	self:refreshEffectActive()
end

function FightBuffCardAreaRedOrBlueBuff:onSetLiangYueEffectVisible(visible)
	self.hideLiangYueEffect = not visible

	self:refreshEffectActive()
end

function FightBuffCardAreaRedOrBlueBuff:refreshEffectActive()
	if self.loaded then
		local showEffect = not self.playingUniqueSkill and not self.focusing and not self.hideLiangYueEffect

		self.spine1Effect:setActive(showEffect)
		self.spine2Effect:setActive(showEffect)
		self.effectWrap:setActive(showEffect)

		if showEffect then
			self:showEntity()
		else
			self:hideEntity()
		end
	end
end

function FightBuffCardAreaRedOrBlueBuff:setEntityAlpha(value)
	if not self.loaded then
		return
	end

	self.spine1.spineRenderer:setAlpha(value)
	self.spine2.spineRenderer:setAlpha(value)
end

function FightBuffCardAreaRedOrBlueBuff:hideEntity()
	self:setEntityAlpha(0)
end

function FightBuffCardAreaRedOrBlueBuff:showEntity()
	TaskDispatcher.cancelTask(self._showEntity, self)
	TaskDispatcher.runDelay(self._showEntity, self, 0.01)
end

function FightBuffCardAreaRedOrBlueBuff:_showEntity()
	if self.playingUniqueSkill then
		self:setEntityAlpha(0)
	else
		self:setEntityAlpha(1)
	end
end

function FightBuffCardAreaRedOrBlueBuff:getFullSpineResPath(spineRes)
	return string.format("roles/%s.prefab", spineRes)
end

function FightBuffCardAreaRedOrBlueBuff:onReleaseAllEntrustedEntity()
	self:clear()
end

function FightBuffCardAreaRedOrBlueBuff:clearLoader()
	if self.resLoader then
		self.resLoader:dispose()

		self.resLoader = nil
	end
end

function FightBuffCardAreaRedOrBlueBuff:clear()
	self:clearLoader()
	TaskDispatcher.cancelTask(self._showEntity, self)

	if self.effectAnimator then
		local audioId = self.effectCo and self.effectCo.fadeAudioId

		if audioId and audioId ~= 0 then
			AudioMgr.instance:trigger(audioId)
		end

		self.spine1EffectAnimator:Play("close")
		self.spine2EffectAnimator:Play("close")
		self.effectAnimator:Play("close", self.clearEffectAndEntity, self)
	else
		self:clearEffectAndEntity()
	end

	if self.side == FightEnum.EntitySide.MySide then
		FightDataHelper.LYDataMgr:setLYCardAreaBuff(nil)
	end

	FightController.instance:unregisterCallback(FightEvent.TimelineLYSpecialSpinePlayAniName, self.playAnim, self)
	FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, self.onBeforePlayUniqueSkill, self)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, self.onAfterPlayUniqueSkill, self)
	FightController.instance:unregisterCallback(FightEvent.ReleaseAllEntrustedEntity, self.onReleaseAllEntrustedEntity, self)
	FightController.instance:unregisterCallback(FightEvent.SetLiangYueEffectVisible, self.onSetLiangYueEffectVisible, self)

	self.loaded = false
end

function FightBuffCardAreaRedOrBlueBuff:clearEffectAndEntity()
	self:clearSpine(self.spine1, self.spine1Effect)
	self:clearSpine(self.spine2, self.spine2Effect)
	self:clearEffect(self.entity, self.effectWrap)

	self.spine1 = nil
	self.spine2 = nil
	self.spine1Effect = nil
	self.spine2Effect = nil
	self.effectWrap = nil
	self.effectAnimator = nil
	self.spine1EffectAnimator = nil
	self.spine2EffectAnimator = nil
	self.entity = nil
end

function FightBuffCardAreaRedOrBlueBuff:clearSpine(spine, spineEffect)
	if spine then
		self:clearEffect(spine, spineEffect)
		self.sceneEntityMgr:removeUnit(spine:getTag(), spine.id)
	end
end

function FightBuffCardAreaRedOrBlueBuff:clearEffect(entity, effectWrap)
	if entity and effectWrap then
		entity.effect:removeEffect(effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(entity.id, effectWrap)
	end
end

function FightBuffCardAreaRedOrBlueBuff:onBuffEnd()
	self:clear()
end

function FightBuffCardAreaRedOrBlueBuff:dispose()
	self:clear()
end

return FightBuffCardAreaRedOrBlueBuff
