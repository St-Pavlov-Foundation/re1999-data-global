module("modules.logic.mail.controller.MailController", package.seeall)

local var_0_0 = class("MailController", BaseController)

function var_0_0.open(arg_1_0)
	ViewMgr.instance:openView(ViewName.MailView)
end

function var_0_0.enterMailView(arg_2_0, arg_2_1)
	ViewMgr.instance:openView(ViewName.MailView)
end

function var_0_0.onInit(arg_3_0)
	arg_3_0.showTitles = {}
	arg_3_0.maxCacheMailToast = 3
	arg_3_0.delayShowViews = nil
	arg_3_0.recordedMailIdKey = "recordedMailIdKey"
	arg_3_0.recordedIdDelimiter = ";"
	arg_3_0.showedMailIds = {}
end

function var_0_0.onInitFinish(arg_4_0)
	arg_4_0:initShowedMailIds()
end

function var_0_0.addConstEvents(arg_5_0)
	return
end

function var_0_0.reInit(arg_6_0)
	return
end

function var_0_0.initInfo(arg_7_0)
	arg_7_0.showTitles = {}

	local var_7_0 = MailModel.instance:getMailList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.state == MailEnum.ReadStatus.Unread and iter_7_1.needShowToast == 1 and not arg_7_0:isShowedMail(iter_7_1.id) then
			if #arg_7_0.showTitles >= arg_7_0.maxCacheMailToast then
				arg_7_0:recordShowedMailId(iter_7_1.id)
			else
				table.insert(arg_7_0.showTitles, 1, {
					id = iter_7_1.id,
					title = iter_7_1.title
				})
			end
		end
	end

	arg_7_0:logNormal("init info, show mail length is " .. tostring(#arg_7_0.showTitles))
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_7_0._onCheckFuncUnlock, arg_7_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_7_0._onFinishGuide, arg_7_0)
end

function var_0_0.addShowToastMail(arg_8_0, arg_8_1, arg_8_2)
	table.insert(arg_8_0.showTitles, {
		id = arg_8_1,
		title = arg_8_2
	})

	if #arg_8_0.showTitles > arg_8_0.maxCacheMailToast then
		local var_8_0 = table.remove(arg_8_0.showTitles, 1)

		arg_8_0:recordShowedMailId(var_8_0.id)
	end
end

function var_0_0.initShowedMailIds(arg_9_0)
	local var_9_0 = PlayerPrefsHelper.getString(arg_9_0.recordedMailIdKey, "")

	arg_9_0.showedMailIds = {}

	if not string.nilorempty(var_9_0) then
		for iter_9_0, iter_9_1 in ipairs(string.split(var_9_0, arg_9_0.recordedIdDelimiter)) do
			local var_9_1 = tonumber(iter_9_1)

			if var_9_1 then
				table.insert(arg_9_0.showedMailIds, var_9_1)
			end
		end
	end
end

function var_0_0.isShowedMail(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.showedMailIds) do
		if iter_10_1 == arg_10_1 then
			return true
		end
	end

	return false
end

function var_0_0.isDelayShow(arg_11_0)
	if not arg_11_0.delayShowViews then
		arg_11_0.delayShowViews = {
			ViewName.LoadingView,
			ViewName.FightView,
			ViewName.FightSuccView,
			ViewName.FightFailView,
			ViewName.StoryView,
			ViewName.SummonView,
			ViewName.LoginView,
			ViewName.SignInView
		}
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.delayShowViews) do
		if ViewMgr.instance:isOpen(iter_11_1) then
			arg_11_0:logNormal("current view is " .. iter_11_1)

			return true
		end
	end

	if not GuideController.instance:isForbidGuides() then
		arg_11_0:logNormal("not forbid guide , check guide")

		local var_11_0 = GuideModel.instance:getDoingGuideId()

		if var_11_0 then
			arg_11_0:logNormal("get doing guide Id is " .. tostring(var_11_0))

			return true
		end

		if not GuideModel.instance:isGuideFinish(GuideModel.instance:lastForceGuideId()) then
			arg_11_0:logNormal("last force guide Id not finish")

			return true
		end

		if not GuideModel.instance:isGuideFinish(GuideModel.instance:lastForceGuideId()) then
			arg_11_0:logNormal("last force guide Id not finish")

			return true
		end
	else
		arg_11_0:logNormal("forbid guide, skip check guide, check next")
	end

	return false
end

function var_0_0.showGetMailToast(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:addShowToastMail(arg_12_1, arg_12_2)

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		arg_12_0:logNormal("receive new mail, but not unlock MailModel , register OnFuncUnlockRefresh event ")
		OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_12_0._onCheckFuncUnlock, arg_12_0)
		MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_12_0._onCheckFuncUnlock, arg_12_0)

		return
	end

	arg_12_0:showOrRegisterEvent()
end

function var_0_0.tryShowMailToast(arg_13_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_13_0._onCheckFuncUnlock, arg_13_0)
	else
		arg_13_0:showOrRegisterEvent()
	end
end

function var_0_0.showOrRegisterEvent(arg_14_0)
	if arg_14_0:isDelayShow() then
		arg_14_0:logNormal("cat not show mail Toast, register event ...")
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_14_0._onOpenViewFinish, arg_14_0)
	else
		arg_14_0:logNormal("can show mail Toast ...")
		arg_14_0:reallyShowToast()
	end
end

function var_0_0._onCheckFuncUnlock(arg_15_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MainController.instance:unregisterCallback(MainEvent.OnFuncUnlockRefresh, arg_15_0._onCheckFuncUnlock, arg_15_0)
		OpenController.instance:unregisterCallback(OpenEvent.GetOpenInfoSuccess, arg_15_0._onCheckFuncUnlock, arg_15_0)
		arg_15_0:logNormal("unlock mail model callback, check show mail ...")
		arg_15_0:showOrRegisterEvent()
	end
end

function var_0_0._onOpenViewFinish(arg_16_0)
	arg_16_0:logNormal("close finish event ")

	if arg_16_0:isDelayShow() then
		arg_16_0:logNormal("cat not show mail Toast")

		return
	else
		arg_16_0:logNormal("can show mail Toast")
		arg_16_0:reallyShowToast()
	end
end

function var_0_0._onFinishGuide(arg_17_0, arg_17_1)
	arg_17_0:logNormal("receive finish guide push ...")

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		arg_17_0:logNormal("receive finish guide push, but mail model not open , do nothing and return ...")

		return
	end

	arg_17_0:showOrRegisterEvent()
end

function var_0_0.reallyShowToast(arg_18_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_18_0._onOpenViewFinish, arg_18_0)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_18_0._onCheckFuncUnlock, arg_18_0)

	local var_18_0 = MailModel.instance:getReadedMailIds()

	arg_18_0:logNormal("start show ...")

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.showTitles) do
		if var_18_0[iter_18_1.id] then
			arg_18_0:logNormal(string.format("need show mail {id:%s, title:%s}, but it`s been read", iter_18_1.id, iter_18_1.title))
			arg_18_0:recordShowedMailId(iter_18_1.id)
		else
			arg_18_0:logNormal(string.format("need show mail {id:%s, title:%s}, can show", iter_18_1.id, iter_18_1.title))
			arg_18_0:showToast(iter_18_1)
		end
	end

	arg_18_0.showTitles = {}
end

function var_0_0.showToast(arg_19_0, arg_19_1)
	GameFacade.showToast(ToastEnum.MailToast, arg_19_1.title, arg_19_1.id)
	arg_19_0:recordShowedMailId(arg_19_1.id)
end

function var_0_0.recordShowedMailId(arg_20_0, arg_20_1)
	if arg_20_0:isShowedMail(arg_20_1) then
		return
	end

	table.insert(arg_20_0.showedMailIds, arg_20_1)
	PlayerPrefsHelper.setString(arg_20_0.recordedMailIdKey, table.concat(arg_20_0.showedMailIds, arg_20_0.recordedIdDelimiter))
end

function var_0_0.logNormal(arg_21_0, arg_21_1)
	logNormal("【mail toast】" .. arg_21_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
