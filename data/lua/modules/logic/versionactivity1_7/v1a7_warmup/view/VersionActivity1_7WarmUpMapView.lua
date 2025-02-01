module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpMapView", package.seeall)

slot0 = class("VersionActivity1_7WarmUpMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._gomap = gohelper.findChild(slot0.viewGO, "#go_map")
	slot0._gomapcontent = gohelper.findChild(slot0.viewGO, "#go_map/Viewport/Content")
	slot0._gomaproot = slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes.mapRes, slot0._gomapcontent, "mapRoot")
	slot0.lineAnimator = gohelper.findChildComponent(slot0._gomaproot, "Line", typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity125Controller.instance, Activity125Event.EpisodeUnlock, slot0.unlockLine, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity125Controller.instance, Activity125Event.EpisodeUnlock, slot0.unlockLine, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0._actId = ActivityEnum.Activity.Activity1_7WarmUp

	if Activity125Model.instance:getById(slot0._actId) then
		slot0:refreshUI()
	end
end

function slot0.refreshUI(slot0)
	TaskDispatcher.cancelTask(slot0.unlockLineCallback, slot0)
	slot0:initItemList()
	slot0:updateEpisodes()
	slot0:updateMapPos(slot0.notFirst)
end

function slot0.unlockLine(slot0, slot1)
	slot2 = Activity125Model.instance:getLastEpisode(slot0._actId)

	if slot2 == 1 and not Activity125Model.instance:checkLocalIsPlay(slot0._actId, slot2) then
		gohelper.setActive(slot0.lineAnimator, false)

		return
	end

	gohelper.setActive(slot0.lineAnimator, true)

	if slot1 then
		slot0.lineAnimator:Play(string.format("go%s", slot2 - 1), 0, 1)
	else
		slot0.unlockEpisode = slot2

		slot0.lineAnimator:Play(string.format("go%s", slot2 - 1))
		TaskDispatcher.runDelay(slot0.unlockLineCallback, slot0, 0.84)
	end
end

function slot0.unlockLineCallback(slot0)
	slot0.unlockEpisode = nil

	if slot0.itemList[slot0.unlockEpisode] then
		slot2:refreshItem()
	end
end

function slot0.updateMapPos(slot0, slot1)
	if slot0._movetweenId then
		ZProj.TweenHelper.KillById(slot0._movetweenId)

		slot0._movetweenId = nil
	end

	slot2 = math.max(recthelper.getWidth(slot0._gomapcontent.transform) - recthelper.getWidth(slot0._gomap.transform), 0)

	if slot0.selectId == Activity125Model.instance:getSelectEpisodeId(slot0._actId) then
		return
	end

	slot0.selectId = slot3
	slot5 = -math.min(slot0:getItemPos(slot3), slot2)

	if slot1 then
		if math.abs(slot5 - recthelper.getAnchorX(slot0._gomapcontent.transform)) > 1 then
			slot0._movetweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._gomapcontent.transform, slot5, slot7 / 1000)
		end
	else
		recthelper.setAnchorX(slot0._gomapcontent.transform, slot5)
	end

	slot0.notFirst = true
end

function slot0.getItemPos(slot0, slot1)
	if not slot0.itemList[slot1] then
		return 0
	end

	return math.max(recthelper.getWidth(slot0._gomapcontent.transform) * 0.5 + slot2:getPos() - (recthelper.getWidth(slot0._gomap.transform) * 0.5 - 200), 0)
end

function slot0.initItemList(slot0)
	if slot0.itemList then
		return
	end

	slot0.itemList = slot0:getUserDataTb_()

	for slot5 = 1, Activity125Model.instance:getEpisodeCount(slot0._actId) do
		slot0.itemList[slot5] = slot0:createEpisodeItem(gohelper.findChild(slot0._gomaproot, string.format("mapitem%s", slot5)))
	end
end

function slot0.createEpisodeItem(slot0, slot1)
	slot2 = VersionActivity1_7WarmUpEpisodeItem.New()
	slot2.viewContainer = slot0.viewContainer

	slot2:onInit(slot1)

	return slot2
end

function slot0.updateEpisodes(slot0)
	if Activity125Model.instance:getEpisodeList(slot0._actId) then
		for slot5, slot6 in ipairs(slot1) do
			if slot0.itemList[slot5] then
				slot7:updateData(slot6)
			end
		end
	end

	if not slot0.unlockEpisode then
		slot0:unlockLine(true)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.unlockLineCallback, slot0)

	if slot0.itemList then
		for slot4, slot5 in ipairs(slot0.itemList) do
			slot5:onDestroy()
		end
	end

	if slot0._movetweenId then
		ZProj.TweenHelper.KillById(slot0._movetweenId)

		slot0._movetweenId = nil
	end
end

return slot0
