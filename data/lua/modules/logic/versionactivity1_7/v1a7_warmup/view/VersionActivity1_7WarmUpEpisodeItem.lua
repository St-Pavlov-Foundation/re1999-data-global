module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpEpisodeItem", package.seeall)

slot0 = class("VersionActivity1_7WarmUpEpisodeItem", UserDataDispose)

function slot0.onInit(slot0, slot1)
	slot0:__onInit()

	slot0._go = slot1
	slot0._gopic = gohelper.findChild(slot0._go, "pic")
	slot0._golocked = gohelper.findChild(slot0._go, "locked")
	slot0._gonormal = gohelper.findChild(slot0._go, "normal")
	slot0._goselect = gohelper.findChild(slot0._go, "select")
	slot0._btnselect = gohelper.findChildButtonWithAudio(slot0._go, "#btn_select")

	slot0:addClickCb(slot0._btnselect, slot0.onClickSelect, slot0)

	slot0._animator = slot0._go:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onClickSelect(slot0)
	if slot0.viewContainer:isPlayingDesc() then
		return
	end

	if not slot0.episodeCo then
		return
	end

	if not Activity125Model.instance:isEpisodeReallyOpen(slot0.activityId, slot0.episodeId) then
		return
	end

	if (Activity125Model.instance:checkIsOldEpisode(slot0.activityId, slot0.episodeId) or Activity125Model.instance:checkLocalIsPlay(slot0.activityId, slot0.episodeId) or Activity125Model.instance:isEpisodeFinished(slot0.activityId, slot0.episodeId)) and Activity125Model.instance:getSelectEpisodeId(slot0.activityId) == slot0.episodeId then
		return
	end

	Activity125Model.instance:setSelectEpisodeId(slot0.activityId, slot0.episodeId)

	if not slot3 then
		Activity125Model.instance:setOldEpisode(slot0.activityId, slot0.episodeId)
	end

	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
end

function slot0.updateData(slot0, slot1)
	slot0.episodeCo = slot1

	slot0:refreshItem()
end

function slot0.refreshItem(slot0)
	if not slot0.episodeCo then
		gohelper.setActive(slot0._go, false)

		return
	end

	gohelper.setActive(slot0._go, true)

	slot0.activityId = slot0.episodeCo.activityId
	slot0.episodeId = slot0.episodeCo.id
	slot1 = Activity125Model.instance:isEpisodeReallyOpen(slot0.activityId, slot0.episodeId)

	if slot0.episodeIsOpen == false and slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_no_effect)
	end

	slot0.episodeIsOpen = slot1

	if not slot1 then
		slot0:playAnimation("locked")

		return
	end

	if Activity125Model.instance:getSelectEpisodeId(slot0.activityId) == slot0.episodeId and (Activity125Model.instance:checkLocalIsPlay(slot0.activityId, slot0.episodeId) or Activity125Model.instance:isEpisodeFinished(slot0.activityId, slot0.episodeId) or Activity125Model.instance:checkIsOldEpisode(slot0.activityId, slot0.episodeId)) then
		slot0:playAnimation("select")
	elseif slot4 then
		slot0._animator:Play("finish", 0, 1)
	else
		slot0:playAnimation("normal")
	end
end

function slot0.playAnimation(slot0, slot1)
	slot0._animator:Play(slot1)
end

function slot0.getPos(slot0)
	return recthelper.getAnchorX(slot0._go.transform)
end

function slot0.onDestroy(slot0)
	slot0:__onDispose()
end

return slot0
