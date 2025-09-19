module("modules.logic.scene.fight.preloadwork.FightPreloadRoleCardByRealDataWork", package.seeall)

local var_0_0 = class("FightPreloadRoleCardByRealDataWork", BaseWork)

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

	local var_4_0 = {}

	FightDataHelper.entityMgr:getMyNormalList(var_4_0)
	FightDataHelper.entityMgr:getMySpList(var_4_0)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1.skillGroup1) do
			arg_4_0:addResBySkillId(iter_4_3)
		end

		for iter_4_4, iter_4_5 in ipairs(iter_4_1.skillGroup2) do
			arg_4_0:addResBySkillId(iter_4_5)
		end

		if iter_4_1.exSkill ~= 0 then
			arg_4_0:addResBySkillId(iter_4_1.exSkill)
		end
	end

	return arg_4_0.resList
end

function var_0_0.addResBySkillId(arg_5_0, arg_5_1)
	local var_5_0 = lua_skill.configDict[arg_5_1]

	if var_5_0 then
		if var_5_0.icon == 0 then
			logError("技能未配置icon, skillId:" .. arg_5_1)
		else
			table.insert(arg_5_0.resList, ResUrl.getSkillIcon(var_5_0.icon))

			local var_5_1 = lua_fight_card_choice.configDict[arg_5_1]

			if var_5_1 then
				local var_5_2 = string.splitToNumber(var_5_1.choiceSkIlls, "#")

				for iter_5_0, iter_5_1 in ipairs(var_5_2) do
					local var_5_3 = lua_skill.configDict[iter_5_1]

					if var_5_3 then
						table.insert(arg_5_0.resList, ResUrl.getSkillIcon(var_5_3.icon))
					end
				end
			end
		end
	elseif arg_5_1 ~= 0 then
		logError("技能表找不到id:" .. arg_5_1)
	end
end

function var_0_0.clearWork(arg_6_0)
	if arg_6_0._loader then
		arg_6_0._loader:dispose()

		arg_6_0._loader = nil
	end
end

return var_0_0
