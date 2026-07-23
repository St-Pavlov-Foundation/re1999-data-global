-- chunkname: @modules/logic/fight/system/work/FightWorkSSWLSelectCard.lua

module("modules.logic.fight.system.work.FightWorkSSWLSelectCard", package.seeall)

local FightWorkSSWLSelectCard = class("FightWorkSSWLSelectCard", FightWorkItem)

function FightWorkSSWLSelectCard:onStart()
	local buffActParam, uid = FightHelper.getSSWLSelectCardParam()

	if not buffActParam then
		return self:onDone(true)
	end

	local selected = buffActParam[1] and buffActParam[1] ~= 0

	if selected then
		return self:onDone(true)
	end

	local canSelectCount = buffActParam[2] or 0

	if canSelectCount < 1 then
		return self:onDone(true)
	end

	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
	self:cancelFightWorkSafeTimer()
	ViewMgr.instance:openView(ViewName.FightS02SSWLSelectCardView, {
		entityId = uid,
		paramList = buffActParam
	})
end

function FightWorkSSWLSelectCard:_onRespUseClothSkillFail()
	logError("双生舞苓 选择卡牌失败")
	ViewMgr.instance:closeView(ViewName.FightS02SSWLSelectCardView)
	self:onDone(true)
end

function FightWorkSSWLSelectCard:clearWork()
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
end

return FightWorkSSWLSelectCard
