module("modules.logic.seasonver.act166.controller.Season166Controller", package.seeall)

slot0 = class("Season166Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0.handleReceiveActChanged, slot0)
end

function slot0.handleReceiveActChanged(slot0, slot1)
	logNormal("handleReceiveActChanged : " .. tostring(slot1))

	if ActivityModel.instance:getOnlineActIdByType(Season166Enum.ActType) then
		Activity166Rpc.instance:sendGet166InfosRequest(slot2[1])
	end
end

function slot0.openSeasonView(slot0, slot1)
	slot2 = slot1 or {}
	slot2.actId = slot1.actId or Season166Enum.ActId

	Activity166Rpc.instance:sendGet166InfosRequest(slot2.actId, function ()
		uv0:openSeasonMainView(uv1)
	end, slot0)
end

function slot0.openSeasonMainView(slot0, slot1)
	slot2 = slot1.actId or Season166Model.instance:getCurSeasonId()
	slot3, slot4 = slot0:getSeasonEnterCloseTimeStamp(slot2)

	if not ActivityModel.instance:isActOnLine(slot2) or slot4 <= 0 then
		logError(slot2 .. " not online!")

		return
	end

	ViewMgr.instance:openView(ViewName.Season166MainView, slot1)
end

function slot0.openSeasonBaseSpotView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Season166BaseSpotView, slot1)
end

function slot0.openSeasonTrainView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Season166TrainView, slot1)
end

function slot0.openSeasonTeachView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Season166TeachView, slot1)
end

function slot0.enterSeasonTeachView(slot0, slot1)
	if StoryModel.instance:isStoryFinished(tonumber(Season166Config.instance:getSeasonConstGlobalCo(Season166Enum.TeachStoryConstId).value)) then
		slot0:openSeasonTeachView(slot1)
	else
		StoryController.instance:playStory(slot3, {
			mark = true
		}, slot0.openSeasonTeachView, slot0, slot1)
	end
end

function slot0.openHeroGroupFightView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Season166HeroGroupFightView, slot1)
end

function slot0.openSeason166TargetView(slot0)
	if Season166Model.instance:getBattleContext() and slot2.baseId and slot2.baseId > 0 then
		ViewMgr.instance:openView(ViewName.Season166HeroGroupTargetView, {
			actId = Season166Model.instance:getCurSeasonId(),
			baseId = slot2.baseId
		})
	end
end

function slot0.isSeason166EpisodeType(slot0)
	return slot0 == DungeonEnum.EpisodeType.Season166Base or slot0 == DungeonEnum.EpisodeType.Season166Train or slot0 == DungeonEnum.EpisodeType.Season166Teach
end

function slot0.getMaxHeroGroupCount()
	return ((Season166HeroGroupModel.instance.episodeId and lua_episode.configDict[slot0]).battleId and lua_battle.configDict[slot2]).roleNum
end

function slot0.openResultPanel(slot0)
	ViewMgr.instance:openView(ViewName.Season166ResultPanel)
end

function slot0.openTalentInfoView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Season166TalentInfoView, slot1)
end

function slot0.checkProcessFightReconnect(slot0)
	if DungeonConfig.instance:getEpisodeCO(FightModel.instance:getFightReason().episodeId) and uv0.isSeason166EpisodeType(slot3.type) then
		slot4 = Season166Config.instance:getSeasonConfigByEpisodeId(slot2)
		slot5 = nil

		Season166Model.instance:setBattleContext(slot4.activityId, slot2, slot4.baseId, slot3.type == DungeonEnum.EpisodeType.Season166Teach and 0 or slot4.talentId or Season166Model.getPrefsTalent(), slot4.trainId, slot4.teachId)
		FightController.instance:setFightParamByEpisodeId(slot2, slot1.type == FightEnum.FightReason.DungeonRecord, slot1.multiplication and slot7 > 0 and slot7 or 1, slot1.battleId)
		Season166HeroGroupModel.instance:setParam(slot1.battleId, slot2, false, true)
	end
end

function slot1(slot0)
	if string.nilorempty(slot0) then
		return slot0
	end

	return string.format("Season166_%s_%s", Season166Model.instance:getCurSeasonId() or 0, slot0)
end

function slot0.savePlayerPrefs(slot0, slot1, slot2)
	if string.nilorempty(slot1) or not slot2 then
		return
	end

	if type(slot2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(uv0(slot1), slot2)
	else
		GameUtil.playerPrefsSetStringByUserId(slot3, slot2)
	end
end

function slot0.getPlayerPrefs(slot0, slot1, slot2)
	slot3 = slot2 or ""

	if string.nilorempty(slot1) then
		return slot3
	end

	slot4 = uv0(slot1)

	return (not (type(slot3) == "number") or GameUtil.playerPrefsGetNumberByUserId(slot4, slot3)) and GameUtil.playerPrefsGetStringByUserId(slot4, slot3)
end

function slot0.loadDictFromStr(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) then
		slot2 = cjson.decode(slot1)
	end

	return slot2
end

function slot0.getSeasonEnterCloseTimeStamp(slot0, slot1)
	if not ActivityModel.instance:getActMO(slot1) then
		return 0
	end

	slot3 = Season166Config.instance:getSeasonConstNum(slot1, Season166Enum.CloseSeasonEnterTime)
	slot7 = slot3 > 0 and slot2:getRealStartTimeStamp() + slot3 * TimeUtil.OneDaySecond or slot2:getRealEndTimeStamp()

	return slot7, slot7 - ServerTime.now()
end

function slot0.tryGetToastAsset(slot0, slot1, slot2)
	if slot0._toastLoader and not slot0._toastLoader.isLoading then
		return slot0._toastLoader:getAssetItem(Season166Enum.ToastPath):GetResource(Season166Enum.ToastPath)
	end

	if not slot0._toastLoader then
		slot0._toastLoader = MultiAbLoader.New()

		slot0._toastLoader:addPath(Season166Enum.ToastPath)
		slot0._toastLoader:startLoad(slot1, slot2)
	end

	return nil
end

function slot0.fillToastObj(slot0, slot1, slot2)
	slot3 = ToastCallbackGroup.New()
	slot3.onClose = slot0.onCloseWhenToastRemove
	slot3.onCloseObj = slot0
	slot3.onCloseParam = slot2
	slot3.onOpen = slot0.onOpenToast
	slot3.onOpenObj = slot0
	slot3.onOpenParam = slot2
	slot1.callbackGroup = slot3
end

function slot0.onOpenToast(slot0, slot1, slot2)
	slot1.item = Season166ToastItem.New()

	slot1.item:init(slot2, slot1)
end

function slot0.onCloseWhenToastRemove(slot0, slot1, slot2)
	if slot1.item then
		slot1.item:dispose()

		slot1.item = nil
	end
end

function slot0.showToast(slot0, slot1)
	ToastController.instance:showToastWithCustomData(ToastEnum.Season166ReportNotUnlock, slot0.fillToastObj, slot0, {
		toastTip = slot1 == Season166Enum.ToastType.Talent and luaLang("p_season166resultview_txt_tips") or luaLang("season166_newinfo_unlock"),
		icon = slot1 == Season166Enum.ToastType.Talent and 1 or 2
	})
end

slot0.instance = slot0.New()

return slot0
