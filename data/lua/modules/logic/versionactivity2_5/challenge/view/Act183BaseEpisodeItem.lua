module("modules.logic.versionactivity2_5.challenge.view.Act183BaseEpisodeItem", package.seeall)

slot0 = class("Act183BaseEpisodeItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._golock = gohelper.findChild(slot0.go, "go_lock")
	slot0._gounlock = gohelper.findChild(slot0.go, "go_unlock")
	slot0._gofinish = gohelper.findChild(slot0.go, "go_finish")
	slot0._gocheck = gohelper.findChild(slot0.go, "go_finish/image")
	slot0._btnclick = gohelper.findChildButton(slot0.go, "btn_click")
	slot0._goselect = gohelper.findChild(slot0.go, "go_select")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.go, "image_icon")
	slot0._animfinish = gohelper.onceAddComponent(slot0._gofinish, gohelper.Type_Animator)
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnClickEpisode, slot0._onSelectEpisode, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_ClickEpisode)
	Act183Controller.instance:dispatchEvent(Act183Event.OnClickEpisode, slot0._episodeId)
end

function slot0._onSelectEpisode(slot0, slot1)
	slot0:onSelect(slot1 == slot0._episodeId)
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onUpdateMo(slot0, slot1)
	slot0._episodeMo = slot1
	slot0._status = slot1:getStatus()
	slot0._episodeId = slot1:getEpisodeId()
	slot0._isFinishedButNotNew = slot0._status == Act183Enum.EpisodeStatus.Finished and Act183Model.instance:getNewFinishEpisodeId() ~= slot0._episodeId

	gohelper.setActive(slot0._goselect, false)
	gohelper.setActive(slot0._golock, slot0._status == Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(slot0._gounlock, slot0._status ~= Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(slot0._gofinish, slot0._isFinishedButNotNew)
	Act183Helper.setEpisodeIcon(slot0._episodeId, slot0._status, slot0._simageicon)
	slot0:setVisible(true)
	slot0:setCheckIconPosition()
end

function slot0.getConfigOrder(slot0)
	slot1 = slot0._episodeMo and slot0._episodeMo:getConfig()

	return slot1 and slot1.order
end

function slot0.setVisible(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.getIconTran(slot0)
	return slot0._simageicon.transform
end

function slot0.playFinishAnim(slot0)
	gohelper.setActive(slot0._gofinish, true)
	slot0._animfinish:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished)
end

function slot0.setCheckIconPosition(slot0)
	if slot0._status ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	transformhelper.setLocalRotation(slot0._gocheck.transform, slot2 and slot2[3] or 0, slot2 and slot2[4] or 0, slot2 and slot2[5] or 0)
	recthelper.setAnchor(slot0._gocheck.transform, slot0:_getCheckIconPosAndRotConfig(slot0:getConfigOrder()) and slot2[1] or 0, slot2 and slot2[2] or 0)
end

function slot0._getCheckIconPosAndRotConfig(slot0, slot1)
	return {
		0,
		0,
		0,
		0,
		0
	}
end

function slot0.onDestroy(slot0)
end

return slot0
