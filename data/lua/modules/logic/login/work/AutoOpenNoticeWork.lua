module("modules.logic.login.work.AutoOpenNoticeWork", package.seeall)

local var_0_0 = class("AutoOpenNoticeWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if VersionValidator.instance:isInReviewing() then
		arg_1_0:onDone(true)

		return
	end

	if GameFacade.isExternalTest() then
		arg_1_0:onDone(true)

		return
	end

	if SDKMgr.getShowNotice and not SDKMgr.instance:getShowNotice() then
		arg_1_0:onDone(true)

		return
	end

	NoticeController.instance:startRequest(arg_1_0.onReceiveNotice, arg_1_0)
end

function var_0_0.onReceiveNotice(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_1 then
		return arg_2_0:onDone(true)
	end

	if not NoticeModel.instance:canAutoOpen() then
		return arg_2_0:onDone(true)
	end

	NoticeController.instance:getNoticeConfig(arg_2_0.autoOpenNoticeView, arg_2_0)
end

function var_0_0.autoOpenNoticeView(arg_3_0)
	arg_3_0:saveCurrentTime()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0.onCloseViewFinish, arg_3_0)
	NoticeController.instance:setAutoOpenNoticeView(true)
	ViewMgr.instance:openView(ViewName.NoticeView)
end

function var_0_0.saveCurrentTime(arg_4_0)
	local var_4_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.NoticePatKey)
	local var_4_1 = PlayerPrefsHelper.getString(var_4_0, "")
	local var_4_2 = ServerTime.nowInLocal() - TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	local var_4_3 = os.date("*t", var_4_2)
	local var_4_4 = var_4_3.year
	local var_4_5 = var_4_3.month
	local var_4_6 = var_4_3.day
	local var_4_7 = var_4_3.hour
	local var_4_8 = string.format("%s%s%s%s%s%s%s", var_4_4, NoticeEnum.FirstSplitChar, var_4_5, NoticeEnum.FirstSplitChar, var_4_6, NoticeEnum.FirstSplitChar, var_4_7)

	if not string.nilorempty(var_4_1) then
		var_4_8 = var_4_1 .. NoticeEnum.SecondSplitChar .. var_4_8
	end

	PlayerPrefsHelper.setString(var_4_0, var_4_8)
end

function var_0_0.onCloseViewFinish(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.NoticeView then
		arg_5_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_6_0.onCloseViewFinish, arg_6_0)
	NoticeController.instance:stopRequest()
	NoticeController.instance:stopGetConfigRequest()
end

return var_0_0
