module("modules.logic.versionactivity2_5.challenge.view.Act183FightSuccViewContainer", package.seeall)

slot0 = class("Act183FightSuccViewContainer", FightSuccViewContainer)

function slot0.buildViews(slot0)
	slot0.fightSuccActView = FightSuccActView.New()
	slot1 = {
		Act183FightSuccView.New(),
		slot0.fightSuccActView
	}

	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		table.insert(slot1, FightGMRecordView.New())
	end

	return slot1
end

return slot0
