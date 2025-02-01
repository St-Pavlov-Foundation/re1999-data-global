module("modules.logic.bossrush.view.V1a4_BossRush_EnemyInfoView", package.seeall)

slot0 = class("V1a4_BossRush_EnemyInfoView", EnemyInfoView)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)
end

function slot0._refreshUI(slot0)
	if not slot0._battleId then
		logError("地方信息界面缺少战斗Id")

		return
	end

	uv0.super._refreshUI(slot0)
end

function slot0._getBossId(slot0, slot1)
	slot3 = FightController.instance:setFightParamByBattleId(slot0._battleId) and slot2.monsterGroupIds and slot2.monsterGroupIds[slot1]
	slot4 = slot3 and lua_monster_group.configDict[slot3]

	return slot4 and not string.nilorempty(slot4.bossId) and slot4.bossId or nil
end

function slot0.onUpdateParam(slot0)
	slot0._battleId = BossRushConfig.instance:getDungeonBattleId(slot0.viewParam.bossRushStage, slot0.viewParam.bossRushLayer)

	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, slot0._refreshInfo, slot0)
	slot0:onUpdateParam()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, slot0._refreshInfo, slot0)
end

function slot0._doUpdateSelectIcon(slot0, slot1)
	slot0.viewContainer:getBossRushViewRule():refreshUI(slot1)
end

return slot0
