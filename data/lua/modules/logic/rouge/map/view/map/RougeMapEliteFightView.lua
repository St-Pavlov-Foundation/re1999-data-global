module("modules.logic.rouge.map.view.map.RougeMapEliteFightView", package.seeall)

slot0 = class("RougeMapEliteFightView", BaseView)

function slot0.onInitView(slot0)
	slot0._goboss = gohelper.findChild(slot0.viewGO, "#go_boss")
	slot0._txtbossdesc = gohelper.findChildText(slot0.viewGO, "#go_boss/scroll_bossdesc/viewport/#txt_bossdec")
	slot0._imageBossHead = gohelper.findChildImage(slot0.viewGO, "#go_boss/#image_bosshead")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "#go_boss/career")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, slot0.refreshBoss, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, slot0.refreshBoss, slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshBoss()
end

function slot0.refreshBoss(slot0)
	if not RougeMapModel.instance:isNormalLayer() then
		gohelper.setActive(slot0._goboss, false)

		slot0.eventId = nil

		return
	end

	if not RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockShowPassFightMask, RougeMapEnum.EventType.EliteFight) then
		gohelper.setActive(slot0._goboss, false)

		slot0.eventId = nil

		return
	end

	if not slot0:getShowBossEventId() then
		gohelper.setActive(slot0._goboss, false)

		slot0.eventId = nil

		return
	end

	if not RougeOutsideModel.instance:passedEventId(slot1) then
		gohelper.setActive(slot0._goboss, false)

		slot0.eventId = nil

		return
	end

	if slot1 == slot0.eventId then
		return
	end

	gohelper.setActive(slot0._goboss, true)

	slot0.eventId = slot1

	slot0:refreshUI()
end

function slot0.checkUnlockTalent(slot0)
	return RougeMapConfig.instance:getShowFightMonsterMaskTalentId(RougeMapEnum.EventType.EliteFight) and RougeTalentModel.instance:checkNodeLight(slot1)
end

function slot0.getShowBossEventId(slot0)
	for slot5, slot6 in pairs(RougeMapModel.instance:getNodeDict()) do
		if slot6:getEventCo() and slot7.type == RougeMapEnum.EventType.EliteFight then
			return slot7.id
		end
	end
end

function slot0.refreshUI(slot0)
	if not RougeMapConfig.instance:getFightEvent(slot0.eventId) then
		return
	end

	UISpriteSetMgr.instance:setRougeSprite(slot0._imagecareer, "rouge_map_career_" .. slot0:getBossCareer(slot1))

	slot0._txtbossdesc.text = slot1.bossDesc

	if string.nilorempty(slot1.bossMask) then
		logError(string.format("战斗事件表id ： %s， 没有配置Boss剪影", slot0.eventId))

		return
	end

	UISpriteSetMgr.instance:setRouge3Sprite(slot0._imageBossHead, slot3)
end

function slot0.getBossCareer(slot0, slot1)
	if not lua_battle.configDict[DungeonConfig.instance:getEpisodeCO(slot1.episodeId).battleId] then
		logError("not found battle co, battle id : " .. tostring(slot2.battleId))

		return 1
	end

	for slot8, slot9 in ipairs(string.splitToNumber(slot3.monsterGroupIds, "#")) do
		if not string.nilorempty(lua_monster_group.configDict[slot9].bossId) then
			return lua_monster.configDict[string.splitToNumber(slot11, "#")[1]].career
		end
	end

	logError("not found boss career, battle id .. " .. slot3.id)

	return 1
end

function slot0.onDestroyView(slot0)
end

return slot0
