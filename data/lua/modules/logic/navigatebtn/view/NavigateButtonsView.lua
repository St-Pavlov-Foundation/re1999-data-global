module("modules.logic.navigatebtn.view.NavigateButtonsView", package.seeall)

slot0 = class("NavigateButtonsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnhome = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_home")
	slot0._btnhelp = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_help")
	slot0._imageclose = gohelper.findChildImage(slot0.viewGO, "#btn_close")
	slot0._imagehome = gohelper.findChildImage(slot0.viewGO, "#btn_home")
	slot0._imagehelp = gohelper.findChildImage(slot0.viewGO, "#btn_help")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnhome:AddClickListener(slot0._btnhomeOnClick, slot0)
	slot0._btnhelp:AddClickListener(slot0._btnhelpOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnhome:RemoveClickListener()
	slot0._btnhelp:RemoveClickListener()
end

slot0.DefaultHelpId = 100

function slot0.ctor(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if not slot1 then
		slot0.param = {
			true,
			true,
			true
		}
	else
		slot0.param = slot1
	end

	if not slot2 then
		slot0.helpId = uv0.DefaultHelpId
	else
		slot0.helpId = slot2
	end

	if slot7 == nil then
		slot0._useLightBtn = true
	else
		slot0._useLightBtn = slot7
	end

	slot0._extendBtns = slot0:getUserDataTb_()
	slot0._closeCallback = slot3
	slot0._homeCallback = slot4
	slot0._helpCallback = slot5
	slot0._callbackObj = slot6
	slot0._animEnabled = true
	slot0.initDone = false
	slot0.needReplaceCloseBtnAudioId = false
	slot0.replaceCloseBtnAudioId = 0
	slot0.needReplaceHomeBtnAudioId = false
	slot0.replaceHomeBtnAudioId = 0
	slot0.needReplaceHelpBtnAudioId = false
	slot0.replaceHelpBtnAudioId = 0
end

function slot0.setOpenCallback(slot0, slot1, slot2)
	if slot0._has_onOpen then
		if slot1 then
			slot1(slot2)
		end

		return
	end

	slot0._openCallback = slot1
	slot0._openCallbackTarget = slot2
end

function slot0.addExtendBtn(slot0, slot1, slot2, slot3, slot4)
	if slot0._extendBtns[slot1] then
		return slot5[1]
	end

	slot6 = gohelper.cloneInPlace(slot0._btnhelp.gameObject)

	gohelper.setActive(slot6, true)
	gohelper.addUIClickAudio(slot6)

	slot7 = SLFramework.UGUI.ButtonWrap.Get(slot6)

	slot7:AddClickListener(slot0._extendBtnClick, slot0, slot1)

	slot0._extendBtns[slot1] = {
		slot7,
		slot3,
		slot4
	}

	if slot2 then
		UISpriteSetMgr.instance:setCommonSprite(slot7:GetComponent(gohelper.Type_Image), slot2)
	end

	gohelper.setSibling(slot6, slot1)

	return slot7
end

function slot0.getExtendBtn(slot0, slot1)
	if slot0._extendBtns[slot1] then
		return slot2[1]
	end
end

function slot0._extendBtnClick(slot0, slot1)
	if not slot0._extendBtns[slot1] then
		return
	end

	if slot2[2] then
		slot3(slot2[3])
	end
end

function slot0.setLight(slot0, slot1)
	if slot1 == nil then
		slot0._useLightBtn = true
	else
		slot0._useLightBtn = slot1
	end
end

function slot0.setCloseCheck(slot0, slot1, slot2)
	slot0._closeCheckFunc = slot1
	slot0._closeCheckObj = slot2
end

function slot0.setHomeCheck(slot0, slot1, slot2)
	slot0._homeCheckFunc = slot1
	slot0._homeCheckObj = slot2
end

function slot0.setOverrideClose(slot0, slot1, slot2)
	slot0._overrideCloseFunc = slot1
	slot0._overrideCloseObj = slot2
end

function slot0.setOverrideHome(slot0, slot1, slot2)
	slot0._overrideHomeFunc = slot1
	slot0._overrideHomeFuncObj = slot2
end

function slot0.setOverrideHelp(slot0, slot1, slot2)
	slot0._overrideHelpFunc = slot1
	slot0._overrideHelpObj = slot2
end

function slot0.setHelpId(slot0, slot1)
	if slot0.helpId == slot1 then
		return
	end

	slot0.helpId = slot1

	slot0:setParam({
		slot0.param[1],
		slot0.param[2],
		true
	})
end

function slot0.hideHelpIcon(slot0)
	if slot0.helpId == uv0.DefaultHelpId then
		return
	end

	slot0.helpId = uv0.DefaultHelpId

	slot0:setParam({
		slot0.param[1],
		slot0.param[2],
		false
	})
end

function slot0.setAnimEnabled(slot0, slot1)
	slot0._animEnabled = slot1
end

function slot0._onEscBtnClick(slot0)
	if slot0.param[1] and slot0._btnclose.gameObject.activeInHierarchy then
		slot0:_btncloseOnClick()
	end
end

function slot0._btncloseOnClick(slot0)
	if slot0._closeCheckFunc and not slot0._closeCheckFunc(slot0._closeCheckObj, slot0._reallyClose, slot0) then
		return
	end

	if slot0._overrideCloseFunc then
		slot0._overrideCloseFunc(slot0._overrideCloseObj)

		return
	end

	slot0:_reallyClose()
end

function slot0._reallyClose(slot0)
	if ViewMgr.instance:isOpen(slot0.viewContainer.viewName) then
		ViewMgr.instance:closeView(slot1, nil, true)
	end

	if slot0._closeCallback then
		slot0._closeCallback(slot0._callbackObj)
	end
end

function slot0._btnhomeOnClick(slot0)
	if slot0._homeCheckFunc and not slot0._homeCheckFunc(slot0._homeCheckObj, slot0._reallyHome, slot0) then
		return
	end

	if slot0._overrideHomeFunc then
		slot0._overrideHomeFunc(slot0._overrideHomeFuncObj)

		return
	end

	slot0:_reallyHome()
end

function slot0._reallyHome(slot0)
	uv0.homeClick()

	if slot0._homeCallback then
		slot0._homeCallback(slot0._callbackObj)
	end
end

function slot0.homeClick()
	NavigateMgr.instance:dispatchEvent(NavigateEvent.BeforeClickHome)

	DungeonModel.instance.curSendEpisodeId = nil

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomController.instance:homeClick()
	else
		ViewMgr.instance:closeAllPopupViews(nil, true)
		MainController.instance:enterMainScene(true, false)

		if not ViewMgr.instance:isOpen(ViewName.MainView) and GameSceneMgr.instance:getCurSceneType() == SceneType.Main and not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DontOpenMain) then
			ViewMgr.instance:openView(ViewName.MainView)
		elseif slot1 and slot2 then
			ViewMgr.instance:closeView(ViewName.MainView)
		end
	end

	NavigateMgr.instance:dispatchEvent(NavigateEvent.ClickHome)
end

function slot0._btnhelpOnClick(slot0)
	if not HelpController.instance:checkGuideStepLock(slot0.helpId) then
		return
	end

	if slot0._overrideHelpFunc then
		slot0._overrideHelpFunc(slot0._overrideHelpObj)

		return
	end

	HelpController.instance:showHelp(slot0.helpId)

	if slot0._helpCallback then
		slot0._helpCallback(slot0._callbackObj)
	end
end

function slot0._changeIconState(slot0)
	if not slot0._initialized then
		return
	end

	if slot0._useLightBtn then
		UISpriteSetMgr.instance:setCommonSprite(slot0._imageclose, "btn_back_light")
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagehome, "btn_home_light")
	else
		UISpriteSetMgr.instance:setCommonSprite(slot0._imageclose, "btn_back_dark")
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagehome, "btn_home_dark")
	end
end

function slot0._editableInitView(slot0)
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(slot0._btnhome.gameObject, AudioEnum.UI.play_ui_common_pause)

	slot0._initialized = true

	slot0:refreshUI()

	slot0.initDone = true
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._btnclose and slot0._btnclose.gameObject, slot0.param[1])
	gohelper.setActive(slot0._btnhome and slot0._btnhome.gameObject, slot0.param[2])
	slot0:_updateHelpBtn()
end

function slot0._updateHelpBtn(slot0)
	if slot0._helpVisible then
		gohelper.setActive(slot0._btnhelp and slot0._btnhelp.gameObject, slot0._helpVisible)
	else
		gohelper.setActive(slot0._btnhelp and slot0._btnhelp.gameObject, slot0.param[3] and HelpController.instance:checkGuideStepLock(slot0.helpId))
	end
end

function slot0.setParam(slot0, slot1)
	slot0.param = slot1

	slot0:refreshUI()
end

function slot0.showHelpBtnIcon(slot0)
	slot0:setParam({
		slot0.param[1],
		slot0.param[2],
		true
	})
end

function slot0.changerHelpId(slot0, slot1)
	slot0.helpId = slot1

	slot0:showHelpBtnIcon()
end

function slot0.resetCloseBtnAudioId(slot0, slot1)
	if slot0.initDone then
		slot0:_resetCloseBtnAudioId(slot1)
	else
		slot0.needReplaceCloseBtnAudioId = true
		slot0.replaceCloseBtnAudioId = slot1
	end
end

function slot0._resetCloseBtnAudioId(slot0, slot1)
	if slot1 ~= 0 then
		gohelper.addUIClickAudio(slot0._btnclose.gameObject, slot1)
	else
		gohelper.removeUIClickAudio(slot0._btnclose.gameObject)
	end
end

function slot0.resetHomeBtnAudioId(slot0, slot1)
	if slot0.initDone then
		slot0:_resetHomeBtnAudioId(slot1)
	else
		slot0.needReplaceHomeBtnAudioId = true
		slot0.replaceHomeBtnAudioId = slot1
	end
end

function slot0._resetHomeBtnAudioId(slot0, slot1)
	if slot1 ~= 0 then
		gohelper.addUIClickAudio(slot0._btnhome.gameObject, slot1)
	else
		gohelper.removeUIClickAudio(slot0._btnhome.gameObject)
	end
end

function slot0.resetHelpBtnAudioId(slot0, slot1)
	if slot0.initDone then
		slot0:_resetHelpBtnAudioId(slot1)
	else
		slot0.needReplaceHelpBtnAudioId = true
		slot0.replaceHelpBtnAudioId = slot1
	end
end

function slot0._resetHelpBtnAudioId(slot0, slot1)
	if slot1 ~= 0 then
		gohelper.addUIClickAudio(slot0._btnhelp.gameObject, slot1)
	else
		gohelper.removeUIClickAudio(slot0._btnhelp.gameObject)
	end
end

function slot0.setHelpVisible(slot0, slot1)
	slot0._helpVisible = slot1

	if not slot0._btnhelp then
		return
	end

	gohelper.setActive(slot0._btnhelp.gameObject, slot1)
end

function slot0.resetOnCloseViewAudio(slot0, slot1)
	slot0:resetCloseBtnAudioId(slot1)
	slot0:resetHomeBtnAudioId(slot1)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._extendBtns) do
		slot5[1]:RemoveClickListener()
	end
end

function slot0.onOpen(slot0)
	if slot0._anim and slot0._animEnabled then
		slot0._anim:Play(UIAnimationName.Open, 0, 0)
	end

	NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._onEscBtnClick, slot0, true)

	if slot0.needReplaceCloseBtnAudioId then
		slot0:_resetCloseBtnAudioId(slot0.replaceCloseBtnAudioId)

		slot0.needReplaceCloseBtnAudioId = false
	end

	if slot0.needReplaceHomeBtnAudioId then
		slot0:_resetHomeBtnAudioId(slot0.replaceHomeBtnAudioId)

		slot0.needReplaceHomeBtnAudioId = false
	end

	if slot0.needReplaceHelpBtnAudioId then
		slot0:_resetHomeBtnAudioId(slot0.replaceHelpBtnAudioId)

		slot0.needReplaceHelpBtnAudioId = false
	end

	if slot0._openCallback then
		slot0._openCallback(slot0._openCallbackTarget)
	end

	slot0:addEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, slot0._gudieEnd, slot0)
end

function slot0._gudieEnd(slot0)
	slot0:_updateHelpBtn()
end

function slot0.onClose(slot0)
	if slot0._anim and slot0._animEnabled then
		slot0._anim:Play(UIAnimationName.Close, 0, 0)
	end
end

slot0.prefabPath = "ui/viewres/common/commonbtnsview.prefab"

return slot0
