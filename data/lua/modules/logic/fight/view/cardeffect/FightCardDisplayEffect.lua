-- chunkname: @modules/logic/fight/view/cardeffect/FightCardDisplayEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardDisplayEffect", package.seeall)

local FightCardDisplayEffect = class("FightCardDisplayEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033

function FightCardDisplayEffect:onStart(context)
	FightCardDisplayEffect.super.onStart(self, context)

	self._dt = dt / FightModel.instance:getUISpeed()

	gohelper.setActive(context.skillTipsGO, true)

	local tipsTr = context.skillTipsGO.transform
	local tipsWidth = recthelper.getWidth(tipsTr)
	local cardTr = context.skillItemGO.transform.parent
	local itemPosX = recthelper.getAnchorX(cardTr)
	local itemWidth = recthelper.getWidth(cardTr)
	local tipsPosX = itemPosX - itemWidth * 0.5

	recthelper.setAnchorX(tipsTr, 1100 + tipsWidth)

	local tipsSequence = FlowSequence.New()

	tipsSequence:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = tipsTr,
		to = tipsPosX - 47.5,
		t = self._dt * 7
	}))
	tipsSequence:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = tipsTr,
		to = tipsPosX - 34.2,
		t = self._dt * 3
	}))

	local itemTr = context.skillItemGO.transform
	local itemAnchorSequence = FlowSequence.New()

	itemAnchorSequence:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tox = -15,
		toy = 22,
		tr = itemTr,
		t = self._dt * 6
	}))

	local itemScaleSequence = FlowSequence.New()

	itemScaleSequence:addWork(TweenWork.New({
		to = 0.922,
		type = "DOScale",
		tr = itemTr,
		t = self._dt * 3
	}))
	itemScaleSequence:addWork(TweenWork.New({
		to = 1.2,
		type = "DOScale",
		tr = itemTr,
		t = self._dt * 3
	}))

	self._flow = FlowParallel.New()

	self._flow:addWork(tipsSequence)
	self._flow:addWork(itemAnchorSequence)
	self._flow:addWork(itemScaleSequence)
	self._flow:registerDoneListener(self._onWorkDone, self)
	self._flow:start()
end

function FightCardDisplayEffect:onStop()
	FightCardDisplayEffect.super.onStop(self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onWorkDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

function FightCardDisplayEffect:_onWorkDone()
	self:onDone(true)
end

return FightCardDisplayEffect
