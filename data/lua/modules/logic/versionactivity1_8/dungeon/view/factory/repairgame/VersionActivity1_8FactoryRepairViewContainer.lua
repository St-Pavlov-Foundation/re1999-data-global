module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairViewContainer", package.seeall)

slot0 = class("VersionActivity1_8FactoryRepairViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._gameMap = VersionActivity1_8FactoryRepairGameMap.New()

	return {
		VersionActivity1_8FactoryRepairView.New(),
		slot0._gameMap,
		VersionActivity1_8FactoryRepairPieceView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

function slot0.getPipes(slot0)
	return slot0._gameMap
end

function slot0.getPipesXYByPosition(slot0, slot1)
	return slot0._gameMap:getXYByPosition(slot1)
end

function slot0.onContainerInit(slot0)
	VersionActivity1_8StatController.instance:startStat()
end

function slot0.onContainerClose(slot0)
	VersionActivity1_8StatController.instance:statAbort()
end

return slot0
