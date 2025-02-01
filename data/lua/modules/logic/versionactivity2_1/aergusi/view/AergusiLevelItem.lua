module("modules.logic.versionactivity2_1.aergusi.view.AergusiLevelItem", package.seeall)

slot0 = class("AergusiLevelItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._gounlock = gohelper.findChild(slot0.go, "Root/unlock")
	slot0._imagehasstar = gohelper.findChildImage(slot0.go, "Root/unlock/Info/#image_HasStar")
	slot0._imagenostar = gohelper.findChildImage(slot0.go, "Root/unlock/Info/#image_NoStar")
	slot0._txtstagename = gohelper.findChildText(slot0.go, "Root/unlock/Info/#txt_StageName")
	slot0._txtstagenum = gohelper.findChildText(slot0.go, "Root/unlock/Info/#txt_StageNum")
	slot0._imageinfo = gohelper.findChildImage(slot0.go, "Root/#image_Info")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "Root/unlock/#btn_Click")
	slot0._golocked = gohelper.findChild(slot0.go, "Root/#go_Locked")
	slot0._imageItemMask = gohelper.findChildImage(slot0.go, "Root/#go_Locked/image_ItemMask")

	gohelper.setActive(slot0._gounlock, true)
	gohelper.setActive(slot0._golocked, true)

	slot0._itemAni = slot0.go:GetComponent(typeof(UnityEngine.Animator))

	slot0:addEventListeners()
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot0._index = slot2
	slot0._episodeMo = slot1
	slot0._config = AergusiConfig.instance:getEpisodeConfig(nil, slot1.episodeId)
	slot0._episodeId = slot0._config.episodeId

	if AergusiModel.instance:isEpisodeUnlock(slot0._episodeId) then
		slot0._imageItemMask.raycastTarget = false

		if AergusiModel.instance:getNewUnlockEpisode() == slot0._episodeId then
			slot0._itemAni:Play("idlegray", 0, 0)
		else
			slot0._itemAni:Play("idle", 0, 0)
		end
	else
		slot0._itemAni:Play("idlegray", 0, 0)
	end

	slot4 = AergusiModel.instance:isEpisodePassed(slot0._episodeId)

	gohelper.setActive(slot0._imagenostar.gameObject, not slot4)
	gohelper.setActive(slot0._imagehasstar.gameObject, slot4)
	gohelper.setActive(slot0._imageinfo.gameObject, not AergusiModel.instance:isStoryEpisode(slot0._episodeId))

	slot0._txtstagenum.text = slot0._index
	slot0._txtstagename.text = slot0._config.name

	slot0:_checkFirstTimeEnter()
end

function slot0._checkFirstTimeEnter(slot0)
	if AergusiModel.instance:getNewFinishEpisode() == slot0._episodeId then
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_over)
		slot0._itemAni:Play("finish", 0, 0)

		if AergusiModel.instance:isStoryEpisode(slot0._episodeId) and #AergusiModel.instance:getEpisodeClueConfigs(slot0._episodeId, false) > 0 then
			GameFacade.showToast(ToastEnum.Act163GetClueTip)
		end

		AergusiModel.instance:setNewFinishEpisode(0)
	end

	if AergusiModel.instance:getNewUnlockEpisode() == slot0._episodeId then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("waitUnlock")
		AergusiModel.instance:setNewUnlockEpisode(0)
		TaskDispatcher.runDelay(slot0._playUnlock, slot0, slot0._index == 1 and 0.68 or 1.34)
	end
end

function slot0._playUnlock(slot0)
	UIBlockMgr.instance:endBlock("waitUnlock")
	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_open)
	slot0._itemAni:Play("unlock")
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if not AergusiModel.instance:isEpisodeUnlock(slot0._episodeId) then
		GameFacade.showToast(ToastEnum.Act163LevelLocked)

		return
	end

	AergusiController.instance:dispatchEvent(AergusiEvent.EnterEpisode, slot0._episodeId)
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0._playUnlock, slot0)
	slot0:removeEventListeners()
end

return slot0
