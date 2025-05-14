module("modules.logic.seasonver.act123.controller.Season123RetailController", package.seeall)

local var_0_0 = class("Season123RetailController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1)
	Season123Controller.instance:registerCallback(Season123Event.StartEnterBattle, arg_1_0.handleStartEnterBattle, arg_1_0)
	Season123RetailModel.instance:init(arg_1_1)
end

function var_0_0.onCloseView(arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.StartEnterBattle, arg_2_0.handleStartEnterBattle, arg_2_0)
	Season123RetailModel.instance:release()
end

function var_0_0.enterRetailFightScene(arg_3_0)
	local var_3_0 = Season123RetailModel.instance:getUTTUTicketNum()
	local var_3_1 = Season123RetailModel.instance.activityId

	if var_3_0 <= 0 then
		local var_3_2 = Season123Config.instance:getEquipItemCoin(var_3_1, Activity123Enum.Const.UttuTicketsCoin)
		local var_3_3 = CurrencyConfig.instance:getCurrencyCo(var_3_2)

		if var_3_3 then
			GameFacade.showToast(ToastEnum.NotEnoughId, var_3_3.name)
		end

		return
	end

	local var_3_4 = Season123RetailModel.instance:getEpisodeId()

	if var_3_4 then
		Season123EpisodeDetailModel.instance.lastSendEpisodeCfg = Season123RetailModel.instance.episodeCO

		arg_3_0:startBattle(var_3_1, var_3_4)
	end
end

function var_0_0.startBattle(arg_4_0, arg_4_1, arg_4_2)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", arg_4_1, arg_4_2))

	local var_4_0 = DungeonConfig.instance:getEpisodeCO(arg_4_2)

	Season123Model.instance:setBattleContext(arg_4_1, nil, nil, arg_4_2)
	DungeonFightController.instance:enterSeasonFight(var_4_0.chapterId, arg_4_2)
end

function var_0_0.handleStartEnterBattle(arg_5_0, arg_5_1)
	if not Season123RetailModel.instance.lastSendEpisodeCfg then
		return
	end

	local var_5_0 = Season123RetailModel.instance.lastSendEpisodeCfg
	local var_5_1 = arg_5_1.actId
	local var_5_2 = arg_5_1.layer

	if var_5_0 and var_5_1 == Season123RetailModel.instance.activityId then
		DungeonFightController.instance:enterSeasonFight(var_5_0.chapterId, var_5_0.id)
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
