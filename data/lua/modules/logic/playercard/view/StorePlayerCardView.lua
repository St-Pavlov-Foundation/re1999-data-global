module("modules.logic.playercard.view.StorePlayerCardView", package.seeall)

slot0 = class("StorePlayerCardView", NewPlayerCardView)

function slot0.onOpen(slot0, slot1)
	slot0._achievementCls = slot0._achievementCls or MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO, PlayerCardAchievement)
	slot0._achievementCls.viewParam = slot0.viewParam
	slot0._achievementCls.viewContainer = slot0.viewContainer

	slot0._achievementCls:onOpen()

	slot0._infoCls = slot0._infoCls or MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO, PlayerCardPlayerInfo)
	slot0._infoCls.viewParam = slot0.viewParam

	slot0._infoCls:onOpen()

	slot0._loader = slot0._loader or MultiAbLoader.New()
	slot0._socialitemPath = "ui/viewres/social/socialfrienditem.prefab"
	slot0._skinId = slot1

	if not slot0._socialitem then
		slot0._loader:addPath(slot0._socialitemPath)
		slot0._loader:startLoad(slot0._onLoadFinish, slot0)
	else
		slot0:_showSocialItem()
	end

	slot0.viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:_onOpen(slot1)
end

function slot0._onOpen(slot0, slot1)
	slot0._animator.enabled = true

	if slot0.viewParam and slot0.viewParam.userId then
		slot0.userId = slot0.viewParam.userId
	end

	slot0.playercardinfo = PlayerCardModel.instance:getCardInfo(slot0.userId)

	if (slot1 or slot0.playercardinfo:getThemeId()) == 0 or string.nilorempty(slot2) then
		slot2 = nil
	end

	slot0.themeId = slot2

	slot0:_creatBgEffect()

	slot3, slot4, slot5, slot6 = slot0.playercardinfo:getMainHero()

	slot0:_updateHero(slot3, slot4)
	slot0:_refreshProgress()
	slot0:_refreshBaseInfo()
	slot0:_initCritter()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

	slot0.progressopen = false
	slot0.baseinfoopen = false
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	transformhelper.setLocalScale(slot0._root.transform, 0.7, 0.7, 1)
	transformhelper.setLocalPosXY(slot0._root.transform, 0, 40)
end

function slot0._onLoadFinish(slot0)
	slot0._socialitem = gohelper.clone(slot0._loader:getAssetItem(slot0._socialitemPath):GetResource(slot0._socialitemPath), slot0.viewGO)
	slot0._socialfrienditemcls = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._socialitem, StorePlayerCardInfoItem)

	slot0:_showSocialItem()
end

function slot0._showSocialItem(slot0)
	if not slot0._socialitem or not slot0._socialfrienditemcls then
		return
	end

	slot1 = PlayerModel.instance:getPlayinfo()

	slot0._socialfrienditemcls:onUpdateMO({
		time = 0,
		userId = slot1.userId,
		name = slot1.name,
		level = slot1.level,
		portrait = slot1.portrait
	})
	slot0._socialfrienditemcls:selectSkin(slot0._skinId)
	transformhelper.setLocalScale(slot0._socialitem.transform, 0.75, 0.75, 1)
	transformhelper.setLocalPosXY(slot0._socialitem.transform, 730, 150)
end

function slot0._disposeLoader(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0.onShowDecorateStoreDefault(slot0)
	slot0:playAnim("open", 1)

	if slot0._socialfrienditemcls then
		slot0._socialfrienditemcls:onShowDecorateStoreDefault()
	end
end

function slot0.playAnim(slot0, slot1, slot2)
	if slot0.viewAnim then
		slot0.viewAnim:Play(slot1, 0, slot2)
	end
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
	slot0:_disposeLoader()
end

function slot0.onClose(slot0)
	slot0:resetSpine()
	slot0:removeEvents()

	slot0._has_onInitView = false

	if slot0._scrollView then
		slot0._scrollView:onDestroyViewInternal()
		slot0._scrollView:__onDispose()
	end

	gohelper.destroy(slot0.goskinpreview)

	slot0._scrollView = nil
end

return slot0
