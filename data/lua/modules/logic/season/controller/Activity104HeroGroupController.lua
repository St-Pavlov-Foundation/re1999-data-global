module("modules.logic.season.controller.Activity104HeroGroupController", package.seeall)

slot0 = class("Activity104HeroGroupController", BaseController)

function slot0.addConstEvents(slot0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, slot0._onGetInfoFinish, slot0)
end

function slot0.reInit(slot0)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
end

function slot0._onGetInfoFinish(slot0)
	HeroGroupModel.instance:setParam()
end

function slot0.openGroupFightView(slot0, slot1, slot2)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(slot1, slot2)

	slot6 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) and (DungeonModel.instance:getEpisodeInfo(slot2) and slot4.star == DungeonEnum.StarType.Advanced and slot4.hasRecord) and not string.nilorempty(slot6) and not Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId) and cjson.decode(slot6)[tostring(slot2)] then
		FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
		FightRpc.instance:sendGetFightRecordGroupRequest(slot2)

		return
	end

	Activity104Controller.instance:openSeasonHeroGroupFightView()
end

function slot0._onGetFightRecordGroupReply(slot0, slot1)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
	HeroGroupModel.instance:setReplayParam(slot1)
	Activity104Controller.instance:openSeasonHeroGroupFightView()
end

slot0.instance = slot0.New()

return slot0
