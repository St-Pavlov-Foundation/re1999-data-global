module("modules.logic.playercard.view.NewPlayerCardContentView", package.seeall)

local var_0_0 = class("NewPlayerCardContentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "view")
	arg_1_0._goLoading = gohelper.findChild(arg_1_0.viewGO, "loadingmainview")
	arg_1_0._loadAnim = arg_1_0._goLoading:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goBottom = gohelper.findChild(arg_1_0.viewGO, "bottom")
	arg_1_0._btnbottomclose = gohelper.findChildButton(arg_1_0.viewGO, "bottom/#btn_bottomclose")
	arg_1_0._goskinpreviewnode = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_skinpreview")
	arg_1_0._btnswitchskin = gohelper.findChildButton(arg_1_0.viewGO, "#btn_switch")
	arg_1_0._goswitchskinreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_switch/#go_reddot")
	arg_1_0._bgreddot = RedDotController.instance:addNotEventRedDot(arg_1_0._goswitchskinreddot, arg_1_0._isShowRedDot, arg_1_0)
	arg_1_0._openswitchskin = false
	arg_1_0._firstopen = true
	arg_1_0._bottomAnimator = arg_1_0._goBottom:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbottomclose:AddClickListener(arg_2_0._btnswitchskinOnClick, arg_2_0)
	arg_2_0._btnswitchskin:AddClickListener(arg_2_0._btnswitchskinOnClick, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, arg_2_0.SwitchTheme, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ChangeSkin, arg_2_0.ChangeSkin, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbottomclose:RemoveClickListener()
	arg_3_0._btnswitchskin:RemoveClickListener()
	arg_3_0:removeEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, arg_3_0.SwitchTheme, arg_3_0)
	arg_3_0:removeEventCb(PlayerCardController.instance, PlayerCardEvent.ChangeSkin, arg_3_0.ChangeSkin, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._isShowRedDot(arg_6_0)
	return PlayerCardModel.instance:getShowRed()
end

function var_0_0.onOpen(arg_7_0)
	if arg_7_0.viewParam and arg_7_0.viewParam.userId then
		arg_7_0.userId = arg_7_0.viewParam.userId
	end

	arg_7_0.playercardinfo = PlayerCardModel.instance:getCardInfo(arg_7_0.userId)

	gohelper.setActive(arg_7_0._goBottom, arg_7_0._openswitchskin)
	gohelper.setActive(arg_7_0._btnswitchskin.gameObject, arg_7_0.playercardinfo:isSelf())

	arg_7_0.skinId = arg_7_0.playercardinfo:getThemeId()

	arg_7_0:loadRes(arg_7_0.skinId)
	arg_7_0:_initSkinPreView()
end

function var_0_0._initSkinPreView(arg_8_0)
	local var_8_0 = arg_8_0.viewContainer:getSetting().otherRes.skinpreview
	local var_8_1 = arg_8_0.viewContainer:getRes(var_8_0)

	arg_8_0.goskinpreview = gohelper.clone(var_8_1, arg_8_0._goskinpreviewnode)
	arg_8_0.skinpreviewcls = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0.goskinpreview, PlayerCardSkinPreView)
	arg_8_0._skinCls = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0.viewGO, PlayerCardThemeView)
	arg_8_0._skinCls.viewParam = arg_8_0.viewParam

	arg_8_0._skinCls:canOpen()
end

function var_0_0.loadRes(arg_9_0, arg_9_1)
	local var_9_0 = "playercardview"

	if not string.nilorempty(arg_9_1) and arg_9_1 ~= 0 then
		var_9_0 = var_9_0 .. "_" .. arg_9_1
	end

	arg_9_0._path = string.format("ui/viewres/player/playercard/%s.prefab", var_9_0)
	arg_9_0._loader = MultiAbLoader.New()

	arg_9_0._loader:addPath(arg_9_0._path)
	arg_9_0._loader:startLoad(arg_9_0._onLoadFinish, arg_9_0)
end

function var_0_0._onLoadFinish(arg_10_0)
	local var_10_0 = arg_10_0._loader:getAssetItem(arg_10_0._path):GetResource(arg_10_0._path)

	arg_10_0._viewGo = gohelper.clone(var_10_0, arg_10_0._goContent)
	arg_10_0._viewCls = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._viewGo, NewPlayerCardView)
	arg_10_0._achievementCls = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._viewGo, PlayerCardAchievement)
	arg_10_0._infoCls = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._viewGo, PlayerCardPlayerInfo)
	arg_10_0._viewCls.viewParam = arg_10_0.viewParam
	arg_10_0._viewCls.viewContainer = arg_10_0.viewContainer
	arg_10_0._viewCls.contentview = arg_10_0
	arg_10_0._achievementCls.viewParam = arg_10_0.viewParam
	arg_10_0._achievementCls.viewContainer = arg_10_0.viewContainer
	arg_10_0._infoCls.viewParam = arg_10_0.viewParam

	if arg_10_0._changeSkin then
		arg_10_0:closeLoading()
	end

	if arg_10_0._tempSkinId then
		arg_10_0._viewCls:toBottomView()
	else
		arg_10_0:closeLoading()

		if not arg_10_0._firstopen then
			arg_10_0._viewCls:backBottomView()
		end
	end

	arg_10_0._firstopen = false
end

function var_0_0.afterOpenAnim(arg_11_0)
	arg_11_0._viewCls:toBottomView()
end

function var_0_0._btnswitchskinOnClick(arg_12_0)
	if arg_12_0.playercardinfo:isSelf() then
		arg_12_0._openswitchskin = not arg_12_0._openswitchskin

		if not arg_12_0._openswitchskin then
			arg_12_0:onClickCloseBottomView()
			arg_12_0._viewCls:backBottomView()
		else
			gohelper.setActive(arg_12_0._goBottom, arg_12_0._openswitchskin)
			gohelper.setActive(arg_12_0._btnswitchskin.gameObject, not arg_12_0._openswitchskin)
		end

		if arg_12_0._openswitchskin then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_move)
			arg_12_0._viewCls:toBottomView()
			PlayerCardModel.instance:setIsOpenSkinView(true)
			PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ShowTheme)
		end
	end
end

function var_0_0.closeLoading(arg_13_0)
	arg_13_0:checkCanOpen()
	arg_13_0._loadAnim:Play("close")
	TaskDispatcher.runDelay(arg_13_0.afterClose, arg_13_0, 0.3)
end

function var_0_0.afterClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.afterClose, arg_14_0)
	gohelper.setActive(arg_14_0._goLoading, false)

	arg_14_0._changeSkin = false

	UIBlockMgr.instance:endBlock("NewPlayerCardContentView")
end

function var_0_0.SwitchTheme(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	if not arg_15_0._tempSkinId and arg_15_1 == arg_15_0.skinId then
		return
	end

	if arg_15_0._tempSkinId == arg_15_1 then
		return
	end

	arg_15_0._tempSkinId = arg_15_1

	if not arg_15_0._oldViewGo then
		arg_15_0._oldViewGo = arg_15_0._viewGo
	end

	if arg_15_0._loader then
		arg_15_0._loader:dispose()

		arg_15_0._loader = nil
	end

	arg_15_0._changeSkin = true

	gohelper.setActive(arg_15_0._goLoading, true)
	UIBlockMgr.instance:startBlock("NewPlayerCardContentView")
	TaskDispatcher.runDelay(arg_15_0.afterOpenLoad, arg_15_0, 0.3)
	gohelper.setActive(arg_15_0._goswitchskinreddot, arg_15_0:_isShowRedDot())
end

function var_0_0.afterOpenLoad(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.afterOpenLoad, arg_16_0)
	arg_16_0:disposeView()

	if arg_16_0._isreset and not arg_16_0._tempSkinId then
		arg_16_0:loadRes(arg_16_0.skinId)
	else
		arg_16_0:loadRes(arg_16_0._tempSkinId)
	end
end

function var_0_0.ChangeSkin(arg_17_0, arg_17_1)
	arg_17_0._tempSkinId = nil
	arg_17_0.skinId = arg_17_1
end

function var_0_0.getCurrentView(arg_18_0)
	return arg_18_0._viewCls
end

function var_0_0.checkCanOpen(arg_19_0)
	arg_19_0._viewCls:canOpen(arg_19_0._tempSkinId)
	arg_19_0._achievementCls:canOpen()
	arg_19_0._infoCls:canOpen()
end

function var_0_0.onClickCloseBottomView(arg_20_0)
	arg_20_0._bottomAnimator:Play("close")
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_enemy_move)

	if arg_20_0._tempSkinId and arg_20_0._tempSkinId ~= arg_20_0.skinId then
		arg_20_0:SwitchTheme(arg_20_0.skinId)

		arg_20_0._isreset = true
		arg_20_0._tempSkinId = nil

		gohelper.setActive(arg_20_0._goBottom, arg_20_0._openswitchskin)
	else
		gohelper.setActive(arg_20_0._goswitchskinreddot, arg_20_0:_isShowRedDot())
		TaskDispatcher.runDelay(arg_20_0.afterAnim, arg_20_0, 0.2)
	end

	PlayerCardModel.instance:setIsOpenSkinView(false)

	local var_20_0 = PlayerCardThemeListModel.instance:getMoById(arg_20_0.skinId)

	PlayerCardModel.instance:setSelectSkinMO(var_20_0)
	arg_20_0.skinpreviewcls:onHide()
	gohelper.setActive(arg_20_0._btnswitchskin.gameObject, not arg_20_0._openswitchskin)
end

function var_0_0.afterAnim(arg_21_0)
	gohelper.setActive(arg_21_0._goBottom, arg_21_0._openswitchskin)
end

function var_0_0.disposeView(arg_22_0)
	arg_22_0._achievementCls:onCloseInternal()
	arg_22_0._skinCls:onCloseInternal()
	arg_22_0._infoCls:onCloseInternal()
	arg_22_0._viewCls:onCloseInternal()

	if arg_22_0._oldViewGo then
		gohelper.destroy(arg_22_0._oldViewGo)

		arg_22_0._oldViewGo = nil
	end
end

function var_0_0.onClose(arg_23_0)
	arg_23_0:disposeView()
	TaskDispatcher.cancelTask(arg_23_0.afterOpenLoad, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.afterClose, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.closeLoading, arg_23_0)

	if arg_23_0._loader then
		arg_23_0._loader:dispose()

		arg_23_0._loader = nil
	end
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
