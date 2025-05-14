module("modules.logic.navigatebtn.view.NavigateButtonsView", package.seeall)

local var_0_0 = class("NavigateButtonsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnhome = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_home")
	arg_1_0._btnhelp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_help")
	arg_1_0._imageclose = gohelper.findChildImage(arg_1_0.viewGO, "#btn_close")
	arg_1_0._imagehome = gohelper.findChildImage(arg_1_0.viewGO, "#btn_home")
	arg_1_0._imagehelp = gohelper.findChildImage(arg_1_0.viewGO, "#btn_help")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnhome:AddClickListener(arg_2_0._btnhomeOnClick, arg_2_0)
	arg_2_0._btnhelp:AddClickListener(arg_2_0._btnhelpOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnhome:RemoveClickListener()
	arg_3_0._btnhelp:RemoveClickListener()
end

var_0_0.DefaultHelpId = 100

function var_0_0.ctor(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	if not arg_4_1 then
		arg_4_0.param = {
			true,
			true,
			true
		}
	else
		arg_4_0.param = arg_4_1
	end

	if not arg_4_2 then
		arg_4_0.helpId = var_0_0.DefaultHelpId
	else
		arg_4_0.helpId = arg_4_2
	end

	if arg_4_7 == nil then
		arg_4_0._useLightBtn = true
	else
		arg_4_0._useLightBtn = arg_4_7
	end

	arg_4_0._extendBtns = arg_4_0:getUserDataTb_()
	arg_4_0._closeCallback = arg_4_3
	arg_4_0._homeCallback = arg_4_4
	arg_4_0._helpCallback = arg_4_5
	arg_4_0._callbackObj = arg_4_6
	arg_4_0._animEnabled = true
	arg_4_0.initDone = false
	arg_4_0.needReplaceCloseBtnAudioId = false
	arg_4_0.replaceCloseBtnAudioId = 0
	arg_4_0.needReplaceHomeBtnAudioId = false
	arg_4_0.replaceHomeBtnAudioId = 0
	arg_4_0.needReplaceHelpBtnAudioId = false
	arg_4_0.replaceHelpBtnAudioId = 0
end

function var_0_0.setOpenCallback(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._has_onOpen then
		if arg_5_1 then
			arg_5_1(arg_5_2)
		end

		return
	end

	arg_5_0._openCallback = arg_5_1
	arg_5_0._openCallbackTarget = arg_5_2
end

function var_0_0.addExtendBtn(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_0._extendBtns[arg_6_1]

	if var_6_0 then
		return var_6_0[1]
	end

	local var_6_1 = gohelper.cloneInPlace(arg_6_0._btnhelp.gameObject)

	gohelper.setActive(var_6_1, true)
	gohelper.addUIClickAudio(var_6_1)

	local var_6_2 = SLFramework.UGUI.ButtonWrap.Get(var_6_1)

	var_6_2:AddClickListener(arg_6_0._extendBtnClick, arg_6_0, arg_6_1)

	arg_6_0._extendBtns[arg_6_1] = {
		var_6_2,
		arg_6_3,
		arg_6_4
	}

	if arg_6_2 then
		local var_6_3 = var_6_2:GetComponent(gohelper.Type_Image)

		UISpriteSetMgr.instance:setCommonSprite(var_6_3, arg_6_2)
	end

	gohelper.setSibling(var_6_1, arg_6_1)

	return var_6_2
end

function var_0_0.getExtendBtn(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._extendBtns[arg_7_1]

	if var_7_0 then
		return var_7_0[1]
	end
end

function var_0_0._extendBtnClick(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._extendBtns[arg_8_1]

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0[2]
	local var_8_2 = var_8_0[3]

	if var_8_1 then
		var_8_1(var_8_2)
	end
end

function var_0_0.setLight(arg_9_0, arg_9_1)
	if arg_9_1 == nil then
		arg_9_0._useLightBtn = true
	else
		arg_9_0._useLightBtn = arg_9_1
	end
end

function var_0_0.setCloseCheck(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._closeCheckFunc = arg_10_1
	arg_10_0._closeCheckObj = arg_10_2
end

function var_0_0.setHomeCheck(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._homeCheckFunc = arg_11_1
	arg_11_0._homeCheckObj = arg_11_2
end

function var_0_0.setOverrideClose(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._overrideCloseFunc = arg_12_1
	arg_12_0._overrideCloseObj = arg_12_2
end

function var_0_0.setOverrideHome(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._overrideHomeFunc = arg_13_1
	arg_13_0._overrideHomeFuncObj = arg_13_2
end

function var_0_0.setOverrideHelp(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._overrideHelpFunc = arg_14_1
	arg_14_0._overrideHelpObj = arg_14_2
end

function var_0_0.setHelpId(arg_15_0, arg_15_1)
	if arg_15_0.helpId == arg_15_1 then
		return
	end

	arg_15_0.helpId = arg_15_1

	arg_15_0:setParam({
		arg_15_0.param[1],
		arg_15_0.param[2],
		true
	})
end

function var_0_0.hideHelpIcon(arg_16_0)
	if arg_16_0.helpId == var_0_0.DefaultHelpId then
		return
	end

	arg_16_0.helpId = var_0_0.DefaultHelpId

	arg_16_0:setParam({
		arg_16_0.param[1],
		arg_16_0.param[2],
		false
	})
end

function var_0_0.setAnimEnabled(arg_17_0, arg_17_1)
	arg_17_0._animEnabled = arg_17_1
end

function var_0_0._onEscBtnClick(arg_18_0)
	if arg_18_0.param[1] and arg_18_0._btnclose.gameObject.activeInHierarchy then
		arg_18_0:_btncloseOnClick()
	end
end

function var_0_0._btncloseOnClick(arg_19_0)
	if arg_19_0._closeCheckFunc and not arg_19_0._closeCheckFunc(arg_19_0._closeCheckObj, arg_19_0._reallyClose, arg_19_0) then
		return
	end

	if arg_19_0._overrideCloseFunc then
		arg_19_0._overrideCloseFunc(arg_19_0._overrideCloseObj)

		return
	end

	arg_19_0:_reallyClose()
end

function var_0_0._reallyClose(arg_20_0)
	local var_20_0 = arg_20_0.viewContainer.viewName

	if ViewMgr.instance:isOpen(var_20_0) then
		ViewMgr.instance:closeView(var_20_0, nil, true)
	end

	if arg_20_0._closeCallback then
		arg_20_0._closeCallback(arg_20_0._callbackObj)
	end
end

function var_0_0._btnhomeOnClick(arg_21_0)
	if arg_21_0._homeCheckFunc and not arg_21_0._homeCheckFunc(arg_21_0._homeCheckObj, arg_21_0._reallyHome, arg_21_0) then
		return
	end

	if arg_21_0._overrideHomeFunc then
		arg_21_0._overrideHomeFunc(arg_21_0._overrideHomeFuncObj)

		return
	end

	arg_21_0:_reallyHome()
end

function var_0_0._reallyHome(arg_22_0)
	var_0_0.homeClick()

	if arg_22_0._homeCallback then
		arg_22_0._homeCallback(arg_22_0._callbackObj)
	end
end

function var_0_0.homeClick()
	NavigateMgr.instance:dispatchEvent(NavigateEvent.BeforeClickHome)

	DungeonModel.instance.curSendEpisodeId = nil

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomController.instance:homeClick()
	else
		ViewMgr.instance:closeAllPopupViews(nil, true)
		MainController.instance:enterMainScene(true, false)

		local var_23_0 = GameSceneMgr.instance:getCurSceneType()
		local var_23_1 = ViewMgr.instance:isOpen(ViewName.MainView)
		local var_23_2 = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DontOpenMain)

		if not var_23_1 and var_23_0 == SceneType.Main and not var_23_2 then
			ViewMgr.instance:openView(ViewName.MainView)
		elseif var_23_1 and var_23_2 then
			ViewMgr.instance:closeView(ViewName.MainView)
		end
	end

	NavigateMgr.instance:dispatchEvent(NavigateEvent.ClickHome)
end

function var_0_0._btnhelpOnClick(arg_24_0)
	if not HelpController.instance:checkGuideStepLock(arg_24_0.helpId) then
		return
	end

	if arg_24_0._overrideHelpFunc then
		arg_24_0._overrideHelpFunc(arg_24_0._overrideHelpObj)

		return
	end

	HelpController.instance:showHelp(arg_24_0.helpId)

	if arg_24_0._helpCallback then
		arg_24_0._helpCallback(arg_24_0._callbackObj)
	end
end

function var_0_0._changeIconState(arg_25_0)
	if not arg_25_0._initialized then
		return
	end

	if arg_25_0._useLightBtn then
		UISpriteSetMgr.instance:setCommonSprite(arg_25_0._imageclose, "btn_back_light")
		UISpriteSetMgr.instance:setCommonSprite(arg_25_0._imagehome, "btn_home_light")
	else
		UISpriteSetMgr.instance:setCommonSprite(arg_25_0._imageclose, "btn_back_dark")
		UISpriteSetMgr.instance:setCommonSprite(arg_25_0._imagehome, "btn_home_dark")
	end
end

function var_0_0._editableInitView(arg_26_0)
	arg_26_0._anim = arg_26_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(arg_26_0._btnhome.gameObject, AudioEnum.UI.play_ui_common_pause)

	arg_26_0._initialized = true

	arg_26_0:refreshUI()

	arg_26_0.initDone = true
end

function var_0_0.refreshUI(arg_27_0)
	gohelper.setActive(arg_27_0._btnclose and arg_27_0._btnclose.gameObject, arg_27_0.param[1])
	gohelper.setActive(arg_27_0._btnhome and arg_27_0._btnhome.gameObject, arg_27_0.param[2])
	arg_27_0:_updateHelpBtn()
end

function var_0_0._updateHelpBtn(arg_28_0)
	if arg_28_0._helpVisible then
		gohelper.setActive(arg_28_0._btnhelp and arg_28_0._btnhelp.gameObject, arg_28_0._helpVisible)
	else
		gohelper.setActive(arg_28_0._btnhelp and arg_28_0._btnhelp.gameObject, arg_28_0.param[3] and HelpController.instance:checkGuideStepLock(arg_28_0.helpId))
	end
end

function var_0_0.setParam(arg_29_0, arg_29_1)
	arg_29_0.param = arg_29_1

	arg_29_0:refreshUI()
end

function var_0_0.showHelpBtnIcon(arg_30_0)
	arg_30_0:setParam({
		arg_30_0.param[1],
		arg_30_0.param[2],
		true
	})
end

function var_0_0.changerHelpId(arg_31_0, arg_31_1)
	arg_31_0.helpId = arg_31_1

	arg_31_0:showHelpBtnIcon()
end

function var_0_0.resetCloseBtnAudioId(arg_32_0, arg_32_1)
	if arg_32_0.initDone then
		arg_32_0:_resetCloseBtnAudioId(arg_32_1)
	else
		arg_32_0.needReplaceCloseBtnAudioId = true
		arg_32_0.replaceCloseBtnAudioId = arg_32_1
	end
end

function var_0_0._resetCloseBtnAudioId(arg_33_0, arg_33_1)
	if arg_33_1 ~= 0 then
		gohelper.addUIClickAudio(arg_33_0._btnclose.gameObject, arg_33_1)
	else
		gohelper.removeUIClickAudio(arg_33_0._btnclose.gameObject)
	end
end

function var_0_0.resetHomeBtnAudioId(arg_34_0, arg_34_1)
	if arg_34_0.initDone then
		arg_34_0:_resetHomeBtnAudioId(arg_34_1)
	else
		arg_34_0.needReplaceHomeBtnAudioId = true
		arg_34_0.replaceHomeBtnAudioId = arg_34_1
	end
end

function var_0_0._resetHomeBtnAudioId(arg_35_0, arg_35_1)
	if arg_35_1 ~= 0 then
		gohelper.addUIClickAudio(arg_35_0._btnhome.gameObject, arg_35_1)
	else
		gohelper.removeUIClickAudio(arg_35_0._btnhome.gameObject)
	end
end

function var_0_0.resetHelpBtnAudioId(arg_36_0, arg_36_1)
	if arg_36_0.initDone then
		arg_36_0:_resetHelpBtnAudioId(arg_36_1)
	else
		arg_36_0.needReplaceHelpBtnAudioId = true
		arg_36_0.replaceHelpBtnAudioId = arg_36_1
	end
end

function var_0_0._resetHelpBtnAudioId(arg_37_0, arg_37_1)
	if arg_37_1 ~= 0 then
		gohelper.addUIClickAudio(arg_37_0._btnhelp.gameObject, arg_37_1)
	else
		gohelper.removeUIClickAudio(arg_37_0._btnhelp.gameObject)
	end
end

function var_0_0.setHelpVisible(arg_38_0, arg_38_1)
	arg_38_0._helpVisible = arg_38_1

	if not arg_38_0._btnhelp then
		return
	end

	gohelper.setActive(arg_38_0._btnhelp.gameObject, arg_38_1)
end

function var_0_0.resetOnCloseViewAudio(arg_39_0, arg_39_1)
	arg_39_0:resetCloseBtnAudioId(arg_39_1)
	arg_39_0:resetHomeBtnAudioId(arg_39_1)
end

function var_0_0.onDestroyView(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(arg_40_0._extendBtns) do
		iter_40_1[1]:RemoveClickListener()
	end
end

function var_0_0.onOpen(arg_41_0)
	if arg_41_0._anim and arg_41_0._animEnabled then
		arg_41_0._anim:Play(UIAnimationName.Open, 0, 0)
	end

	NavigateMgr.instance:addEscape(arg_41_0.viewContainer.viewName, arg_41_0._onEscBtnClick, arg_41_0, true)

	if arg_41_0.needReplaceCloseBtnAudioId then
		arg_41_0:_resetCloseBtnAudioId(arg_41_0.replaceCloseBtnAudioId)

		arg_41_0.needReplaceCloseBtnAudioId = false
	end

	if arg_41_0.needReplaceHomeBtnAudioId then
		arg_41_0:_resetHomeBtnAudioId(arg_41_0.replaceHomeBtnAudioId)

		arg_41_0.needReplaceHomeBtnAudioId = false
	end

	if arg_41_0.needReplaceHelpBtnAudioId then
		arg_41_0:_resetHomeBtnAudioId(arg_41_0.replaceHelpBtnAudioId)

		arg_41_0.needReplaceHelpBtnAudioId = false
	end

	if arg_41_0._openCallback then
		arg_41_0._openCallback(arg_41_0._openCallbackTarget)
	end

	arg_41_0:addEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, arg_41_0._gudieEnd, arg_41_0)
end

function var_0_0._gudieEnd(arg_42_0)
	arg_42_0:_updateHelpBtn()
end

function var_0_0.onClose(arg_43_0)
	if arg_43_0._anim and arg_43_0._animEnabled then
		arg_43_0._anim:Play(UIAnimationName.Close, 0, 0)
	end
end

var_0_0.prefabPath = "ui/viewres/common/commonbtnsview.prefab"

return var_0_0
