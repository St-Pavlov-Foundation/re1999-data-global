module("modules.logic.seasonver.act166.controller.Season166HeroGroupController", package.seeall)

local var_0_0 = class("Season166HeroGroupController", BaseController)

function var_0_0.onOpenViewInitData(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Season166Model.instance:getBattleContext()

	if var_1_0 then
		local var_1_1 = DungeonConfig.instance:getEpisodeCO(var_1_0.episodeId)

		if var_1_1 then
			HeroGroupTrialModel.instance:setTrialByBattleId(var_1_1.battleId)
		end
	end

	Season166HeroGroupEditModel.instance:init(arg_1_1, arg_1_2)
	Season166HeroGroupQuickEditModel.instance:init(arg_1_1, arg_1_2)
end

function var_0_0.onCloseViewCleanData(arg_2_0)
	arg_2_0:saveCurrentHeroGroup()
end

function var_0_0.cleanAssistHeroGroup(arg_3_0)
	local var_3_0 = Season166HeroSingleGroupModel.instance.assistMO

	if not var_3_0 then
		return
	end

	Season166HeroSingleGroupModel.instance:removeFrom(var_3_0.id)
	Season166HeroSingleGroupModel.instance:setAssistHeroGroupMO(nil)
end

function var_0_0.openHeroGroupView(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Season166Model.instance:getBattleContext()

	if not var_4_0 then
		return
	end

	Season166HeroGroupModel.instance:setParam(arg_4_1, arg_4_2)
	Season166HeroGroupModel.instance:cleanAssistData()

	HeroGroupModel.instance.battleId = arg_4_1

	local var_4_1 = Season166HeroGroupModel.instance:getMaxHeroCountInGroup()

	Season166HeroSingleGroupModel.instance:setMaxHeroCount(var_4_1)
	Season166HeroGroupModel.instance:setCurGroupId(1)
	Season166Controller.instance:openHeroGroupFightView({
		actId = var_4_0.actId,
		battleId = var_4_0.battleId,
		episodeId = var_4_0.episodeId
	})
end

function var_0_0.checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local var_5_0 = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(var_5_0.clothId) then
		return
	end

	local var_5_1 = PlayerClothModel.instance:getList()

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		if PlayerClothModel.instance:hasCloth(iter_5_1.id) then
			HeroGroupModel.instance:replaceCloth(iter_5_1.id)

			return true
		end
	end
end

function var_0_0.saveCurrentHeroGroup(arg_6_0)
	local var_6_0 = Season166HeroGroupModel.instance.actId

	if not var_6_0 then
		return
	end

	if not Season166Model.instance:getActInfo(var_6_0) then
		return
	end

	local var_6_1 = Season166HeroGroupModel.instance:getCurGroupMO()

	if not var_6_1 then
		return
	end

	if var_6_1.isHaveTrial then
		return
	end

	arg_6_0:syncHeroGroup(var_6_1, 1, var_6_0)
end

function var_0_0.syncHeroGroup(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	Season166HeroSingleGroupModel.instance:setSingleGroup(arg_7_1, true)

	local var_7_0 = Season166Model.instance:getBattleContext()
	local var_7_1 = {
		groupIndex = arg_7_2,
		heroGroup = arg_7_1
	}

	if Season166HeroGroupModel.instance:isSeason166BaseSpotEpisode() then
		Season166HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season166Base, var_7_0.episodeId, true, var_7_1)
	elseif Season166HeroGroupModel.instance:isSeason166TrainEpisode() then
		Season166HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season166Train, var_7_0.episodeId, true, var_7_1)
	elseif Season166HeroGroupModel.instance:isSeason166TeachEpisode() then
		Season166HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season166Teach, var_7_0.episodeId, true, var_7_1)
	end
end

function var_0_0.sendStartAct166Battle(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7, arg_8_8, arg_8_9, arg_8_10, arg_8_11)
	local var_8_0 = Season166HeroGroupModel.instance.actId
	local var_8_1 = arg_8_3 and lua_episode.configDict[arg_8_3].type

	if not var_8_1 then
		logError("episodeType is nil, episodeId = " .. arg_8_3)

		return
	end

	Activity166Rpc.instance:sendStartAct166BattleRequest(var_8_0, var_8_1, arg_8_1, arg_8_4, arg_8_2, arg_8_3, arg_8_5, arg_8_6, arg_8_7, arg_8_8, arg_8_9, arg_8_10, arg_8_11)
end

var_0_0.instance = var_0_0.New()

return var_0_0
