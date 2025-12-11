module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftView", package.seeall)

local var_0_0 = class("VersionActivity2_3NewCultivationGiftView", BaseView)

var_0_0.REMAIN_TIME_REFRESH_INTERVAL = 10

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_FullBG/#simage_Title")
	arg_1_0._simageTitle2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_FullBG/#simage_Title2")
	arg_1_0._simagerole = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_FullBG/#simage_role")
	arg_1_0._simagedec1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_FullBG/#simage_dec1")
	arg_1_0._simagedec2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_FullBG/#simage_dec2")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/reward/#btn_reward")
	arg_1_0._btnstone = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/stone/txt_dec/#btn_stone")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Btn/#btn_get")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "Root/Btn/hasget")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnstone:AddClickListener(arg_2_0._btnstoneOnClick, arg_2_0)
	arg_2_0._btnget:AddClickListener(arg_2_0._btngetOnClick, arg_2_0)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, arg_2_0.onEpisodeFinished, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0.refreshRemainTime, arg_2_0, arg_2_0.REMAIN_TIME_REFRESH_INTERVAL)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnstone:RemoveClickListener()
	arg_3_0._btnget:RemoveClickListener()
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, arg_3_0.onEpisodeFinished, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshRemainTime, arg_3_0)
end

function var_0_0._btnrewardOnClick(arg_4_0)
	local var_4_0 = {
		actId = arg_4_0._actId,
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Reward
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_4_0)
end

function var_0_0._btnstoneOnClick(arg_5_0)
	local var_5_0 = VersionActivity2_3NewCultivationDestinyModel.instance:getDestinyStoneById(arg_5_0._actId)
	local var_5_1 = {
		actId = arg_5_0._actId,
		destinyId = var_5_0,
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_5_1)
end

function var_0_0._btnrewarddetailOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationGiftRewardView)
end

function var_0_0._btndetailOnClick(arg_7_0)
	return
end

function var_0_0._btngetOnClick(arg_8_0)
	if not Activity125Model.instance:isActivityOpen(arg_8_0._actId) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	local var_8_0 = Activity125Model.instance:getById(arg_8_0._actId)

	if var_8_0 == nil then
		return
	end

	local var_8_1 = var_8_0:getEpisodeList()

	if var_8_1 == nil or #var_8_1 <= 0 then
		return
	end

	local var_8_2 = var_8_1[1].id

	if var_8_0:isEpisodeFinished(var_8_2) then
		return
	end

	logNormal(string.format("_btninviteOnClick actId: %s episodeId: %s", tostring(arg_8_0._actId), tostring(var_8_2)))

	local var_8_3 = Activity125Config.instance:getEpisodeConfig(arg_8_0._actId, var_8_2)

	Activity125Controller.instance:onFinishActEpisode(arg_8_0._actId, var_8_2, var_8_3.targetFrequency)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._goKeywordParent = gohelper.findChild(arg_9_0.viewGO, "Root/stone/#go_keyword")
	arg_9_0._keywordItemList = {}

	local var_9_0 = arg_9_0._goKeywordParent.transform.childCount

	for iter_9_0 = 1, var_9_0 do
		local var_9_1 = arg_9_0._goKeywordParent.transform:GetChild(iter_9_0 - 1)
		local var_9_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1.gameObject, VersionActivity2_3NewCultivationKeywordItem)

		table.insert(arg_9_0._keywordItemList, var_9_2)
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	local var_11_0 = arg_11_0.viewParam.parent

	gohelper.addChild(var_11_0, arg_11_0.viewGO)

	local var_11_1 = arg_11_0.viewParam.actId

	arg_11_0._actId = var_11_1

	Activity125Controller.instance:getAct125InfoFromServer(var_11_1)
end

function var_0_0.onEpisodeFinished(arg_12_0)
	local var_12_0 = Activity125Model.instance:getById(arg_12_0._actId)

	if var_12_0 == nil then
		return
	end

	local var_12_1 = var_12_0:getEpisodeList()

	if var_12_1 == nil or #var_12_1 <= 0 then
		return
	end

	logNormal(string.format("onEpisodeFinished actId: %s", tostring(arg_12_0._actId)))
	arg_12_0:_refreshUI()
end

function var_0_0._refreshUI(arg_13_0)
	local var_13_0 = Activity125Model.instance:getById(arg_13_0._actId)

	if var_13_0 == nil then
		return
	end

	local var_13_1 = var_13_0:getEpisodeList()

	if var_13_1 == nil or #var_13_1 <= 0 then
		return
	end

	local var_13_2 = var_13_1[1].id
	local var_13_3 = var_13_0:isEpisodeFinished(var_13_2)

	gohelper.setActive(arg_13_0._btnget, not var_13_3)
	gohelper.setActive(arg_13_0._gohasget, var_13_3)
	arg_13_0:refreshRemainTime()
	arg_13_0:_refreshKeyword()
end

function var_0_0._refreshKeyword(arg_14_0)
	local var_14_0 = ActivityConfig.instance:getActivityCo(arg_14_0._actId).param
	local var_14_1 = string.nilorempty(var_14_0)

	gohelper.setActive(arg_14_0._goKeywordParent, not var_14_1)

	if var_14_1 then
		return
	end

	local var_14_2 = string.splitToNumber(var_14_0, "#")

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		local var_14_3 = arg_14_0._keywordItemList[iter_14_0]

		if not var_14_3 then
			logError("狂想预热数量超过上限")
		else
			local var_14_4 = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(iter_14_1)

			var_14_3:refreshKeyword(var_14_4.keyword)
		end
	end

	local var_14_5 = #arg_14_0._keywordItemList
	local var_14_6 = #var_14_2

	if var_14_6 < var_14_5 then
		for iter_14_2 = var_14_6 + 1, var_14_5 do
			arg_14_0._keywordItemList[iter_14_2]:refreshKeyword(nil)
		end
	end
end

function var_0_0.refreshRemainTime(arg_15_0)
	local var_15_0 = ActivityModel.instance:getActMO(arg_15_0._actId):getRealEndTimeStamp()
	local var_15_1 = ServerTime.now()

	if var_15_0 <= var_15_1 then
		arg_15_0._txtLimitTime.text = luaLang("ended")

		return
	end

	local var_15_2 = TimeUtil.SecondToActivityTimeFormat(var_15_0 - var_15_1)

	arg_15_0._txtLimitTime.text = var_15_2
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
