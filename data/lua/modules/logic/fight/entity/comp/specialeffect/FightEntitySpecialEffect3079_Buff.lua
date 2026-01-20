-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffect3079_Buff.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3079_Buff", package.seeall)

local FightEntitySpecialEffect3079_Buff = class("FightEntitySpecialEffect3079_Buff", FightEntitySpecialEffectBase)

function FightEntitySpecialEffect3079_Buff:initClass()
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)

	self._showBuffIdList = {}
end

local _effectTime = 1.5
local _effectInterval = 0.9

function FightEntitySpecialEffect3079_Buff:_onBuffUpdate(targetId, effectType, buffId, buffUid, configEffect, buffData)
	if targetId ~= self._entity.id then
		return
	end

	if not buffData then
		return
	end

	local fromEntityData = FightDataHelper.entityMgr:getById(buffData.fromUid)

	if not fromEntityData then
		return
	end

	local config = lua_fight_6_buff_effect.configDict[fromEntityData.skin] or lua_fight_6_buff_effect.configDict[0]

	config = config and config[buffId]

	if config and effectType == FightEnum.EffectType.BUFFADD then
		table.insert(self._showBuffIdList, {
			buffId = buffId,
			config = config
		})

		if not self._playing then
			self:_showBuffEffect()
		end
	end
end

function FightEntitySpecialEffect3079_Buff:_showBuffEffect()
	local tab = table.remove(self._showBuffIdList, 1)

	if tab then
		self._playing = true

		local config = tab.config
		local hangPoint = string.nilorempty(config.effectHang) and ModuleEnum.SpineHangPointRoot or config.effectHang
		local effectWrap = self._entity.effect:addHangEffect(config.effect, hangPoint, nil, _effectTime)

		FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)
		effectWrap:setLocalPos(0, 0, 0)
		TaskDispatcher.runDelay(self._showBuffEffect, self, _effectInterval)

		if config.audioId ~= 0 then
			AudioMgr.instance:trigger(config.audioId)
		end
	else
		self._playing = false
	end
end

function FightEntitySpecialEffect3079_Buff:releaseSelf()
	TaskDispatcher.cancelTask(self._showBuffEffect, self)
end

return FightEntitySpecialEffect3079_Buff
