module("modules.logic.tower.view.assistboss.TowerBossSkillTipsViewContainer", package.seeall)

slot0 = class("TowerBossSkillTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerBossSkillTipsView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
