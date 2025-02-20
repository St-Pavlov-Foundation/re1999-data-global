module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftFullView", package.seeall)

slot0 = class("VersionActivity2_3NewCultivationGiftFullView", BaseView)
slot0.REMAIN_TIME_REFRESH_INTERVAL = 10

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_bg")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Title")
	slot0._simagedec = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_dec")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/reward/#btn_reward")
	slot0._simageTitle2 = gohelper.findChildSingleImage(slot0.viewGO, "Root/reward/#simage_Title2")
	slot0._btnstone = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/stone/txt_dec/#btn_stone")
	slot0._btnget = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Btn/#btn_get")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "Root/Btn/hasget")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnstone:AddClickListener(slot0._btnstoneOnClick, slot0)
	slot0._btnget:AddClickListener(slot0._btngetOnClick, slot0)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, slot0.onEpisodeFinished, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, slot0.REMAIN_TIME_REFRESH_INTERVAL)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0._btnstone:RemoveClickListener()
	slot0._btnget:RemoveClickListener()
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, slot0.onEpisodeFinished, slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnstoneOnClick(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, {
		actId = slot0._actId,
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect
	})
end

function slot0._btnrewardOnClick(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, {
		actId = slot0._actId,
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Reward
	})
end

function slot0._btngetOnClick(slot0)
	if not Activity125Model.instance:isActivityOpen(slot0._actId) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if Activity125Model.instance:getById(slot0._actId) == nil then
		return
	end

	if slot1:getEpisodeList() == nil or #slot2 <= 0 then
		return
	end

	if slot1:isEpisodeFinished(slot2[1].id) then
		return
	end

	logNormal(string.format("_btninviteOnClick actId: %s episodeId: %s", tostring(slot0._actId), tostring(slot3)))
	Activity125Controller.instance:onFinishActEpisode(slot0._actId, slot3, Activity125Config.instance:getEpisodeConfig(slot0._actId, slot3).targetFrequency)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._actId = slot0.viewParam.actId

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if Activity125Model.instance:getById(slot0._actId) == nil then
		return
	end

	if slot1:getEpisodeList() == nil or #slot2 <= 0 then
		return
	end

	slot4 = slot1:isEpisodeFinished(slot2[1].id)

	gohelper.setActive(slot0._btnget, not slot4)
	gohelper.setActive(slot0._gohasget, slot4)
	slot0:refreshRemainTime()
end

function slot0.onEpisodeFinished(slot0)
	if Activity125Model.instance:getById(slot0._actId) == nil then
		return
	end

	if slot1:getEpisodeList() == nil or #slot2 <= 0 then
		return
	end

	logNormal(string.format("onEpisodeFinished actId: %s", tostring(slot0._actId)))
	slot0:_refreshUI()
end

function slot0.refreshRemainTime(slot0)
	if ActivityModel.instance:getActMO(slot0._actId):getRealEndTimeStamp() <= ServerTime.now() then
		slot0._txtLimitTime.text = luaLang("ended")

		return
	end

	slot0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(slot2 - slot3)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
