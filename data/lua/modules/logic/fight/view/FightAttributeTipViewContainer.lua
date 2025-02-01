module("modules.logic.fight.view.FightAttributeTipViewContainer", package.seeall)

slot0 = class("FightAttributeTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightAttributeTipView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
