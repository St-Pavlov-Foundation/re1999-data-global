module("modules.logic.gm.view.FightGMDouQuQuTestContainer", package.seeall)

slot0 = class("FightGMDouQuQuTestContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, FightGMDouQuQuTest.New())

	return slot1
end

return slot0
