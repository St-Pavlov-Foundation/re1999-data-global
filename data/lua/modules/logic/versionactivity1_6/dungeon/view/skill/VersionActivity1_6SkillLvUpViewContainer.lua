module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillLvUpViewContainer", package.seeall)

slot0 = class("VersionActivity1_6SkillLvUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_6SkillLvUpView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		slot0.navigateView
	}
end

function slot0.onContainerInit(slot0)
end

return slot0
