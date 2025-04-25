module("modules.logic.playercard.view.NewPlayerCardContentView", package.seeall)

slot0 = class("NewPlayerCardContentView", BaseView)

function slot0.onInitView(slot0)
	slot0._goContent = gohelper.findChild(slot0.viewGO, "view")
	slot0._goLoading = gohelper.findChild(slot0.viewGO, "loadingmainview")
	slot0._loadAnim = slot0._goLoading:GetComponent(typeof(UnityEngine.Animator))
	slot0._goBottom = gohelper.findChild(slot0.viewGO, "bottom")
	slot0._btnbottomclose = gohelper.findChildButton(slot0.viewGO, "bottom/#btn_bottomclose")
	slot0._goskinpreviewnode = gohelper.findChild(slot0.viewGO, "bottom/#go_skinpreview")
	slot0._btnswitchskin = gohelper.findChildButton(slot0.viewGO, "#btn_switch")
	slot0._openswitchskin = false
	slot0._firstopen = true
	slot0._bottomAnimator = slot0._goBottom:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbottomclose:AddClickListener(slot0._btnswitchskinOnClick, slot0)
	slot0._btnswitchskin:AddClickListener(slot0._btnswitchskinOnClick, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, slot0.SwitchTheme, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ChangeSkin, slot0.ChangeSkin, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbottomclose:RemoveClickListener()
	slot0._btnswitchskin:RemoveClickListener()
	slot0:removeEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, slot0.SwitchTheme, slot0)
	slot0:removeEventCb(PlayerCardController.instance, PlayerCardEvent.ChangeSkin, slot0.ChangeSkin, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewParam and slot0.viewParam.userId then
		slot0.userId = slot0.viewParam.userId
	end

	slot0.playercardinfo = PlayerCardModel.instance:getCardInfo(slot0.userId)

	gohelper.setActive(slot0._goBottom, slot0._openswitchskin)
	gohelper.setActive(slot0._btnswitchskin.gameObject, slot0.playercardinfo:isSelf())

	slot0.skinId = slot0.playercardinfo:getThemeId()

	slot0:loadRes(slot0.skinId)
	slot0:_initSkinPreView()
end

function slot0._initSkinPreView(slot0)
	slot0.goskinpreview = gohelper.clone(slot0.viewContainer:getRes(slot0.viewContainer:getSetting().otherRes.skinpreview), slot0._goskinpreviewnode)
	slot0.skinpreviewcls = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goskinpreview, PlayerCardSkinPreView)
	slot0._skinCls = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO, PlayerCardThemeView)
	slot0._skinCls.viewParam = slot0.viewParam

	slot0._skinCls:canOpen()
end

function slot0.loadRes(slot0, slot1)
	if not string.nilorempty(slot1) and slot1 ~= 0 then
		slot2 = "playercardview" .. "_" .. slot1
	end

	slot0._path = string.format("ui/viewres/player/playercard/%s.prefab", slot2)
	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(slot0._path)
	slot0._loader:startLoad(slot0._onLoadFinish, slot0)
end

function slot0._onLoadFinish(slot0)
	slot0._viewGo = gohelper.clone(slot0._loader:getAssetItem(slot0._path):GetResource(slot0._path), slot0._goContent)
	slot0._viewCls = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._viewGo, NewPlayerCardView)
	slot0._achievementCls = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._viewGo, PlayerCardAchievement)
	slot0._infoCls = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._viewGo, PlayerCardPlayerInfo)
	slot0._viewCls.viewParam = slot0.viewParam
	slot0._viewCls.viewContainer = slot0.viewContainer
	slot0._viewCls.contentview = slot0
	slot0._achievementCls.viewParam = slot0.viewParam
	slot0._achievementCls.viewContainer = slot0.viewContainer
	slot0._infoCls.viewParam = slot0.viewParam

	if slot0._changeSkin then
		slot0:closeLoading()
	end

	if slot0._tempSkinId then
		slot0._viewCls:toBottomView()
	else
		slot0:closeLoading()

		if not slot0._firstopen then
			slot0._viewCls:backBottomView()
		end
	end

	slot0._firstopen = false
end

function slot0.afterOpenAnim(slot0)
	slot0._viewCls:toBottomView()
end

function slot0._btnswitchskinOnClick(slot0)
	if slot0.playercardinfo:isSelf() then
		slot0._openswitchskin = not slot0._openswitchskin

		if not slot0._openswitchskin then
			slot0:onClickCloseBottomView()
			slot0._viewCls:backBottomView()
		else
			gohelper.setActive(slot0._goBottom, slot0._openswitchskin)
			gohelper.setActive(slot0._btnswitchskin.gameObject, not slot0._openswitchskin)
		end

		if slot0._openswitchskin then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_move)
			slot0._viewCls:toBottomView()
			PlayerCardModel.instance:setIsOpenSkinView(true)
			PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ShowTheme)
		end
	end
end

function slot0.closeLoading(slot0)
	slot0:checkCanOpen()
	slot0._loadAnim:Play("close")
	TaskDispatcher.runDelay(slot0.afterClose, slot0, 0.3)
end

function slot0.afterClose(slot0)
	TaskDispatcher.cancelTask(slot0.afterClose, slot0)
	gohelper.setActive(slot0._goLoading, false)

	slot0._changeSkin = false

	UIBlockMgr.instance:endBlock("NewPlayerCardContentView")
end

function slot0.SwitchTheme(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._tempSkinId and slot1 == slot0.skinId then
		return
	end

	if slot0._tempSkinId == slot1 then
		return
	end

	slot0._tempSkinId = slot1

	if not slot0._oldViewGo then
		slot0._oldViewGo = slot0._viewGo
	end

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0._changeSkin = true

	gohelper.setActive(slot0._goLoading, true)
	UIBlockMgr.instance:startBlock("NewPlayerCardContentView")
	TaskDispatcher.runDelay(slot0.afterOpenLoad, slot0, 0.3)
end

function slot0.afterOpenLoad(slot0)
	TaskDispatcher.cancelTask(slot0.afterOpenLoad, slot0)
	slot0:disposeView()

	if slot0._isreset and not slot0._tempSkinId then
		slot0:loadRes(slot0.skinId)
	else
		slot0:loadRes(slot0._tempSkinId)
	end
end

function slot0.ChangeSkin(slot0, slot1)
	slot0._tempSkinId = nil
	slot0.skinId = slot1
end

function slot0.getCurrentView(slot0)
	return slot0._viewCls
end

function slot0.checkCanOpen(slot0)
	slot0._viewCls:canOpen(slot0._tempSkinId)
	slot0._achievementCls:canOpen()
	slot0._infoCls:canOpen()
end

function slot0.onClickCloseBottomView(slot0)
	slot0._bottomAnimator:Play("close")
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_enemy_move)

	if slot0._tempSkinId and slot0._tempSkinId ~= slot0.skinId then
		slot0:SwitchTheme(slot0.skinId)

		slot0._isreset = true
		slot0._tempSkinId = nil

		gohelper.setActive(slot0._goBottom, slot0._openswitchskin)
	else
		TaskDispatcher.runDelay(slot0.afterAnim, slot0, 0.2)
	end

	PlayerCardModel.instance:setIsOpenSkinView(false)
	PlayerCardModel.instance:setSelectSkinMO(PlayerCardThemeListModel.instance:getMoById(slot0.skinId))
	slot0.skinpreviewcls:onHide()
	gohelper.setActive(slot0._btnswitchskin.gameObject, not slot0._openswitchskin)
end

function slot0.afterAnim(slot0)
	gohelper.setActive(slot0._goBottom, slot0._openswitchskin)
end

function slot0.disposeView(slot0)
	slot0._achievementCls:onCloseInternal()
	slot0._skinCls:onCloseInternal()
	slot0._infoCls:onCloseInternal()
	slot0._viewCls:onCloseInternal()

	if slot0._oldViewGo then
		gohelper.destroy(slot0._oldViewGo)

		slot0._oldViewGo = nil
	end
end

function slot0.onClose(slot0)
	slot0:disposeView()
	TaskDispatcher.cancelTask(slot0.afterOpenLoad, slot0)
	TaskDispatcher.cancelTask(slot0.afterClose, slot0)
	TaskDispatcher.cancelTask(slot0.closeLoading, slot0)

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
