module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaMainView", package.seeall)

slot0 = class("TianShiNaNaMainView", BaseView)
slot1 = 43.99266
slot2 = 3409

function slot0.onInitView(slot0)
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_task")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_title/#go_time/#txt_limittime")
	slot4 = UnityEngine.Animator
	slot0._taskAnimator = gohelper.findChild(slot0.viewGO, "#btn_task/ani"):GetComponent(typeof(slot4))
	slot0._gored = gohelper.findChild(slot0.viewGO, "#btn_task/#go_reddotreward")
	slot0._gopath = gohelper.findChild(slot0.viewGO, "#go_path")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent")
	slot0._gostages = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	slot0._gostageitem = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/#go_stages/#go_StageItem")
	slot0._pathAnims = slot0:getUserDataTb_()

	for slot4 = 1, 10 do
		slot0._pathAnims[slot4] = gohelper.findChild(slot0._goscrollcontent, "path/path/image" .. slot4):GetComponent(typeof(UnityEngine.Animator))
		slot0._pathAnims[slot4].speed = 0
	end

	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEvents(slot0)
	CommonDragHelper.instance:registerDragObj(slot0._gopath, nil, slot0._onDrag, nil, , slot0, nil, true)
	slot0._btntask:AddClickListener(slot0._onClickTask, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshTask, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EnterLevelScene, slot0._onEnterLevelScene, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeStarChange, slot0._onStarChange, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeFinish, slot0._onEpisodeFinish, slot0)
end

function slot0.removeEvents(slot0)
	CommonDragHelper.instance:unregisterDragObj(slot0._gopath)
	slot0._btntask:RemoveClickListener()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshTask, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EnterLevelScene, slot0._onEnterLevelScene, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeStarChange, slot0._onStarChange, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeFinish, slot0._onEpisodeFinish, slot0)
end

function slot0.onOpen(slot0)
	slot0:_refreshTask()
	gohelper.setActive(slot0._gostageitem, false)
	RedDotController.instance:addRedDot(slot0._gored, RedDotEnum.DotNode.V2a2TianShiNaNaTaskRed, VersionActivity2_2Enum.ActivityId.TianShiNaNa)

	slot3 = Mathf.Clamp(tonumber(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2TianShiNaNaSelect .. VersionActivity2_2Enum.ActivityId.TianShiNaNa, "1")) or 1, 1, #TianShiNaNaConfig.instance:getEpisodeCoList(VersionActivity2_2Enum.ActivityId.TianShiNaNa))

	slot0:setDragPosX(544.6 * (slot3 - 1) - recthelper.getWidth(slot0._gopath.transform) / 2 - 150)

	TianShiNaNaModel.instance.curSelectIndex = slot3
	slot0._stages = {}

	for slot7 = 1, #slot1 do
		if gohelper.findChild(slot0._gostages, "stage" .. slot7) then
			slot9 = gohelper.clone(slot0._gostageitem, slot8, "root")
			slot11 = gohelper.findChild(slot9, "#go_OddStage")

			gohelper.setActive(gohelper.findChild(slot9, "#go_EvenStage"), slot7 % 2 == 1)
			gohelper.setActive(slot11, slot7 % 2 == 0)
			gohelper.setActive(slot9, true)

			slot0._stages[slot7] = MonoHelper.addNoUpdateLuaComOnceToGo(slot7 % 2 == 0 and slot11 or slot10, TianShiNaNaStageItem)

			slot0._stages[slot7]:initCo(slot1[slot7], slot7)
		else
			logError("关卡节点不存在，请找集成处理 stage" .. slot7)
		end
	end

	slot0:refreshTime()
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, 60)

	for slot8 = 1, 10 do
		if slot8 <= TianShiNaNaModel.instance:getUnLockMaxIndex() and slot1[slot8 + 1] then
			slot0._pathAnims[slot8]:Play("idle", 0, 0)
		else
			slot0._pathAnims[slot8]:Play("open", 0, 0)
		end
	end
end

function slot0._onStarChange(slot0, slot1, slot2, slot3)
	if not slot0._stages[slot1 + 1] then
		return
	end

	if slot2 == 0 and slot0._pathAnims[slot1] then
		slot0._pathAnims[slot1]:Play("open", 0, 0)

		slot0._pathAnims[slot1].speed = 1
	end
end

function slot0._onEpisodeFinish(slot0)
	if not slot0._gopath then
		return
	end

	slot0:setDragPosX(544.6 * (Mathf.Clamp(tonumber(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2TianShiNaNaSelect .. VersionActivity2_2Enum.ActivityId.TianShiNaNa, "1")) or 1, 1, #slot0._stages) - 1) - recthelper.getWidth(slot0._gopath.transform) / 2 - 150, true)
end

function slot0._onClickTask(slot0)
	ViewMgr.instance:openView(ViewName.TianShiNaNaTaskView)
end

function slot0.refreshTime(slot0)
	slot0._txtlimittime.text = TianShiNaNaHelper.getLimitTimeStr()
end

function slot0._refreshTask(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a2TianShiNaNaTaskRed, VersionActivity2_2Enum.ActivityId.TianShiNaNa) then
		slot0._taskAnimator:Play("loop", 0, 0)
	else
		slot0._taskAnimator:Play("idle", 0, 0)
	end
end

function slot0._onViewClose(slot0, slot1)
	if slot1 == ViewName.TianShiNaNaLevelView then
		slot0._viewAnimator:Play("open", 0, 0)
	end
end

function slot0._onEnterLevelScene(slot0)
	slot0._viewAnimator:Play("close", 0, 0)
	UIBlockHelper.instance:startBlock("TianShiNaNaMainView_onEnterLevelScene", 0.34, slot0.viewName)
	TaskDispatcher.runDelay(slot0._realEnterGameView, slot0, 0.34)
end

function slot0._realEnterGameView(slot0)
	ViewMgr.instance:openView(ViewName.TianShiNaNaLevelView)
end

function slot0._onDrag(slot0, slot1, slot2)
	slot0:setDragPosX(-(recthelper.getAnchorX(slot0._goscrollcontent.transform) + slot2.delta.x))
end

function slot0.setDragPosX(slot0, slot1, slot2)
	slot3 = 0

	if 1.7777777777777777 - UnityEngine.Screen.width / UnityEngine.Screen.height < 0 then
		slot3 = Mathf.Clamp((slot6 / slot7 - 1) * recthelper.getWidth(slot0._gopath.transform) / 2, 0, 400)
	end

	if ((slot3 > uv0 - slot3 or Mathf.Clamp(slot1, slot3, uv0 - slot3)) and slot3) == slot0._nowDragPosX then
		return
	end

	slot0:killTween()

	if slot2 and slot0._nowDragPosX then
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._nowDragPosX, slot1, 0.5, slot0._onFrameTween, nil, slot0)
	else
		slot0._nowDragPosX = slot1

		transformhelper.setLocalPos(slot0._goscrollcontent.transform, -slot1, 0, 0)
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.DragMainScene, -slot1 * uv1 / uv0)
	end
end

function slot0._onFrameTween(slot0, slot1)
	slot0._nowDragPosX = slot1

	transformhelper.setLocalPos(slot0._goscrollcontent.transform, -slot1, 0, 0)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.DragMainScene, -slot1 * uv0 / uv1)
end

function slot0.killTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.onClose(slot0)
	slot0:killTween()
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
	TaskDispatcher.cancelTask(slot0._realEnterGameView, slot0)
end

return slot0
