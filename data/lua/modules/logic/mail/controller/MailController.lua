module("modules.logic.mail.controller.MailController", package.seeall)

slot0 = class("MailController", BaseController)

function slot0.open(slot0)
	ViewMgr.instance:openView(ViewName.MailView)
end

function slot0.enterMailView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.MailView)
end

function slot0.onInit(slot0)
	slot0.showTitles = {}
	slot0.maxCacheMailToast = 3
	slot0.delayShowViews = nil
	slot0.recordedMailIdKey = "recordedMailIdKey"
	slot0.recordedIdDelimiter = ";"
	slot0.showedMailIds = {}
end

function slot0.onInitFinish(slot0)
	slot0:initShowedMailIds()
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.initInfo(slot0)
	slot0.showTitles = {}

	for slot5, slot6 in ipairs(MailModel.instance:getMailList()) do
		if slot6.state == MailEnum.ReadStatus.Unread and slot6.needShowToast == 1 and not slot0:isShowedMail(slot6.id) then
			if slot0.maxCacheMailToast <= #slot0.showTitles then
				slot0:recordShowedMailId(slot6.id)
			else
				table.insert(slot0.showTitles, 1, {
					id = slot6.id,
					title = slot6.title
				})
			end
		end
	end

	slot0:logNormal("init info, show mail length is " .. tostring(#slot0.showTitles))
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, slot0._onCheckFuncUnlock, slot0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
end

function slot0.addShowToastMail(slot0, slot1, slot2)
	table.insert(slot0.showTitles, {
		id = slot1,
		title = slot2
	})

	if slot0.maxCacheMailToast < #slot0.showTitles then
		slot0:recordShowedMailId(table.remove(slot0.showTitles, 1).id)
	end
end

function slot0.initShowedMailIds(slot0)
	slot0.showedMailIds = {}

	if not string.nilorempty(PlayerPrefsHelper.getString(slot0.recordedMailIdKey, "")) then
		slot6 = slot1

		for slot5, slot6 in ipairs(string.split(slot6, slot0.recordedIdDelimiter)) do
			if tonumber(slot6) then
				table.insert(slot0.showedMailIds, slot7)
			end
		end
	end
end

function slot0.isShowedMail(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.showedMailIds) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.isDelayShow(slot0)
	if not slot0.delayShowViews then
		slot0.delayShowViews = {
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

	for slot4, slot5 in ipairs(slot0.delayShowViews) do
		if ViewMgr.instance:isOpen(slot5) then
			slot0:logNormal("current view is " .. slot5)

			return true
		end
	end

	if not GuideController.instance:isForbidGuides() then
		slot0:logNormal("not forbid guide , check guide")

		if GuideModel.instance:getDoingGuideId() then
			slot0:logNormal("get doing guide Id is " .. tostring(slot2))

			return true
		end

		if not GuideModel.instance:isGuideFinish(GuideModel.instance:lastForceGuideId()) then
			slot0:logNormal("last force guide Id not finish")

			return true
		end

		if not GuideModel.instance:isGuideFinish(GuideModel.instance:lastForceGuideId()) then
			slot0:logNormal("last force guide Id not finish")

			return true
		end
	else
		slot0:logNormal("forbid guide, skip check guide, check next")
	end

	return false
end

function slot0.showGetMailToast(slot0, slot1, slot2)
	slot0:addShowToastMail(slot1, slot2)

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		slot0:logNormal("receive new mail, but not unlock MailModel , register OnFuncUnlockRefresh event ")
		OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, slot0._onCheckFuncUnlock, slot0)
		MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, slot0._onCheckFuncUnlock, slot0)

		return
	end

	slot0:showOrRegisterEvent()
end

function slot0.tryShowMailToast(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, slot0._onCheckFuncUnlock, slot0)
	else
		slot0:showOrRegisterEvent()
	end
end

function slot0.showOrRegisterEvent(slot0)
	if slot0:isDelayShow() then
		slot0:logNormal("cat not show mail Toast, register event ...")
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	else
		slot0:logNormal("can show mail Toast ...")
		slot0:reallyShowToast()
	end
end

function slot0._onCheckFuncUnlock(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MainController.instance:unregisterCallback(MainEvent.OnFuncUnlockRefresh, slot0._onCheckFuncUnlock, slot0)
		OpenController.instance:unregisterCallback(OpenEvent.GetOpenInfoSuccess, slot0._onCheckFuncUnlock, slot0)
		slot0:logNormal("unlock mail model callback, check show mail ...")
		slot0:showOrRegisterEvent()
	end
end

function slot0._onOpenViewFinish(slot0)
	slot0:logNormal("close finish event ")

	if slot0:isDelayShow() then
		slot0:logNormal("cat not show mail Toast")

		return
	else
		slot0:logNormal("can show mail Toast")
		slot0:reallyShowToast()
	end
end

function slot0._onFinishGuide(slot0, slot1)
	slot0:logNormal("receive finish guide push ...")

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		slot0:logNormal("receive finish guide push, but mail model not open , do nothing and return ...")

		return
	end

	slot0:showOrRegisterEvent()
end

function slot0.reallyShowToast(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)

	slot6 = slot0

	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, slot0._onCheckFuncUnlock, slot6)

	slot5 = "start show ..."

	slot0:logNormal(slot5)

	for slot5, slot6 in ipairs(slot0.showTitles) do
		if MailModel.instance:getReadedMailIds()[slot6.id] then
			slot0:logNormal(string.format("need show mail {id:%s, title:%s}, but it`s been read", slot6.id, slot6.title))
			slot0:recordShowedMailId(slot6.id)
		else
			slot0:logNormal(string.format("need show mail {id:%s, title:%s}, can show", slot6.id, slot6.title))
			slot0:showToast(slot6)
		end
	end

	slot0.showTitles = {}
end

function slot0.showToast(slot0, slot1)
	GameFacade.showToast(ToastEnum.MailToast, slot1.title, slot1.id)
	slot0:recordShowedMailId(slot1.id)
end

function slot0.recordShowedMailId(slot0, slot1)
	if slot0:isShowedMail(slot1) then
		return
	end

	table.insert(slot0.showedMailIds, slot1)
	PlayerPrefsHelper.setString(slot0.recordedMailIdKey, table.concat(slot0.showedMailIds, slot0.recordedIdDelimiter))
end

function slot0.logNormal(slot0, slot1)
	logNormal("【mail toast】" .. slot1)
end

slot0.instance = slot0.New()

return slot0
