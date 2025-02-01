module("modules.logic.tips.view.SkillTipViewContainer", package.seeall)

slot0 = class("SkillTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SkillTipView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
