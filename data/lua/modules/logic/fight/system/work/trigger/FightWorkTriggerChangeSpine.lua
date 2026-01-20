-- chunkname: @modules/logic/fight/system/work/trigger/FightWorkTriggerChangeSpine.lua

module("modules.logic.fight.system.work.trigger.FightWorkTriggerChangeSpine", package.seeall)

local FightWorkTriggerChangeSpine = class("FightWorkTriggerChangeSpine", BaseWork)

function FightWorkTriggerChangeSpine:ctor(fightStepData, actEffectData)
	self.fightStepData = fightStepData
	self.actEffectData = actEffectData
end

function FightWorkTriggerChangeSpine:onStart()
	self._config = lua_trigger_action.configDict[self.actEffectData.effectNum]
	self._tarEntity = FightHelper.getEnemyEntityByMonsterId(tonumber(self._config.param1))

	if self._tarEntity and self._tarEntity.spine then
		TaskDispatcher.runDelay(self._delayDone, self, 20)

		self._lastSpineObj = self._tarEntity.spine:getSpineGO()

		self._tarEntity:loadSpine(self._onLoaded, self, string.format("roles/%s.prefab", self._config.param2))

		return
	end

	self:_delayDone()
end

function FightWorkTriggerChangeSpine:_onLoaded()
	if self._tarEntity then
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, self._tarEntity.spine)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, self._tarEntity.spine)
	end

	self:_delayDone()
end

function FightWorkTriggerChangeSpine:_delayDone()
	if self._tarEntity then
		self._tarEntity:initHangPointDict()
	end

	local effects = self._tarEntity.effect:getHangEffect()

	if effects then
		for k, v in pairs(effects) do
			local effectWrap = v.effectWrap
			local hangPoint = v.hangPoint
			local x, y, z = transformhelper.getLocalPos(effectWrap.containerTr)
			local hangObj = self._tarEntity:getHangPoint(hangPoint)

			gohelper.addChild(hangObj, effectWrap.containerGO)
			transformhelper.setLocalPos(effectWrap.containerTr, x, y, z)
		end
	end

	gohelper.destroy(self._lastSpineObj)
	self:onDone(true)
end

function FightWorkTriggerChangeSpine:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkTriggerChangeSpine
