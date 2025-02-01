module("modules.logic.fight.view.FightToughBattleSkillView", package.seeall)

slot0 = class("FightToughBattleSkillView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._item = gohelper.findChild(slot0.viewGO, "#scroll_List/Viewport/Content/#go_Items")
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, slot0._onRoundSequenceStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StartPlayClothSkill, slot0._onRoundSequenceStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._onRoundSequenceStart(slot0)
	gohelper.setActive(slot0.viewGO, false)
end

function slot0._onRoundSequenceFinish(slot0)
	gohelper.setActive(slot0.viewGO, true)
end

function slot0.onOpen(slot0)
	if not DungeonConfig.instance:getChapterCO(FightModel.instance:getFightParam().chapterId) or slot3.type ~= DungeonEnum.ChapterType.ToughBattle then
		return
	end

	if not slot1.episodeId then
		return
	end

	slot0._isAct = ToughBattleConfig.instance:isActEpisodeId(slot4)

	slot0:refreshView()
end

function slot0.refreshView(slot0)
	if not slot0:getInfo() then
		return
	end

	slot2 = slot1.passChallengeIds
	slot3 = {}
	slot4 = {}

	if FightModel.instance.last_fightGroup then
		for slot9, slot10 in ipairs(slot5.trialHeroList) do
			slot4[slot10.trialId] = true
		end
	end

	if slot0._isAct then
		for slot9, slot10 in ipairs(slot2) do
			if lua_activity158_challenge.configDict[slot10] then
				slot0:addHeroId(slot3, slot11.heroId, slot4)
			end
		end
	else
		for slot9, slot10 in ipairs(slot2) do
			if lua_siege_battle.configDict[slot10] then
				slot0:addHeroId(slot3, slot11.heroId, slot4)
			end
		end
	end

	gohelper.CreateObjList(slot0, slot0.createItem, slot3, slot0._item.transform.parent.gameObject, slot0._item, FightToughBattleSkillItem)
end

function slot0.addHeroId(slot0, slot1, slot2, slot3)
	if not lua_siege_battle_hero.configDict[slot2] then
		return
	end

	if slot4.type == ToughBattleEnum.HeroType.Hero and not slot3[tonumber(slot4.param)] then
		return
	end

	table.insert(slot1, slot4)
end

function slot0.createItem(slot0, slot1, slot2, slot3)
	slot1:setCo(slot2)
end

function slot0.getInfo(slot0)
	if slot0._isAct then
		if ToughBattleModel.instance:getActInfo() then
			return slot1
		end

		Activity158Rpc.instance:sendGet158InfosRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, slot0.onRecvMsg, slot0)
	else
		if ToughBattleModel.instance:getStoryInfo() then
			return slot1
		end

		SiegeBattleRpc.instance:sendGetSiegeBattleInfoRequest(slot0.onRecvMsg, slot0)
	end
end

function slot0.onRecvMsg(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0:refreshView()
end

return slot0
