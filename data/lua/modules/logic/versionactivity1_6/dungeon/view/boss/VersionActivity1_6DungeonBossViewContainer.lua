module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6DungeonBossViewContainer", package.seeall)

slot0 = class("VersionActivity1_6DungeonBossViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._bossRuleView = VersionActivity1_6_BossRuleView.New()

	return {
		VersionActivity1_6DungeonBossView.New(),
		TabViewGroup.New(1, "#go_BackBtns"),
		slot0._bossRuleView
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		true,
		true
	})

	slot0.navigateView:setHelpId(HelpEnum.HelpId.Dungeon1_6BossHelp)

	return {
		slot0.navigateView
	}
end

function slot0.onContainerInit(slot0)
end

function slot0.getBossRuleView(slot0)
	return slot0._bossRuleView
end

return slot0
