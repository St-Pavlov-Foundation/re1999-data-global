module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftFullView", package.seeall)

local var_0_0 = class("VersionActivity2_3NewCultivationGiftFullView", BaseView)

var_0_0.REMAIN_TIME_REFRESH_INTERVAL = 10

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_bg")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._simagedec = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_dec")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/reward/#btn_reward")
	arg_1_0._simageTitle2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/reward/#simage_Title2")
	arg_1_0._btnstone = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/stone/txt_dec/#btn_stone")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Btn/#btn_get")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "Root/Btn/hasget")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnstone:AddClickListener(arg_2_0._btnstoneOnClick, arg_2_0)
	arg_2_0._btnget:AddClickListener(arg_2_0._btngetOnClick, arg_2_0)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, arg_2_0.onEpisodeFinished, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0.refreshRemainTime, arg_2_0, arg_2_0.REMAIN_TIME_REFRESH_INTERVAL)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnstone:RemoveClickListener()
	arg_3_0._btnget:RemoveClickListener()
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, arg_3_0.onEpisodeFinished, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshRemainTime, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
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

function var_0_0._btnrewardOnClick(arg_6_0)
	local var_6_0 = {
		actId = arg_6_0._actId,
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Reward
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_6_0)
end

function var_0_0._btngetOnClick(arg_7_0)
	if not Activity125Model.instance:isActivityOpen(arg_7_0._actId) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	local var_7_0 = Activity125Model.instance:getById(arg_7_0._actId)

	if var_7_0 == nil then
		return
	end

	local var_7_1 = var_7_0:getEpisodeList()

	if var_7_1 == nil or #var_7_1 <= 0 then
		return
	end

	local var_7_2 = var_7_1[1].id

	if var_7_0:isEpisodeFinished(var_7_2) then
		return
	end

	logNormal(string.format("_btninviteOnClick actId: %s episodeId: %s", tostring(arg_7_0._actId), tostring(var_7_2)))

	local var_7_3 = Activity125Config.instance:getEpisodeConfig(arg_7_0._actId, var_7_2)

	Activity125Controller.instance:onFinishActEpisode(arg_7_0._actId, var_7_2, var_7_3.targetFrequency)
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._actId = arg_10_0.viewParam.actId

	arg_10_0:_refreshUI()
end

function var_0_0._refreshUI(arg_11_0)
	local var_11_0 = Activity125Model.instance:getById(arg_11_0._actId)

	if var_11_0 == nil then
		return
	end

	local var_11_1 = var_11_0:getEpisodeList()

	if var_11_1 == nil or #var_11_1 <= 0 then
		return
	end

	local var_11_2 = var_11_1[1].id
	local var_11_3 = var_11_0:isEpisodeFinished(var_11_2)

	gohelper.setActive(arg_11_0._btnget, not var_11_3)
	gohelper.setActive(arg_11_0._gohasget, var_11_3)
	arg_11_0:refreshRemainTime()
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

function var_0_0.refreshRemainTime(arg_13_0)
	local var_13_0 = ActivityModel.instance:getActMO(arg_13_0._actId):getRealEndTimeStamp()
	local var_13_1 = ServerTime.now()

	if var_13_0 <= var_13_1 then
		arg_13_0._txtLimitTime.text = luaLang("ended")

		return
	end

	local var_13_2 = TimeUtil.SecondToActivityTimeFormat(var_13_0 - var_13_1)

	arg_13_0._txtLimitTime.text = var_13_2
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
