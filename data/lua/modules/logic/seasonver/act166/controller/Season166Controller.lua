module("modules.logic.seasonver.act166.controller.Season166Controller", package.seeall)

local var_0_0 = class("Season166Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_3_0.handleReceiveActChanged, arg_3_0)
end

function var_0_0.handleReceiveActChanged(arg_4_0, arg_4_1)
	logNormal("handleReceiveActChanged : " .. tostring(arg_4_1))

	local var_4_0 = ActivityModel.instance:getOnlineActIdByType(Season166Enum.ActType)

	if var_4_0 then
		Activity166Rpc.instance:sendGet166InfosRequest(var_4_0[1])
	end
end

function var_0_0.openSeasonView(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 or {}

	var_5_0.actId = arg_5_1.actId or Season166Enum.ActId

	Activity166Rpc.instance:sendGet166InfosRequest(var_5_0.actId, function()
		arg_5_0:openSeasonMainView(var_5_0)
	end, arg_5_0)
end

function var_0_0.openSeasonMainView(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.actId or Season166Model.instance:getCurSeasonId()
	local var_7_1, var_7_2 = arg_7_0:getSeasonEnterCloseTimeStamp(var_7_0)

	if not ActivityModel.instance:isActOnLine(var_7_0) or var_7_2 <= 0 then
		logError(var_7_0 .. " not online!")

		return
	end

	ViewMgr.instance:openView(ViewName.Season166MainView, arg_7_1)
end

function var_0_0.openSeasonBaseSpotView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.Season166BaseSpotView, arg_8_1)
end

function var_0_0.openSeasonTrainView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.Season166TrainView, arg_9_1)
end

function var_0_0.openSeasonTeachView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.Season166TeachView, arg_10_1)
end

function var_0_0.enterSeasonTeachView(arg_11_0, arg_11_1)
	local var_11_0 = Season166Config.instance:getSeasonConstGlobalCo(Season166Enum.TeachStoryConstId)
	local var_11_1 = tonumber(var_11_0.value)

	if StoryModel.instance:isStoryFinished(var_11_1) then
		arg_11_0:openSeasonTeachView(arg_11_1)
	else
		local var_11_2 = {}

		var_11_2.mark = true

		StoryController.instance:playStory(var_11_1, var_11_2, arg_11_0.openSeasonTeachView, arg_11_0, arg_11_1)
	end
end

function var_0_0.openHeroGroupFightView(arg_12_0, arg_12_1)
	ViewMgr.instance:openView(ViewName.Season166HeroGroupFightView, arg_12_1)
end

function var_0_0.openSeason166TargetView(arg_13_0)
	local var_13_0 = Season166Model.instance:getCurSeasonId()
	local var_13_1 = Season166Model.instance:getBattleContext()

	if var_13_1 and var_13_1.baseId and var_13_1.baseId > 0 then
		ViewMgr.instance:openView(ViewName.Season166HeroGroupTargetView, {
			actId = var_13_0,
			baseId = var_13_1.baseId
		})
	end
end

function var_0_0.isSeason166EpisodeType(arg_14_0)
	return arg_14_0 == DungeonEnum.EpisodeType.Season166Base or arg_14_0 == DungeonEnum.EpisodeType.Season166Train or arg_14_0 == DungeonEnum.EpisodeType.Season166Teach
end

function var_0_0.getMaxHeroGroupCount()
	local var_15_0 = Season166HeroGroupModel.instance.episodeId
	local var_15_1 = (var_15_0 and lua_episode.configDict[var_15_0]).battleId

	return (var_15_1 and lua_battle.configDict[var_15_1]).roleNum
end

function var_0_0.openResultPanel(arg_16_0)
	ViewMgr.instance:openView(ViewName.Season166ResultPanel)
end

function var_0_0.openTalentInfoView(arg_17_0, arg_17_1)
	ViewMgr.instance:openView(ViewName.Season166TalentInfoView, arg_17_1)
end

function var_0_0.checkProcessFightReconnect(arg_18_0)
	local var_18_0 = FightModel.instance:getFightReason()
	local var_18_1 = var_18_0.episodeId
	local var_18_2 = DungeonConfig.instance:getEpisodeCO(var_18_1)

	if var_18_2 and var_0_0.isSeason166EpisodeType(var_18_2.type) then
		local var_18_3 = Season166Config.instance:getSeasonConfigByEpisodeId(var_18_1)
		local var_18_4
		local var_18_5 = var_18_2.type == DungeonEnum.EpisodeType.Season166Teach and 0 or var_18_3.talentId or Season166Model.getPrefsTalent()

		Season166Model.instance:setBattleContext(var_18_3.activityId, var_18_1, var_18_3.baseId, var_18_5, var_18_3.trainId, var_18_3.teachId)

		local var_18_6 = var_18_0.type == FightEnum.FightReason.DungeonRecord
		local var_18_7 = var_18_0.multiplication

		var_18_7 = var_18_7 and var_18_7 > 0 and var_18_7 or 1

		FightController.instance:setFightParamByEpisodeId(var_18_1, var_18_6, var_18_7, var_18_0.battleId)
		Season166HeroGroupModel.instance:setParam(var_18_0.battleId, var_18_1, false, true)
	end
end

local function var_0_1(arg_19_0)
	if string.nilorempty(arg_19_0) then
		return arg_19_0
	end

	local var_19_0 = Season166Model.instance:getCurSeasonId() or 0

	return (string.format("Season166_%s_%s", var_19_0, arg_19_0))
end

function var_0_0.savePlayerPrefs(arg_20_0, arg_20_1, arg_20_2)
	if string.nilorempty(arg_20_1) or not arg_20_2 then
		return
	end

	local var_20_0 = var_0_1(arg_20_1)

	if type(arg_20_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(var_20_0, arg_20_2)
	else
		GameUtil.playerPrefsSetStringByUserId(var_20_0, arg_20_2)
	end
end

function var_0_0.getPlayerPrefs(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_2 or ""

	if string.nilorempty(arg_21_1) then
		return var_21_0
	end

	local var_21_1 = var_0_1(arg_21_1)

	if type(var_21_0) == "number" then
		var_21_0 = GameUtil.playerPrefsGetNumberByUserId(var_21_1, var_21_0)
	else
		var_21_0 = GameUtil.playerPrefsGetStringByUserId(var_21_1, var_21_0)
	end

	return var_21_0
end

function var_0_0.loadDictFromStr(arg_22_0, arg_22_1)
	local var_22_0 = {}

	if not string.nilorempty(arg_22_1) then
		var_22_0 = cjson.decode(arg_22_1)
	end

	return var_22_0
end

function var_0_0.getSeasonEnterCloseTimeStamp(arg_23_0, arg_23_1)
	local var_23_0 = ActivityModel.instance:getActMO(arg_23_1)

	if not var_23_0 then
		return 0
	end

	local var_23_1 = Season166Config.instance:getSeasonConstNum(arg_23_1, Season166Enum.CloseSeasonEnterTime)
	local var_23_2 = var_23_0:getRealStartTimeStamp()
	local var_23_3 = var_23_0:getRealEndTimeStamp()
	local var_23_4 = var_23_2 + var_23_1 * TimeUtil.OneDaySecond
	local var_23_5 = var_23_1 > 0 and var_23_4 or var_23_3
	local var_23_6 = var_23_5 - ServerTime.now()

	return var_23_5, var_23_6
end

function var_0_0.tryGetToastAsset(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0._toastLoader and not arg_24_0._toastLoader.isLoading then
		return (arg_24_0._toastLoader:getAssetItem(Season166Enum.ToastPath):GetResource(Season166Enum.ToastPath))
	end

	if not arg_24_0._toastLoader then
		arg_24_0._toastLoader = MultiAbLoader.New()

		arg_24_0._toastLoader:addPath(Season166Enum.ToastPath)
		arg_24_0._toastLoader:startLoad(arg_24_1, arg_24_2)
	end

	return nil
end

function var_0_0.fillToastObj(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = ToastCallbackGroup.New()

	var_25_0.onClose = arg_25_0.onCloseWhenToastRemove
	var_25_0.onCloseObj = arg_25_0
	var_25_0.onCloseParam = arg_25_2
	var_25_0.onOpen = arg_25_0.onOpenToast
	var_25_0.onOpenObj = arg_25_0
	var_25_0.onOpenParam = arg_25_2
	arg_25_1.callbackGroup = var_25_0
end

function var_0_0.onOpenToast(arg_26_0, arg_26_1, arg_26_2)
	arg_26_1.item = Season166ToastItem.New()

	arg_26_1.item:init(arg_26_2, arg_26_1)
end

function var_0_0.onCloseWhenToastRemove(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1.item then
		arg_27_1.item:dispose()

		arg_27_1.item = nil
	end
end

function var_0_0.showToast(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1 == Season166Enum.ToastType.Talent and luaLang("p_season166resultview_txt_tips") or luaLang("season166_newinfo_unlock")
	local var_28_1 = arg_28_1 == Season166Enum.ToastType.Talent and 1 or 2
	local var_28_2 = {
		toastTip = var_28_0,
		icon = var_28_1
	}

	ToastController.instance:showToastWithCustomData(ToastEnum.Season166ReportNotUnlock, arg_28_0.fillToastObj, arg_28_0, var_28_2)
end

function var_0_0.enterReportItem(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = Season166Model.instance:getActInfo(arg_29_1)
	local var_29_1 = var_29_0 and var_29_0:getInformationMO(arg_29_2)
	local var_29_2 = {
		actId = arg_29_1,
		infoId = arg_29_2,
		unlockState = var_29_1 and Season166Enum.UnlockState or Season166Enum.LockState
	}

	var_0_0.instance:dispatchEvent(Season166Event.ClickInfoReportItem, var_29_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
