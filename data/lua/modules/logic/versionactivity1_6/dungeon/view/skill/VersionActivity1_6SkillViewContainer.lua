module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillViewContainer", package.seeall)

slot0 = class("VersionActivity1_6SkillViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_6SkillView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function slot0.onContainerInit(slot0)
end

return slot0
