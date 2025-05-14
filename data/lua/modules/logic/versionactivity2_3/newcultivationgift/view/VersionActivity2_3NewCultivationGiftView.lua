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
	local var_5_0 = {
		actId = arg_5_0._actId,
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_5_0)
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
	return
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

function var_0_0._refreshUI(arg_12_0)
	local var_12_0 = Activity125Model.instance:getById(arg_12_0._actId)

	if var_12_0 == nil then
		return
	end

	local var_12_1 = var_12_0:getEpisodeList()

	if var_12_1 == nil or #var_12_1 <= 0 then
		return
	end

	local var_12_2 = var_12_1[1].id
	local var_12_3 = var_12_0:isEpisodeFinished(var_12_2)

	gohelper.setActive(arg_12_0._btnget, not var_12_3)
	gohelper.setActive(arg_12_0._gohasget, var_12_3)
	arg_12_0:refreshRemainTime()
end

function var_0_0.onEpisodeFinished(arg_13_0)
	local var_13_0 = Activity125Model.instance:getById(arg_13_0._actId)

	if var_13_0 == nil then
		return
	end

	local var_13_1 = var_13_0:getEpisodeList()

	if var_13_1 == nil or #var_13_1 <= 0 then
		return
	end

	logNormal(string.format("onEpisodeFinished actId: %s", tostring(arg_13_0._actId)))
	arg_13_0:_refreshUI()
end

function var_0_0.refreshRemainTime(arg_14_0)
	local var_14_0 = ActivityModel.instance:getActMO(arg_14_0._actId):getRealEndTimeStamp()
	local var_14_1 = ServerTime.now()

	if var_14_0 <= var_14_1 then
		arg_14_0._txtLimitTime.text = luaLang("ended")

		return
	end

	local var_14_2 = TimeUtil.SecondToActivityTimeFormat(var_14_0 - var_14_1)

	arg_14_0._txtLimitTime.text = var_14_2
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
