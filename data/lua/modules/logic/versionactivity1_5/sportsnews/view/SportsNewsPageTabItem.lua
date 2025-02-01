module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsPageTabItem", package.seeall)

slot0 = class("SportsNewsPageTabItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._imagebg = gohelper.findChildImage(slot0.viewGO, "#image_bg")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._txtselect = gohelper.findChildText(slot0.viewGO, "#go_select/#txt_select")
	slot0._txtselectnum = gohelper.findChildText(slot0.viewGO, "#go_select/#txt_selectnum")
	slot0._gounselect = gohelper.findChild(slot0.viewGO, "#go_unselect")
	slot0._txtunselect = gohelper.findChildText(slot0.viewGO, "#go_unselect/#txt_unselect")
	slot0._txtunselectnum = gohelper.findChildText(slot0.viewGO, "#go_unselect/#txt_unselectnum")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._imagelockbg = gohelper.findChildImage(slot0._golock, "image_lockbg")
	slot0._imageanilockbg = gohelper.findChildImage(slot0._golock, "ani/image_lockbg")
	slot0._txtlock = gohelper.findChildText(slot0.viewGO, "#go_lock/#txt_lock")
	slot0._txtlocknum = gohelper.findChildText(slot0.viewGO, "#go_lock/#txt_locknum")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_redpoint")
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0:getTabStatus() == SportsNewsEnum.PageTabStatus.UnSelect then
		ActivityWarmUpController.instance:switchTab(slot0._index)
		SportsNewsController.instance:dispatchEvent(SportsNewsEvent.OnCutTab, 1)
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:removeEvents()
	TaskDispatcher.cancelTask(slot0.runDelayCallBack, slot0)
end

function slot0.initData(slot0, slot1, slot2)
	slot0._index = slot1
	slot0.viewGO = slot2

	slot0:onInitView()
	slot0:addEvents()

	slot4 = "v1a5_news_tabbtnlock0" .. (slot0._index == 4 and 2 or 1)

	UISpriteSetMgr.instance:setNewsSprite(slot0._imagelockbg, slot4, true)
	UISpriteSetMgr.instance:setNewsSprite(slot0._imageanilockbg, slot4, true)

	slot0._txtselectnum.text = slot1
	slot0._txtunselectnum.text = slot1
	slot0._txtlocknum.text = slot1

	slot0:playTabAnim()
end

function slot0.onRefresh(slot0)
	slot0:enableStatusGameobj()

	slot2 = nil

	UISpriteSetMgr.instance:setNewsSprite(slot0._imagebg, slot0:getTabStatus() == SportsNewsEnum.PageTabStatus.Select and "v1a5_news_tabbtnselect" or "v1a5_news_tabbtnnormal", true)
end

function slot0.enableStatusGameobj(slot0)
	slot2 = slot0:getTabStatus() == SportsNewsEnum.PageTabStatus.Lock

	gohelper.setActive(slot0._golock, slot0._playingAnim or slot2)
	gohelper.setActive(slot0._imagebg.gameObject, not slot2)
	gohelper.setActive(slot0._goselect, slot1 == SportsNewsEnum.PageTabStatus.Select)
	gohelper.setActive(slot0._gounselect, slot1 == SportsNewsEnum.PageTabStatus.UnSelect)
end

function slot0.getTabStatus(slot0)
	slot2 = ActivityWarmUpModel.instance:getSelectedDay() == slot0._index

	if ActivityWarmUpModel.instance:getCurrentDay() < slot0._index then
		return SportsNewsEnum.PageTabStatus.Lock
	elseif slot2 then
		return SportsNewsEnum.PageTabStatus.Select
	else
		return SportsNewsEnum.PageTabStatus.UnSelect
	end
end

function slot0.enableRedDot(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._goreddot, slot1)

	if slot1 then
		RedDotController.instance:addRedDot(slot0._goreddot, slot2, slot3)
	end
end

function slot0.playTabAnim(slot0)
	TaskDispatcher.cancelTask(slot0.runDelayCallBack, slot0)

	if slot0:isCanPlayAnim() then
		slot0._playingAnim = true

		slot0:enableStatusGameobj()
		slot0._animatorPlayer:Play(UIAnimationName.Unlock, slot0.onFinishUnlockAnim, slot0)
		TaskDispatcher.runDelay(slot0.runDelayCallBack, slot0, 1)
	end
end

function slot0.runDelayCallBack(slot0)
	TaskDispatcher.cancelTask(slot0.runDelayCallBack, slot0)

	slot0._playingAnim = nil

	slot0:setUnlockPrefs(slot0._index)
end

function slot0.onFinishUnlockAnim(slot0)
	slot0:enableStatusGameobj()
end

function slot0.isCanPlayAnim(slot0)
	return slot0._index <= ActivityWarmUpModel.instance:getCurrentDay() and slot0:getUnlockPrefs(slot0._index) == 0
end

slot0.DayUnlockPrefs = "v1a5_news_prefs_day_tab"

function slot0.getUnlockPrefs(slot0, slot1)
	return SportsNewsModel.instance:getPrefs(uv0.DayUnlockPrefs .. slot1)
end

function slot0.setUnlockPrefs(slot0, slot1)
	SportsNewsModel.instance:setPrefs(uv0.DayUnlockPrefs .. slot1)
end

return slot0
