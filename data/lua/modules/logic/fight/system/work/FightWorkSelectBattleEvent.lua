-- chunkname: @modules/logic/fight/system/work/FightWorkSelectBattleEvent.lua

module("modules.logic.fight.system.work.FightWorkSelectBattleEvent", package.seeall)

local FightWorkSelectBattleEvent = class("FightWorkSelectBattleEvent", FightWorkItem)

function FightWorkSelectBattleEvent:onStart()
	FightDataHelper.tempMgr.battleSelectCount = FightDataHelper.tempMgr.battleSelectCount + 1

	if FightDataHelper.tempMgr.battleSelectCount > 10 then
		return self:onDone(true)
	end

	local myVertin = FightDataHelper.entityMgr:getMyVertin()

	if not myVertin then
		return self:onDone(true)
	end

	for _, buffData in pairs(myVertin.buffDic) do
		local actInfo = buffData.actInfo

		for i = 1, #actInfo do
			local actInfo = actInfo[i]
			local actId = actInfo.actId
			local config = lua_buff_act.configDict[actId]

			if config and config.type == "BattleSelection" and actInfo.param[#actInfo.param] == 0 and #actInfo.param >= 2 and lua_battle_selection.configDict[actInfo.param[1]] then
				self:cancelFightWorkSafeTimer()
				self:com_registFightEvent(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail)
				ViewMgr.instance:openView(ViewName.FightSupportEventView, {
					buffData = buffData,
					actInfo = actInfo
				})

				return
			end
		end
	end

	return self:onDone(true)
end

function FightWorkSelectBattleEvent:_onRespUseClothSkillFail()
	self:onDone(true)
end

return FightWorkSelectBattleEvent
