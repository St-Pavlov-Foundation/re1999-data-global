module("modules.logic.season.controller.Activity104HeroGroupController", package.seeall)

local var_0_0 = class("Activity104HeroGroupController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_1_0._onGetInfoFinish, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_2_0._onGetFightRecordGroupReply, arg_2_0)
end

function var_0_0._onGetInfoFinish(arg_3_0)
	HeroGroupModel.instance:setParam()
end

function var_0_0.openGroupFightView(arg_4_0, arg_4_1, arg_4_2)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(arg_4_1, arg_4_2)

	local var_4_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_4_1 = DungeonModel.instance:getEpisodeInfo(arg_4_2)
	local var_4_2 = var_4_1 and var_4_1.star == DungeonEnum.StarType.Advanced and var_4_1.hasRecord
	local var_4_3 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")
	local var_4_4 = Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId)

	if var_4_0 and var_4_2 and not string.nilorempty(var_4_3) and not var_4_4 and cjson.decode(var_4_3)[tostring(arg_4_2)] then
		FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, arg_4_0._onGetFightRecordGroupReply, arg_4_0)
		FightRpc.instance:sendGetFightRecordGroupRequest(arg_4_2)

		return
	end

	Activity104Controller.instance:openSeasonHeroGroupFightView()
end

function var_0_0._onGetFightRecordGroupReply(arg_5_0, arg_5_1)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_5_0._onGetFightRecordGroupReply, arg_5_0)
	HeroGroupModel.instance:setReplayParam(arg_5_1)
	Activity104Controller.instance:openSeasonHeroGroupFightView()
end

var_0_0.instance = var_0_0.New()

return var_0_0
