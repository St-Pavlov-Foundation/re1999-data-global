module("modules.logic.fight.view.FightSuccViewContainer", package.seeall)

slot0 = class("FightSuccViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.fightSuccActView = FightSuccActView.New()
	slot1 = {
		FightSuccView.New(),
		slot0.fightSuccActView
	}

	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		table.insert(slot1, FightGMRecordView.New())
	end

	return slot1
end

return slot0
