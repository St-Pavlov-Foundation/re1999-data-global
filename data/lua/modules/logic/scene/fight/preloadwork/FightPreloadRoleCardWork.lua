module("modules.logic.scene.fight.preloadwork.FightPreloadRoleCardWork", package.seeall)

slot0 = class("FightPreloadRoleCardWork", BaseWork)
slot0.isOpen = true

function slot0.onStart(slot0, slot1)
	if not uv0.isOpen then
		slot0:onDone(true)

		return
	end

	slot0._loader = SequenceAbLoader.New()

	slot0:getRoleCardResList()
	slot0._loader:setConcurrentCount(10)
	slot0._loader:setPathList(slot0.resList)
	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0._onPreloadFinish(slot0)
	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		slot0.context.callback(slot0.context.callbackObj, slot6)
		FightPreloadController.instance:addRoleCardAsset(slot6)
	end

	slot0:onDone(true)
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("战斗卡牌加载失败：" .. slot2.ResPath)
end

function slot0.getRoleCardResList(slot0)
	slot0.resList = {}

	for slot5 = 1, 4 do
		slot6 = slot0:getSingleGroupModel():getById(slot5)
		slot8 = slot6:getMonsterCO()

		if slot6:getHeroCO() then
			logNormal("预加载 角色 卡牌资源 ： " .. slot7.name or "")
			slot0:addSkill(slot7.skill)
			slot0:addHeroExSkill(slot7.exSkill)
		elseif slot8 then
			logNormal("预加载 怪物 卡牌资源 ： " .. slot8.name or "")
			slot0:addSkill(slot8.activeSkill)
			slot0:addMonsterUniqueSkill(slot8.uniqueSkill)
		end
	end

	return slot0.resList
end

function slot0.getSingleGroupModel(slot0)
	slot2 = FightModel.instance:getFightParam() and slot1.episodeId

	if slot2 and DungeonConfig.instance:getEpisodeCO(slot2) and slot3.type == DungeonEnum.EpisodeType.Rouge then
		return RougeHeroSingleGroupModel.instance
	else
		return HeroSingleGroupModel.instance
	end
end

function slot0.addSkill(slot0, slot1)
	if string.nilorempty(slot1) then
		return
	end

	slot6 = true

	for slot6, slot7 in ipairs(FightStrUtil.instance:getSplitString2Cache(slot1, slot6)) do
		slot0:addResBySkillId(slot7[2])
	end
end

function slot0.addHeroExSkill(slot0, slot1)
	slot0:addResBySkillId(slot1)
end

function slot0.addMonsterUniqueSkill(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:addResBySkillId(slot6)
	end
end

function slot0.addResBySkillId(slot0, slot1)
	if lua_skill.configDict[slot1] then
		table.insert(slot0.resList, ResUrl.getSkillIcon(slot2.icon))
	else
		logError("技能表找不到id:" .. slot1)
	end
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
