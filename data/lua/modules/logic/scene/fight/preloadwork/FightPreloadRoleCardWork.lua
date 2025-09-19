module("modules.logic.scene.fight.preloadwork.FightPreloadRoleCardWork", package.seeall)

local var_0_0 = class("FightPreloadRoleCardWork", BaseWork)

var_0_0.isOpen = true

function var_0_0.onStart(arg_1_0, arg_1_1)
	if not var_0_0.isOpen then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._loader = SequenceAbLoader.New()

	arg_1_0:getRoleCardResList()
	arg_1_0._loader:setConcurrentCount(10)
	arg_1_0._loader:setPathList(arg_1_0.resList)
	arg_1_0._loader:setLoadFailCallback(arg_1_0._onPreloadOneFail)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	local var_2_0 = arg_2_0._loader:getAssetItemDict()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		arg_2_0.context.callback(arg_2_0.context.callbackObj, iter_2_1)
		FightPreloadController.instance:addRoleCardAsset(iter_2_1)
	end

	arg_2_0:onDone(true)
end

function var_0_0._onPreloadOneFail(arg_3_0, arg_3_1, arg_3_2)
	logError("战斗卡牌加载失败：" .. arg_3_2.ResPath)
end

function var_0_0.getRoleCardResList(arg_4_0)
	arg_4_0.resList = {}

	local var_4_0 = arg_4_0:getSingleGroupModel()

	for iter_4_0 = 1, 4 do
		local var_4_1 = var_4_0:getById(iter_4_0)
		local var_4_2 = var_4_1:getHeroCO()
		local var_4_3 = var_4_1:getMonsterCO()

		if var_4_2 then
			logNormal("预加载 角色 卡牌资源 ： " .. var_4_2.name or "")
			arg_4_0:addSkill(var_4_2.skill)
			arg_4_0:addHeroExSkill(var_4_2.exSkill)
		elseif var_4_3 then
			logNormal("预加载 怪物 卡牌资源 ： " .. var_4_3.name or "")
			arg_4_0:addSkill(var_4_3.activeSkill)
			arg_4_0:addMonsterUniqueSkill(var_4_3.uniqueSkill)
		end
	end

	return arg_4_0.resList
end

function var_0_0.getSingleGroupModel(arg_5_0)
	local var_5_0 = FightModel.instance:getFightParam()
	local var_5_1 = var_5_0 and var_5_0.episodeId
	local var_5_2 = var_5_1 and DungeonConfig.instance:getEpisodeCO(var_5_1)

	if var_5_2 and var_5_2.type == DungeonEnum.EpisodeType.Rouge then
		return RougeHeroSingleGroupModel.instance
	else
		return HeroSingleGroupModel.instance
	end
end

function var_0_0.addSkill(arg_6_0, arg_6_1)
	if string.nilorempty(arg_6_1) then
		return
	end

	local var_6_0 = FightStrUtil.instance:getSplitString2Cache(arg_6_1, true)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		arg_6_0:addResBySkillId(iter_6_1[2])
	end
end

function var_0_0.addHeroExSkill(arg_7_0, arg_7_1)
	arg_7_0:addResBySkillId(arg_7_1)
end

function var_0_0.addMonsterUniqueSkill(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		arg_8_0:addResBySkillId(iter_8_1)
	end
end

function var_0_0.addResBySkillId(arg_9_0, arg_9_1)
	local var_9_0 = lua_skill.configDict[arg_9_1]

	if var_9_0 then
		if var_9_0.icon == 0 then
			logError("技能未配置icon, skillId:" .. arg_9_1)
		else
			table.insert(arg_9_0.resList, ResUrl.getSkillIcon(var_9_0.icon))
		end
	elseif arg_9_1 ~= 0 then
		logError("技能表找不到id:" .. arg_9_1)
	end
end

function var_0_0.clearWork(arg_10_0)
	if arg_10_0._loader then
		arg_10_0._loader:dispose()

		arg_10_0._loader = nil
	end
end

return var_0_0
