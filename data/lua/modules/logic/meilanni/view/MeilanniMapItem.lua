module("modules.logic.meilanni.view.MeilanniMapItem", package.seeall)

slot0 = class("MeilanniMapItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_click")
	slot0._btnstory = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_finish/btn_story")
	slot0._golock = gohelper.findChild(slot0.viewGO, "go_lock")
	slot0._godoing = gohelper.findChild(slot0.viewGO, "go_doing")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "go_finish")
	slot0._imagegrade = gohelper.findChildImage(slot0.viewGO, "image_grade")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnstory:AddClickListener(slot0._btnstoryOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnstory:RemoveClickListener()
end

function slot0._btnstoryOnClick(slot0)
	uv0.playStoryList(slot0._mapIndex)
end

function slot0.playStoryList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_activity108_story.configList) do
		if slot6.bind == slot0 then
			table.insert(slot1, slot6.story)
		end
	end

	if not slot1 or #slot1 < 1 then
		return
	end

	StoryController.instance:playStories(slot1)
end

function slot0._btnclickOnClick(slot0)
	if slot0._lockStatus then
		slot0:_showLockToast(slot0._mapConfig)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	uv0.gotoMap(slot0._mapId)
end

function slot0.gotoMap(slot0)
	if not MeilanniModel.instance:getMapInfo(slot0) or slot1:checkFinish() then
		MeilanniController.instance:openMeilanniEntrustView({
			mapId = slot0
		})

		return
	end

	MeilanniController.instance:openMeilanniView({
		mapId = slot0
	})
end

function slot0.ctor(slot0, slot1)
	slot0._mapConfig = slot1
	slot0._mapId = slot0._mapConfig.id
	slot0._mapIndex = slot0._mapId - 100
end

function slot0._editableInitView(slot0)
end

function slot0.updateLockStatus(slot0)
	if slot0._needPlayUnlockAnim then
		return
	end

	gohelper.setActive(slot0._godoing, false)
	gohelper.setActive(slot0._gofinish, false)

	slot1 = slot0._lockStatus
	slot0._lockStatus = uv0.isLock(slot0._mapConfig)

	gohelper.setActive(slot0._golock, slot0._lockStatus)
	gohelper.setActive(slot0._imagegrade.gameObject, false)

	if slot0._lockStatus then
		return
	end

	if MeilanniModel.instance:getMapInfo(slot0._mapId) and slot2.highestScore > 0 then
		gohelper.setActive(slot0._imagegrade.gameObject, true)
		UISpriteSetMgr.instance:setMeilanniSprite(slot0._imagegrade, "bg_pingfen_xiao_" .. tostring(MeilanniConfig.instance:getScoreIndex(slot2.highestScore)))
		gohelper.setActive(slot0._gofinish, true)
		gohelper.setActive(slot0._godoing, false)
	else
		gohelper.setActive(slot0._gofinish, false)
		gohelper.setActive(slot0._godoing, true)
	end

	if slot1 then
		slot0._needPlayUnlockAnim = true
	end

	if slot0._needPlayUnlockAnim then
		gohelper.setActive(slot0._golock, true)
		TaskDispatcher.runDelay(slot0._playUnlockAnim, slot0, 0.5)
	end
end

function slot0._playUnlockAnim(slot0)
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	slot0._animatorPlayer:Play("unlock", slot0._unlockDone, slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)
end

function slot0._unlockDone(slot0)
	slot0._needPlayUnlockAnim = nil

	gohelper.setActive(slot0._golock, false)
end

function slot0.isLock(slot0)
	if slot0.preId <= 0 then
		return false
	end

	if MeilanniModel.instance:getMapInfo(slot0.id) then
		return false
	end

	if slot0.onlineDay > 0 and ActivityModel.instance:getActMO(MeilanniEnum.activityId):getRealStartTimeStamp() + (slot0.onlineDay - 1) * 86400 - ServerTime.now() > 0 then
		return true
	end

	return not MeilanniModel.instance:getMapInfo(slot0.preId) or slot2.highestScore <= 0
end

function slot0._showLockToast(slot0, slot1)
	if slot1.onlineDay > 0 then
		if ActivityModel.instance:getActMO(MeilanniEnum.activityId):getRealStartTimeStamp() + (slot1.onlineDay - 1) * 86400 - ServerTime.now() > 86400 then
			GameFacade.showToast(ToastEnum.MeilanniEntranceLock2, math.ceil(slot4 / 86400))

			return
		elseif slot4 > 3600 then
			GameFacade.showToast(ToastEnum.MeilanniEntranceLock3, math.ceil(slot4 / 3600))

			return
		elseif slot4 > 0 then
			GameFacade.showToast(ToastEnum.MeilanniEntranceLock4)

			return
		end
	end

	if slot1.preId <= 0 then
		return
	end

	if not MeilanniModel.instance:getMapInfo(slot1.preId) or slot2.highestScore <= 0 then
		GameFacade.showToast(ToastEnum.MeilanniEntranceLock5)
	end
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._playUnlockAnim, slot0)
end

return slot0
