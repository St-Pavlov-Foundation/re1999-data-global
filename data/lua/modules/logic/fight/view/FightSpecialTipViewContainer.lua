module("modules.logic.fight.view.FightSpecialTipViewContainer", package.seeall)

slot0 = class("FightSpecialTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightSpecialTipView.New()
	}
end

function slot0.onContainerCloseFinish(slot0)
	FightController.instance:dispatchEvent(FightEvent.SetPlayCardPartOriginPos)
end

return slot0
