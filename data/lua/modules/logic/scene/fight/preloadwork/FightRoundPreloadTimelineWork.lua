module("modules.logic.scene.fight.preloadwork.FightRoundPreloadTimelineWork", package.seeall)

slot0 = class("FightRoundPreloadTimelineWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot2 = slot0:_getTimelineUrlList()

	if not GameResMgr.IsFromEditorDir then
		slot0.context.timelineDict = slot0.context.timelineDict or {}

		for slot6, slot7 in ipairs(slot2) do
			slot0.context.timelineDict[slot7] = FightPreloadController.instance:getFightAssetItem(ResUrl.getRolesTimeline())
		end

		slot0:onDone(true)

		return
	end

	slot0._loader = SequenceAbLoader.New()

	for slot6, slot7 in ipairs(slot2) do
		slot0._loader:addPath(slot7)
	end

	slot0._loader:setConcurrentCount(10)
	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0._onPreloadFinish(slot0)
	slot0.context.timelineDict = slot0.context.timelineDict or {}

	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		slot0.context.timelineDict[slot5] = slot6

		slot0.context.callback(slot0.context.callbackObj, slot6)
	end

	slot0:onDone(true)
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("Timeline加载失败：" .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._getTimelineUrlList(slot0)
	slot1 = slot0.context.timelineDict or {}
	slot0.context.timelineUrlDict = {}
	slot0.context.timelineSkinDict = {}

	if SkillEditorMgr.instance.inEditMode then
		slot0:_clacEditor()
	else
		slot0:_calcFightCards()
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot0.context.timelineUrlDict) do
		if slot1[slot6] == nil then
			table.insert(slot2, slot6)
		end
	end

	return slot2
end

function slot0._clacEditor(slot0)
	slot0.context.timelineUrlDict = {}
	slot0.context.timelineSkinDict = {}

	for slot5, slot6 in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		slot0:_gatherModelSkillIds(FightEnum.EntitySide.MySide, slot6.modelId, slot6.skin)
	end

	for slot6, slot7 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
		slot0:_gatherModelSkillIds(FightEnum.EntitySide.EnemySide, slot7.modelId, slot7.skin)
	end
end

function slot0._calcFightCards(slot0)
	slot3 = FightCardModel.instance:getHandCards()

	if FightModel.instance:getCurRoundMO() and slot1:getAIUseCardMOList() then
		for slot7, slot8 in ipairs(slot2) do
			if FightDataHelper.entityMgr:getById(slot8.uid) then
				slot0:_gatherSkill(FightEnum.EntitySide.EnemySide, slot9.skin, slot8.skillId)
			end
		end
	end

	for slot7, slot8 in ipairs(slot3) do
		if FightDataHelper.entityMgr:getById(slot8.uid) then
			slot0:_gatherSkill(FightEnum.EntitySide.MySide, FightHelper.processSkinId(slot9, slot8), slot8.skillId)
		end
	end

	slot0:_checkBattleRuleSkill(lua_battle.configDict[FightModel.instance:getFightParam().battleId] and slot5.additionRule)
	slot0:_checkBattleRuleSkill(slot5 and slot5.hiddenRule)
end

function slot0._checkBattleRuleSkill(slot0, slot1)
	if not string.nilorempty(slot1) then
		slot6 = true
		slot7 = "|"

		for slot6, slot7 in ipairs(FightStrUtil.instance:getSplitString2Cache(slot1, slot6, slot7, "#")) do
			slot8 = slot7[1]

			if lua_rule.configDict[slot7[2]] and slot10.type == DungeonEnum.AdditionRuleType.FightSkill then
				slot0:_gatherSkill(FightEnum.EntitySide.BothSide, nil, tonumber(slot10.effect))

				break
			end
		end
	end
end

function slot0._gatherModelSkillIds(slot0, slot1, slot2, slot3)
	if not FightHelper.buildSkills(slot2) then
		logError(slot2 .. " no skill")
	end

	for slot8, slot9 in ipairs(slot4) do
		if not lua_skill.configDict[slot9] then
			logError((lua_character.configDict[slot2] and "角色：" or "怪物：") .. slot2 .. "，技能id不存在：" .. slot9)
		end

		slot0:_gatherSkill(slot1, slot3, slot9)
	end
end

function slot0._gatherSkill(slot0, slot1, slot2, slot3)
	if not string.nilorempty(FightConfig.instance:getSkinSkillTimeline(slot2, slot3)) then
		for slot9, slot10 in ipairs(FightHelper.getTimelineListByName(slot4, slot2)) do
			if not slot0.context.timelineUrlDict[ResUrl.getSkillTimeline(slot10)] then
				slot0.context.timelineUrlDict[slot11] = slot1
			elseif slot12 == FightEnum.EntitySide.MySide and slot1 == FightEnum.EntitySide.EnemySide then
				slot0.context.timelineUrlDict[slot11] = FightEnum.EntitySide.BothSide
			elseif slot12 == FightEnum.EntitySide.EnemySide and slot1 == FightEnum.EntitySide.MySide then
				slot0.context.timelineUrlDict[slot11] = FightEnum.EntitySide.BothSide
			end

			slot0.context.timelineSkinDict[slot11] = slot0.context.timelineSkinDict[slot11] or {}
			slot0.context.timelineSkinDict[slot11][slot2 or 0] = true
		end
	end
end

return slot0
