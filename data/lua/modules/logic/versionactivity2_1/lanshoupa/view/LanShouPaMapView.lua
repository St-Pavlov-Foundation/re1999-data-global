module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapView", package.seeall)

slot0 = class("LanShouPaMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._gopath = gohelper.findChild(slot0.viewGO, "#go_path")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent")
	slot0._gostages = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "#go_title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_title/#go_time/#txt_limittime")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_task", AudioEnum.UI.play_ui_mission_open)
	slot0._gored = gohelper.findChild(slot0.viewGO, "#btn_task/#go_reddotreward")
	slot0._gotaskani = gohelper.findChild(slot0.viewGO, "#btn_task/ani")
	slot0._goreddotreward = gohelper.findChild(slot0.viewGO, "#btn_task/#go_reddotreward")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._goblack = gohelper.findChild(slot0.viewGO, "black")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")
	slot0._animPath = gohelper.findChild(slot0._goscrollcontent, "path/path_2"):GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
end

function slot0._btntaskOnClick(slot0)
	LanShouPaController.instance:openTaskView()
end

function slot0._editableInitView(slot0)
	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._pathAnimator = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/path/path_2"):GetComponent(typeof(UnityEngine.Animator))
	slot0._excessAnimator = slot0._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	slot0._blackAnimator = slot0._goblack:GetComponent(typeof(UnityEngine.Animator))
	slot0._taskAnimator = slot0._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(slot0._gored, RedDotEnum.DotNode.V2a1LanShouPaTaskRed, VersionActivity2_1Enum.ActivityId.LanShouPa)
end

function slot0.onOpen(slot0)
	slot0:_initStages()
	slot0:refreshTime()
	slot0:_refreshTask()
	slot0:_addEvents()
end

function slot0._initStages(slot0)
	if slot0._stageItemList then
		return
	end

	slot0._stageItemList = {}
	slot3 = VersionActivity2_1Enum.ActivityId.LanShouPa
	slot4 = Activity164Config.instance:getEpisodeCoList(slot3)

	Activity164Model.instance:setCurEpisodeId(slot4[Mathf.Clamp(tonumber(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_1LanShouPaSelect .. slot3, "1")) or 1, 1, Activity164Model.instance:getUnlockCount() + 1)] and slot4[slot5].id or slot4[1].id)

	for slot10 = 1, #slot4 do
		slot13 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._gostages, "stage" .. slot10)), LanShouPaMapViewStageItem, slot0)

		slot13:refreshItem(slot4[slot10], slot10)
		table.insert(slot0._stageItemList, slot13)
	end

	if slot2 == 0 then
		slot0._animPath.speed = 0

		slot0._animPath:Play("go1", 0, 0)
	else
		slot0._animPath.speed = 1

		slot0._animPath:Play("go" .. slot2, 0, 1)
	end

	slot0:_setToPos(slot5)
end

function slot0._refreshStageItem(slot0, slot1, slot2)
	for slot6 = 1, #slot0._stageItemList do
		slot0._stageItemList[slot6]:refreshItem(Activity164Config.instance:getActivity164EpisodeCo(VersionActivity2_1Enum.ActivityId.LanShouPa, slot6), slot6)
	end
end

function slot0.refreshTime(slot0)
	if not ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.LanShouPa] then
		return
	end

	slot0._txtlimittime.text = TimeUtil.SecondToActivityTimeFormat(slot1:getRealEndTimeStamp() - ServerTime.now())
end

function slot0._refreshTask(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a1LanShouPaTaskRed, VersionActivity2_1Enum.ActivityId.LanShouPa) then
		slot0._taskAnimator:Play("loop", 0, 0)
	else
		slot0._taskAnimator:Play("idle", 0, 0)
	end
end

function slot0._onEpisodeFinish(slot0)
	slot1 = Activity164Model.instance:getUnlockCount()
	slot0._animPath.speed = 1

	slot0._animPath:Play("go" .. slot1, 0, 0)
	slot0._stageItemList[slot1]:onPlayFinish()

	if slot0._stageItemList[slot1 + 1] then
		slot0._stageItemList[slot1 + 1]:onPlayUnlock()
	end

	slot0:_setToPos(slot1)
end

function slot0.getRemainTimeStr(slot0)
	if ActivityModel.instance:getActMO(VersionActivity2_1Enum.ActivityId.LanShouPa) then
		return string.format(luaLang("activity_warmup_remain_time"), slot1:getRemainTimeStr())
	end

	return string.format(luaLang("activity_warmup_remain_time"), "0")
end

function slot0.onClose(slot0)
	slot0:_removeEvents()
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._initDragPos = slot2.position.x
end

function slot0._onDrag(slot0, slot1, slot2)
	slot0:setDragPosX(-(recthelper.getAnchorX(slot0._goscrollcontent.transform) + slot2.delta.x * LanShouPaEnum.SlideSpeed))
end

function slot0._onDragEnd(slot0, slot1, slot2)
end

function slot0._getInfoSuccess(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	LanShouPaController.instance:dispatchEvent(LanShouPaEvent.NewEpisodeUnlock)
	slot0:_backToLevelView()
end

function slot0._setToPos(slot0, slot1)
	slot0:setDragPosX((slot1 - LanShouPaEnum.MaxShowEpisodeCount) * LanShouPaEnum.MaxSlideX / (#Activity164Config.instance:getEpisodeCoList(VersionActivity2_1Enum.ActivityId.LanShouPa) - LanShouPaEnum.MaxShowEpisodeCount))
end

function slot0._onScreenResize(slot0)
	slot0:setDragPosX(-recthelper.getAnchorX(slot0._goscrollcontent.transform))
end

function slot0.setDragPosX(slot0, slot1)
	slot2 = 0

	if 1.7777777777777777 - UnityEngine.Screen.width / UnityEngine.Screen.height < 0 then
		slot2 = Mathf.Clamp((slot5 / slot6 - 1) * recthelper.getWidth(slot0._gopath.transform) / 2, 0, 400)
	end

	slot1 = (slot2 > LanShouPaEnum.MaxSlideX - slot2 or Mathf.Clamp(slot1, slot2, LanShouPaEnum.MaxSlideX - slot2)) and slot2

	transformhelper.setLocalPos(slot0._goscrollcontent.transform, -slot1, 0, 0)
	LanShouPaController.instance:dispatchEvent(LanShouPaEvent.SetScenePos, -slot1 * LanShouPaEnum.SceneMaxX / LanShouPaEnum.MaxSlideX)
end

function slot0._onEnterGameView(slot0)
	slot0._viewAnimator:Play("close", 0, 0)
end

function slot0._realEnterGameView(slot0)
	slot0:closeThis()
end

function slot0._onViewClose(slot0, slot1)
	if slot1 == ViewName.LanShouPaGameView then
		slot0._viewAnimator:Play("open", 0, 0)
	end
end

function slot0._addEvents(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gopath.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0:addEventCb(LanShouPaController.instance, LanShouPaEvent.StartEnterGameView, slot0._onEnterGameView, slot0)
	slot0:addEventCb(LanShouPaController.instance, LanShouPaEvent.OnEpisodeFinish, slot0._onEpisodeFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshTask, slot0)
end

function slot0._removeEvents(slot0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
	slot0:removeEventCb(LanShouPaController.instance, LanShouPaEvent.StartEnterGameView, slot0._onEnterGameView, slot0)
	slot0:removeEventCb(LanShouPaController.instance, LanShouPaEvent.OnEpisodeFinish, slot0._onEpisodeFinish, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshTask, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._showUnlockFinished, slot0)

	if slot0._stageItemList then
		for slot4, slot5 in ipairs(slot0._stageItemList) do
			slot5:onDestroyView()
		end

		slot0._stageItemList = nil
	end
end

return slot0
