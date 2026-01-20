-- chunkname: @modules/logic/fight/system/work/trigger/FightWorkTriggerDialog.lua

module("modules.logic.fight.system.work.trigger.FightWorkTriggerDialog", package.seeall)

local FightWorkTriggerDialog = class("FightWorkTriggerDialog", BaseWork)

function FightWorkTriggerDialog:ctor(fightStepData, actEffectData)
	self.fightStepData = fightStepData
	self.actEffectData = actEffectData
end

function FightWorkTriggerDialog:onStart()
	if FightDataHelper.stateMgr.isReplay then
		self:onDone(true)

		return
	end

	self._config = lua_trigger_action.configDict[self.actEffectData.effectNum]

	if self._config then
		local battleId = tonumber(self._config.param1)
		local id = tonumber(self._config.param2)
		local dialogConfig = lua_battle_dialog.configDict[battleId] and lua_battle_dialog.configDict[battleId][id]

		if dialogConfig then
			FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.Trigger, dialogConfig)

			self._dialogWork = FightWorkWaitDialog.New()

			self._dialogWork:registerDoneListener(self._onFightDialogEnd, self)
			self._dialogWork:onStart()

			return
		end
	end

	self:onDone(true)
end

function FightWorkTriggerDialog:_onFightDialogEnd()
	self:onDone(true)
end

function FightWorkTriggerDialog:clearWork()
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)

	if self._dialogWork then
		self._dialogWork:unregisterDoneListener(self._onFightDialogEnd, self)

		self._dialogWork = nil
	end
end

return FightWorkTriggerDialog
