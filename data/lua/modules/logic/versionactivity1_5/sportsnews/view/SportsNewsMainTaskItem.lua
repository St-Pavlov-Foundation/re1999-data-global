module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsMainTaskItem", package.seeall)

slot0 = class("SportsNewsMainTaskItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._gounlocked = gohelper.findChild(slot0.viewGO, "go_unlocked")
	slot0._imageItemBG1 = gohelper.findChildImage(slot0.viewGO, "go_unlocked/#image_ItemBG1")
	slot0._gounlockedpic = gohelper.findChildSingleImage(slot0.viewGO, "go_unlocked/#go_unlockedpic")
	slot0._txtunlocktitle = gohelper.findChildText(slot0.viewGO, "go_unlocked/#txt_unlocktitle")
	slot0._scrollunlockdesc = gohelper.findChildScrollRect(slot0.viewGO, "go_unlocked/#scroll_unlockdesc")
	slot0._txtunlockdescr = gohelper.findChildText(slot0.viewGO, "go_unlocked/#scroll_unlockdesc/Viewport/#txt_unlockdescr")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "go_locked")
	slot0._imageItemBG2 = gohelper.findChildImage(slot0.viewGO, "go_locked/#image_ItemBG2")
	slot0._golockedpic = gohelper.findChildSingleImage(slot0.viewGO, "go_locked/#go_lockedpic")
	slot0._txtlocktitle = gohelper.findChildText(slot0.viewGO, "go_locked/#txt_locktitle")
	slot0._scrolllockdesc = gohelper.findChildScrollRect(slot0.viewGO, "go_locked/#scroll_lockdesc")
	slot0._txtlockdescr = gohelper.findChildText(slot0.viewGO, "go_locked/#scroll_lockdesc/Viewport/#txt_lockdescr")
	slot0._btnFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_locked/#btn_Finish/Click")
	slot0._btnGo = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_locked/#btn_Go/Click")
	slot0._goRedPoint = gohelper.findChild(slot0.viewGO, "#go_RedPoint")
	slot0._goFinish = gohelper.findChild(slot0.viewGO, "go_locked/#btn_Finish")
	slot0._goGo = gohelper.findChild(slot0.viewGO, "go_locked/#btn_Go")
	slot0._btnInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_unlocked/#btn_Info/Click")
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnFinish:AddClickListener(slot0._btnFinishOnClick, slot0)
	slot0._btnGo:AddClickListener(slot0._btnGoOnClick, slot0)
	slot0._btnInfo:AddClickListener(slot0._btnInfoOnClick, slot0)
	slot0:addEventCb(SportsNewsController.instance, SportsNewsEvent.OnCutTab, slot0.onCutTab, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnFinish:RemoveClickListener()
	slot0._btnGo:RemoveClickListener()
	slot0._btnInfo:RemoveClickListener()
	slot0:removeEventCb(SportsNewsController.instance, SportsNewsEvent.OnCutTab, slot0.onCutTab, slot0)
end

function slot0._btnFinishOnClick(slot0)
	if slot0._playingAnim then
		return
	end

	SportsNewsModel.instance:finishOrder(VersionActivity1_5Enum.ActivityId.SportsNews, slot0.orderMO.id)
	slot0:playAnim()
end

function slot0._btnGoOnClick(slot0)
	if slot0._playingAnim then
		return
	end

	SportsNewsController.instance:jumpToFinishTask(slot0.orderMO, nil, slot0)
end

function slot0._btnInfoOnClick(slot0)
	if slot0._playingAnim then
		return
	end

	if slot0.orderMO.status ~= ActivityWarmUpEnum.OrderStatus.Finished then
		SportsNewsModel.instance:onReadEnd(VersionActivity1_5Enum.ActivityId.SportsNews, slot0.orderMO.id)
	end

	ViewMgr.instance:openView(ViewName.SportsNewsReadView, {
		orderMO = slot0.orderMO
	})
end

function slot0._editableInitView(slot0)
	slot0._txtunlocktitle.overflowMode = TMPro.TextOverflowModes.Ellipsis
	slot0._txtunlockdescr.overflowMode = TMPro.TextOverflowModes.Ellipsis
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:removeEvents()
	slot0._gounlockedpic:UnLoadImage()
	slot0._golockedpic:UnLoadImage()
end

function slot0.initData(slot0, slot1, slot2)
	slot0.viewGO = slot1
	slot0.index = slot2

	slot0:onInitView()
	slot0:addEvents()
end

function slot0.onRefresh(slot0, slot1)
	slot0.orderMO = slot1

	if not slot0._playingAnim then
		slot0._anim.enabled = true

		slot0._anim:Play(UIAnimationName.Idle, 0, 0)
	end

	if slot0.orderMO.status == ActivityWarmUpEnum.OrderStatus.Finished then
		slot0:unlockState()

		if slot0:isCanPlayAnim() then
			slot0:playAnim()
		end
	else
		slot0:lockState()
	end
end

function slot0._onJumpFinish(slot0)
end

function slot0.unlockState(slot0)
	gohelper.setActive(slot0._gounlocked, true)
	gohelper.setActive(slot0._golocked, slot0._playingAnim)

	slot0._txtunlocktitle.text = slot0.orderMO.cfg.name
	slot0._txtunlockdescr.text = slot0.orderMO.cfg.desc
	slot0._scrollunlockdesc:GetComponent(gohelper.Type_LimitedScrollRect).verticalNormalizedPosition = 1

	slot0._gounlockedpic:LoadImage(ResUrl.getV1a5News(slot0.orderMO.cfg.bossPic))
end

function slot0.lockState(slot0)
	gohelper.setActive(slot0._gounlocked, false)
	gohelper.setActive(slot0._golocked, true)
	gohelper.setActive(slot0._goFinish, slot0.orderMO.status == ActivityWarmUpEnum.OrderStatus.Collected)
	gohelper.setActive(slot0._goGo, slot1 == ActivityWarmUpEnum.OrderStatus.Accepted)

	slot3 = nil
	slot0._txtlocktitle.text = slot0.orderMO.cfg.name
	slot0._txtlockdescr.text = string.format(luaLang("v1a5_news_order_goto_title"), slot0.orderMO.cfg.location)
	slot0._scrolllockdesc:GetComponent(gohelper.Type_LimitedScrollRect).verticalNormalizedPosition = 1

	slot0._golockedpic:LoadImage(ResUrl.getV1a5News(slot0.orderMO.cfg.bossPic))
end

slot0.UI_CLICK_BLOCK_KEY = "SportsNewsMainTaskItemClick"

function slot0.playAnim(slot0)
	slot0._playingAnim = true

	slot0:setUnlockPrefs(slot0.orderMO.id)
	gohelper.setActive(slot0._gounlocked, true)
	gohelper.setActive(slot0._golocked, true)
	slot0._animatorPlayer:Play(UIAnimationName.Unlock, slot0.onFinishUnlockAnim, slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_v1a5_news.play_ui_wulu_complete_burn)
end

function slot0.onFinishUnlockAnim(slot0)
	gohelper.setActive(slot0._golocked, false)
	gohelper.setActive(slot0._gounlocked, true)

	slot0._playingAnim = nil

	slot0:onRefresh(slot0.orderMO)
end

function slot0.isCanPlayAnim(slot0)
	return slot0:getUnlockPrefs(slot0.orderMO.id) == 0
end

slot0.DayUnlockPrefs = "v1a5_news_prefs_order"

function slot0.getUnlockPrefs(slot0, slot1)
	return SportsNewsModel.instance:getPrefs(uv0.DayUnlockPrefs .. slot1)
end

function slot0.setUnlockPrefs(slot0, slot1)
	SportsNewsModel.instance:setPrefs(uv0.DayUnlockPrefs .. slot1)
end

function slot0.onCutTab(slot0, slot1)
	if slot0._playingAnim then
		slot0._anim:Play(UIAnimationName.Unlock, 0, 0)

		slot0._anim.enabled = false

		slot0:onFinishUnlockAnim()
	end
end

return slot0
