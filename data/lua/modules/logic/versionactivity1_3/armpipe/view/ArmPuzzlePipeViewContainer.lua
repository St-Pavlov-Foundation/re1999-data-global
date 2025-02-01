module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipeViewContainer", package.seeall)

slot0 = class("ArmPuzzlePipeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._pipes = ArmPuzzlePipes.New()

	return {
		ArmPuzzlePipeView.New(),
		slot0._pipes,
		ArmPuzzlePipePieceView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot2 = NavigateButtonsView.New({
		true,
		false,
		true
	}, HelpEnum.HelpId.VersionActivity_1_3_LeftHand)

	slot2:setOverrideClose(slot0.overrideCloseFunc, slot0)

	return {
		slot2
	}
end

function slot0.onContainerInit(slot0)
	Stat1_3Controller.instance:armPuzzleStatStart()
end

function slot0.getPipesXYByPostion(slot0, slot1)
	return slot0._pipes:getXYByPostion(slot1)
end

function slot0.getPipes(slot0)
	return slot0._pipes
end

function slot0.overrideCloseFunc(slot0)
	Stat1_3Controller.instance:puzzleStatAbort()
	slot0:closeThis()
end

return slot0
