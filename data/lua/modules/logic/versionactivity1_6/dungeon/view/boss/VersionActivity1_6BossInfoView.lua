module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6BossInfoView", package.seeall)

slot0 = class("VersionActivity1_6BossInfoView", EnemyInfoView)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._txthp = gohelper.findChildText(slot0.viewGO, "enemyinfo/txt_hp/#txt_hp")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._imagedmgtype = gohelper.findChildImage(slot0.viewGO, "enemyinfo/#txt_name/#image_dmgtype")
end

function slot0._refreshUI(slot0)
	if not slot0._battleId then
		logError("地方信息界面缺少战斗Id")

		return
	end

	uv0.super._refreshUI(slot0)
	slot0:_doUpdateSelectIcon(slot0._battleId)
end

function slot0._getBossId(slot0, slot1)
	slot3 = FightController.instance:setFightParamByBattleId(slot0._battleId) and slot2.monsterGroupIds and slot2.monsterGroupIds[slot1]
	slot4 = slot3 and lua_monster_group.configDict[slot3]

	return slot4 and not string.nilorempty(slot4.bossId) and slot4.bossId or nil
end

function slot0.onUpdateParam(slot0)
	slot0._battleId = Activity149Config.instance:getDungeonEpisodeCfg(slot0.viewParam.bossEpisodeId).battleId

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

function slot0._refreshInfo(slot0, slot1)
	uv0.super._refreshInfo(slot0, slot1)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagedmgtype, "dmgtype" .. tostring(lua_monster.configDict[slot1.monsterId].dmgType))
end

return slot0
