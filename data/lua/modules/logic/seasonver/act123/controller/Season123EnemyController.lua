module("modules.logic.seasonver.act123.controller.Season123EnemyController", package.seeall)

slot0 = class("Season123EnemyController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2, slot3)
	Season123EnemyModel.instance:init(slot1, slot2, slot3)
end

function slot0.onCloseView(slot0)
	Season123EnemyModel.instance:release()
end

function slot0.switchTab(slot0, slot1)
	if Season123EnemyModel.instance:getSelectedIndex() ~= slot1 then
		Season123EnemyModel.instance:setSelectIndex(slot1)
		Season123Controller.instance:dispatchEvent(Season123Event.EnemyDetailSwitchTab)
	end
end

function slot0.selectMonster(slot0, slot1, slot2)
	if not Season123EnemyModel.instance:getCurrentBattleGroupIds() then
		return
	end

	if not Season123EnemyModel.instance:getMonsterIds(slot3[slot1]) then
		return
	end

	if slot4[slot2] ~= Season123EnemyModel.instance.selectMonsterId then
		Season123EnemyModel.instance:setEnemySelectMonsterId(slot1, slot2, slot5)
		Season123Controller.instance:dispatchEvent(Season123Event.EnemyDetailSelectEnemy)
	end
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
