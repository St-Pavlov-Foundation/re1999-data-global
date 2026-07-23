-- chunkname: @modules/logic/fight/view/cardeffect/FightDeviceCardDisplayEffect.lua

module("modules.logic.fight.view.cardeffect.FightDeviceCardDisplayEffect", package.seeall)

local FightDeviceCardDisplayEffect = class("FightDeviceCardDisplayEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033
local TipAnchorOffsetX = 80

function FightDeviceCardDisplayEffect:onStart(context)
	FightDeviceCardDisplayEffect.super.onStart(self, context)

	self._dt = dt / FightModel.instance:getUISpeed()

	gohelper.setActive(context.skillTipsGO, true)

	local tipsTr = context.skillTipsGO.transform
	local tipsWidth = recthelper.getWidth(tipsTr)
	local tipsPosX = FightViewWaitingAreaVersion1.getDeviceAnchorXByServerData()

	tipsPosX = tipsPosX - FightDeviceHelper.getDeviceAreaTotalWidth() - TipAnchorOffsetX

	recthelper.setAnchorX(tipsTr, 1100 + tipsWidth)

	local tipsSequence = FlowSequence.New()

	tipsSequence:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = tipsTr,
		to = tipsPosX - 10,
		t = self._dt * 7
	}))
	tipsSequence:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = tipsTr,
		to = tipsPosX,
		t = self._dt * 3
	}))

	self._flow = FlowParallel.New()

	self._flow:addWork(tipsSequence)
	self._flow:registerDoneListener(self._onWorkDone, self)
	self._flow:start()
end

function FightDeviceCardDisplayEffect:onStop()
	FightDeviceCardDisplayEffect.super.onStop(self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onWorkDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

function FightDeviceCardDisplayEffect:_onWorkDone()
	self:onDone(true)
end

return FightDeviceCardDisplayEffect
