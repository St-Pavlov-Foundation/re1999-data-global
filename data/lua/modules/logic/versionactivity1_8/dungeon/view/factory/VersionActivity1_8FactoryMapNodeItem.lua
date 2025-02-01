module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryMapNodeItem", package.seeall)

slot0 = class("VersionActivity1_8FactoryMapNodeItem", UserDataDispose)
slot1 = 0.8
slot2 = 0.5

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()

	slot0.actId = Activity157Model.instance:getActId()
	slot0.go = slot1
	slot0.getLineTemplateFunc = slot2
	slot0.lineParentGo = slot3
	slot0.trans = slot0.go.transform
	slot0._animator = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._goLineParentInNode = gohelper.findChild(slot0.go, "line")
	slot0._gonum = gohelper.findChild(slot0.go, "num")
	slot0._txtnum = gohelper.findChildText(slot0.go, "num/#txt_num")
	slot0._gotimetips = gohelper.findChild(slot0.go, "timetips")
	slot0._txttime = gohelper.findChildText(slot0.go, "timetips/#txt_time")
	slot0._imagestatus = gohelper.findChildImage(slot0.go, "#image_status")
	slot0._godispatchrewardeff = gohelper.findChild(slot0.go, "#image_status/#vx_reward")
	slot0._gounlockeff = gohelper.findChild(slot0.go, "#image_status/#vx_unlock")
	slot0._goReddot = gohelper.findChild(slot0.go, "#go_reddot")
	slot0._btnnode = gohelper.findChildClickWithDefaultAudio(slot0.go, "#btn_node")
	slot0.parentView = slot4

	slot0:addEventListeners()
end

function slot0.addEventListeners(slot0)
	slot0.statusClickHandler = {
		[Activity157Enum.MissionStatus.Normal] = slot0._clickNormal,
		[Activity157Enum.MissionStatus.Locked] = slot0._clickLocked,
		[Activity157Enum.MissionStatus.Dispatching] = slot0._clickDispatch,
		[Activity157Enum.MissionStatus.DispatchFinish] = slot0._clickDispatch,
		[Activity157Enum.MissionStatus.Finish] = slot0._clickFinish
	}

	slot0._btnnode:AddClickListener(slot0._btnnodeOnClick, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.OnDispatchFinish, slot0.onDispatchFinish, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnnode:RemoveClickListener()
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.OnDispatchFinish, slot0.onDispatchFinish, slot0)
end

function slot0._btnnodeOnClick(slot0)
	if not Activity157Config.instance:getMissionElementId(slot0.actId, slot0.missionId) then
		return
	end

	if slot0.statusClickHandler[Activity157Model.instance:getMissionStatus(slot0.missionGroupId, slot0.missionId)] then
		slot3(slot0, slot1)
	else
		logError(string.format("VersionActivity1_8FactoryMapNodeItem:_btnnodeOnClick, no status handler, status:%s", slot2))
	end
end

function slot0._clickNormal(slot0, slot1)
	if Activity157Model.instance:isInProgressOtherMissionGroup(slot0.missionGroupId) then
		GameFacade.showToast(ToastEnum.V1a8Activity157HasDoingOtherMissionGroup)

		return
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.FocusElement, slot1)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)
end

function slot0._clickLocked(slot0, slot1)
	if Activity157Model.instance:getMissionUnlockToastId(slot0.missionId, slot1) then
		GameFacade.showToast(slot2)
	end
end

function slot0._clickDispatch(slot0, slot1)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.ManualClickElement, slot1)
end

function slot0._clickFinish(slot0)
	slot2 = Activity157Config.instance:getMissionElementId(slot0.actId, slot0.missionId) and DungeonConfig.instance:getChapterMapElement(slot1)

	if (slot2 and slot2.type) == DungeonEnum.ElementType.None or slot3 == DungeonEnum.ElementType.Story then
		if Activity157Config.instance:getAct157MissionStoryId(slot0.actId, slot0.missionId) and slot4 ~= 0 then
			StoryController.instance:playStory(slot4, nil, function ()
				uv0:openFragmentInfoView(uv1)
			end)
		else
			slot0:openFragmentInfoView(slot2)
		end
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157MissionHasFinished)
	end
end

function slot0.openFragmentInfoView(slot0, slot1)
	slot2 = slot1.fragment

	ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
		isFromHandbook = true,
		fragmentId = slot2,
		dialogIdList = HandbookModel.instance:getFragmentDialogIdList(slot2)
	})
end

function slot0.onDispatchFinish(slot0)
	if not DungeonConfig.instance:isDispatchElement(Activity157Config.instance:getMissionElementId(slot0.actId, slot0.missionId)) then
		return
	end

	slot0:refreshStatus()
end

function slot0.setMissionData(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 then
		return
	end

	slot0.missionId = slot2
	slot0.missionGroupId = slot1
	slot4 = Activity157Config.instance:getAct157MissionPos(slot0.actId, slot0.missionId)

	recthelper.setAnchor(slot0.trans, slot4[1], slot4[2])

	slot0.go.name = string.format("%s-%s", slot0.missionGroupId, slot0.missionId)

	if Activity157Config.instance:getAct157MissionOrder(slot0.actId, slot0.missionId) then
		slot0._txtnum.text = slot5

		gohelper.setActive(slot0._gonum, true)
	else
		gohelper.setActive(slot0._gonum, false)
	end

	slot0:createLine()
	slot0:refresh()

	slot6 = nil
	slot8 = Activity157Config.instance:getMissionElementId(slot0.actId, slot0.missionId) and DungeonConfig.instance:getChapterMapElement(slot7)

	if (slot8 and slot8.type) == DungeonEnum.ElementType.Dispatch then
		slot6 = tonumber(slot8.param)
	end

	RedDotController.instance:addRedDot(slot0._goReddot, RedDotEnum.DotNode.V1a8FactoryMapDispatchFinish, slot6, slot0.checkDispatchReddot, slot0)
	gohelper.setActive(slot0.go, true)

	if Activity157Model.instance:getIsNeedPlayMissionUnlockAnim(slot0.missionId) then
		slot0:playNodeAnimation("open", "go")

		if slot0._lineAnimator then
			slot0._lineAnimator.speed = 0
		end

		slot0._animator.speed = 0
		slot11 = 0

		if slot3 then
			slot11 = uv0
		elseif not Activity157Config.instance:isRootMission(slot0.actId, slot2) then
			slot11 = uv1
		end

		TaskDispatcher.cancelTask(slot0.playNodeUnlockAnimation, slot0)
		TaskDispatcher.runDelay(slot0.playNodeUnlockAnimation, slot0, slot11)
	else
		slot0:playNodeAnimation("open", "open", "unlock")
	end
end

function slot0.refreshUnlockAnim(slot0)
	slot0:refresh()

	if not Activity157Model.instance:getIsNeedPlayMissionUnlockAnim(slot0.missionId) then
		return
	end

	slot0:playNodeUnlockAnimation()
end

function slot0.checkDispatchReddot(slot0, slot1)
	slot1:defaultRefreshDot()
	gohelper.setActive(slot0._godispatchrewardeff, slot1.show)
end

function slot0.createLine(slot0)
	slot0:destroyLine()

	slot1 = nil

	if slot0.getLineTemplateFunc then
		slot1 = slot0.getLineTemplateFunc(slot0.parentView, Activity157Config.instance:getLineResPath(slot0.actId, slot0.missionId))
	end

	if not slot1 then
		return
	end

	slot0.lineGo = gohelper.clone(slot1, slot0.lineParentGo or slot0._goLineParentInNode)

	if gohelper.isNil(slot0.lineGo) then
		return
	end

	slot0._lineAnimator = gohelper.findChildComponent(slot0.lineGo, "ani", typeof(UnityEngine.Animator))
	slot0._goLineFinish = gohelper.findChild(slot0.lineGo, "ani/line_finish")
	slot0._goLineUnlock = gohelper.findChild(slot0.lineGo, "ani/line_unlock")
	slot0._goLineLock = gohelper.findChild(slot0.lineGo, "ani/line_lock")
	slot0._lineImagePoint1 = gohelper.findChildImage(slot0.lineGo, "ani/point1")
	slot0._lineImagePoint2 = gohelper.findChildImage(slot0.lineGo, "ani/point2")
	slot2, slot3 = recthelper.getAnchor(slot0._lineImagePoint2.transform, 0, 0)

	if slot0.lineParentGo then
		slot6 = Activity157Config.instance:getAct157MissionPos(slot0.actId, slot0.missionId)

		recthelper.setAnchor(slot0.lineGo.transform, slot6[1] - slot2, slot6[2] - slot3 + (tonumber(Activity157Config.instance:getAct157Const(slot0.actId, Activity157Enum.ConstId.FactoryMapNodeLineOffsetY)) or 0))
	else
		recthelper.setAnchor(slot0.lineGo.transform, -slot2, -slot3 + slot5)
	end

	gohelper.setActive(slot0.lineGo, true)
end

function slot0.playNodeAnimation(slot0, slot1, slot2, slot3)
	if not string.nilorempty(slot1) and slot0._animator then
		slot0._animator:Play(slot1, 0, 0)
	end

	if not string.nilorempty(slot2) and slot0._lineAnimator then
		slot0._lineAnimator:Play(slot2, 0, 0)
	end

	slot0.parentView:playAreaAnim(Activity157Config.instance:getMissionArea(slot0.actId, slot0.missionId), slot3)
end

function slot0.playNodeUnlockAnimation(slot0)
	slot0:playNodeAnimation("open", "go", "unlock")

	if slot0._lineAnimator then
		slot0._lineAnimator.speed = 1

		AudioMgr.instance:trigger(AudioEnum.UI.Act157FactoryNodeLineShow)
	end

	slot0._animator.speed = 1

	gohelper.setActive(slot0._gounlockeff, false)
	gohelper.setActive(slot0._gounlockeff, true)

	if slot0.missionId then
		Activity157Model.instance:setHasPlayedAnim(VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedMissionNodeUnlocked .. slot0.missionId)
		Activity157Controller.instance:dispatchEvent(Activity157Event.Act157PlayMissionUnlockAnim)
	end
end

function slot0.everySecondCall(slot0)
	slot0:refreshTime()
end

function slot0.refresh(slot0)
	slot0:refreshStatus()
	slot0:refreshTime()
	slot0:refreshLine()
end

function slot0.refreshStatus(slot0)
	slot1 = nil

	if type(Activity157Enum.MissionStatusShowSetting[Activity157Model.instance:getMissionStatus(slot0.missionGroupId, slot0.missionId)]) == "table" then
		slot5 = Activity157Config.instance:getMissionElementId(slot0.actId, slot0.missionId) and DungeonConfig.instance:getChapterMapElement(slot4)
		slot6 = slot5 and slot5.type

		if slot2 == Activity157Enum.MissionStatus.Finish then
			slot1 = slot3.normal

			if slot6 == DungeonEnum.ElementType.None or slot6 == DungeonEnum.ElementType.Story then
				slot1 = slot3.story
			end
		elseif slot2 == Activity157Enum.MissionStatus.Normal then
			slot1 = slot3.normal

			if slot6 == DungeonEnum.ElementType.Fight then
				slot1 = slot3.fight
			end
		else
			logError("VersionActivity1_8FactoryMapNodeItem:refreshStatus error, no status icon, status:%s", slot2)
		end
	else
		slot1 = slot3
	end

	if slot1 then
		UISpriteSetMgr.instance:setV1a8FactorySprite(slot0._imagestatus, slot1)
	end

	gohelper.setActive(slot0._gotimetips, slot2 == Activity157Enum.MissionStatus.Dispatching)
end

function slot0.refreshTime(slot0)
	if not (Activity157Model.instance:getMissionStatus(slot0.missionGroupId, slot0.missionId) == Activity157Enum.MissionStatus.Dispatching) then
		return
	end

	slot0._txttime.text = DispatchModel.instance:getDispatchTime(Activity157Config.instance:getMissionElementId(slot0.actId, slot0.missionId))
end

function slot0.refreshLine(slot0)
	if not slot0.missionGroupId or not slot0.missionId then
		return
	end

	gohelper.setActive(slot0._goLineLock, Activity157Model.instance:getMissionStatus(slot0.missionGroupId, slot0.missionId) == Activity157Enum.MissionStatus.Locked)

	if slot1 == Activity157Enum.MissionStatus.Normal or slot1 == Activity157Enum.MissionStatus.Dispatching or slot1 == Activity157Enum.MissionStatus.DispatchFinish then
		gohelper.setActive(slot0._goLineUnlock, true)
	else
		gohelper.setActive(slot0._goLineUnlock, false)
	end

	gohelper.setActive(slot0._goLineFinish, slot1 == Activity157Enum.MissionStatus.Finish)

	if not Activity157Enum.MissionLineStatusIcon[slot1] then
		return
	end

	if slot0._lineImagePoint1 then
		UISpriteSetMgr.instance:setV1a8FactorySprite(slot0._lineImagePoint1, slot2.point, true)
	end

	if slot0._lineImagePoint2 then
		UISpriteSetMgr.instance:setV1a8FactorySprite(slot0._lineImagePoint2, slot2.point, true)
	end
end

function slot0.reset(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.playNodeUnlockAnimation, slot0)

	if slot1 then
		slot0:playNodeAnimation("close", "close", "lock")
	end

	slot0.missionId = nil
	slot0.missionGroupId = nil
	slot0.go.name = "nodeitem"
	slot0._animator.speed = 1

	gohelper.setActive(slot0.go, false)
	slot0:destroyLine()
end

function slot0.destroyLine(slot0)
	slot0._lineAnimator = nil
	slot0._lineImagePoint1 = nil
	slot0._lineImagePoint2 = nil

	if not gohelper.isNil(slot0.lineGo) then
		gohelper.destroy(slot0.lineGo)
	end

	slot0.lineGo = nil

	gohelper.setActive(slot0._gounlockeff, false)
end

function slot0.destroy(slot0)
	slot0:removeEventListeners()
	slot0:reset()
	gohelper.destroy(slot0.go)
	slot0:__onDispose()
end

return slot0
