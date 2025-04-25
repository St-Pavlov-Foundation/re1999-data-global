module("modules.logic.playercard.view.PlayerCardSkinPreView", package.seeall)

slot0 = class("PlayerCardSkinPreView", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._isopen = false

	slot0:onInitView()
	slot0:addEvents()
	slot0:initView()
end

function slot0.onInitView(slot0)
	slot0._btndetail = gohelper.findChildButton(slot0.viewGO, "#btn_detail")
	slot0._gosocialfrienditemnode = gohelper.findChild(slot0.viewGO, "#btn_detail/#go_socialfrienditem")
	slot0._gochat = gohelper.findChild(slot0.viewGO, "#go_chat")
	slot0._btnclose = gohelper.findChildButton(slot0.viewGO, "#go_chat/#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_chat/#simage_chatbg")
	slot0._goSkinbg = gohelper.findChild(slot0.viewGO, "#go_chat/#go_skinbg")

	gohelper.setActive(slot0._gochat, slot0._isopen)
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btndetail, slot0.onClickDetail, slot0)
	slot0:addClickCb(slot0._btnclose, slot0.onClickDetail, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, slot0.onSwitchView, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0._btndetail, slot0.onClickDetail, slot0)
	slot0:removeClickCb(slot0._btnclose, slot0.onClickDetail, slot0)
	slot0:removeEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, slot0.onSwitchView, slot0)
end

function slot0.onClickDetail(slot0)
	slot0._isopen = not slot0._isopen

	gohelper.setActive(slot0._gochat, slot0._isopen)
end

function slot0.initView(slot0)
	slot0._skinId = PlayerCardModel.instance:getPlayerCardSkinId()
	slot0._itemPath = "ui/viewres/social/socialfrienditem.prefab"
	slot0._loader = MultiAbLoader.New()

	if slot0._skinId and slot0._skinId ~= 0 then
		slot0._hasSkin = true
		slot0._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", slot0._skinId)

		slot0._loader:addPath(slot0._skinPath)
	else
		slot0._hasSkin = false
	end

	gohelper.setActive(slot0._goSkinbg, slot0._hasSkin)
	gohelper.setActive(slot0._simagebg.gameObject, not slot0._hasSkin)
	slot0._loader:addPath(slot0._itemPath)
	slot0._loader:startLoad(slot0._onLoadFinish, slot0)

	slot0._selectMo = PlayerCardModel.instance:getSelectSkinMO()
end

function slot0.switchSkin(slot0, slot1)
	gohelper.destroy(slot0._goskinEffect)

	slot0._switchskinloader = MultiAbLoader.New()

	if slot1 and slot1 ~= 0 then
		slot0._hasSkin = true
		slot0._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", slot1)

		slot0._loader:addPath(slot0._skinPath)
	else
		slot0._hasSkin = false
	end

	gohelper.setActive(slot0._simagebg.gameObject, not slot0._hasSkin)
	gohelper.setActive(slot0._goSkinbg, slot0._hasSkin)
	gohelper.setActive(slot0._gosocialfrienditem, false)
	slot0._switchskinloader:addPath(slot0._skinPath)
	slot0._switchskinloader:startLoad(slot0._onLoadSkinFinish, slot0)
end

function slot0._onLoadSkinFinish(slot0)
	slot0._goskinEffect = gohelper.clone(slot0._switchskinloader:getAssetItem(slot0._skinPath):GetResource(slot0._skinPath), slot0._goSkinbg)

	gohelper.setActive(slot0._gosocialfrienditem, true)
end

function slot0.updateBg(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSocialIcon("img_chat_bg.png"))
end

function slot0.updateItem(slot0)
	slot0._socialfrienditemcls:selectSkin(slot0._selectMo.id)
end

function slot0._onLoadFinish(slot0)
	if slot0._hasSkin then
		slot0._goskinEffect = gohelper.clone(slot0._loader:getAssetItem(slot0._skinPath):GetResource(slot0._skinPath), slot0._goSkinbg)
	end

	slot0._gosocialfrienditem = gohelper.clone(slot0._loader:getAssetItem(slot0._itemPath):GetResource(slot0._itemPath), slot0._gosocialfrienditemnode)
	slot0._socialfrienditemcls = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gosocialfrienditem, SocialFriendItem)
	slot3 = PlayerModel.instance:getPlayinfo()

	slot0._socialfrienditemcls:onUpdateMO({
		time = 0,
		userId = slot3.userId,
		name = slot3.name,
		level = slot3.level,
		portrait = slot3.portrait
	})
	slot0._socialfrienditemcls:selectSkin(PlayerCardModel.instance:getPlayerCardSkinId())
end

function slot0.onSwitchView(slot0, slot1)
	slot0._selectMo = PlayerCardModel.instance:getSelectSkinMO()

	if slot0._selectMo.id ~= 0 then
		gohelper.setActive(slot0._goSkinbg, true)
		gohelper.setActive(slot0._simagebg.gameObject, false)

		if slot0._selectMo.id ~= slot0._skinId then
			slot0._skinId = slot0._selectMo.id

			slot0:switchSkin(slot0._skinId)
			slot0._socialfrienditemcls:selectSkin(slot0._skinId)
		end
	else
		gohelper.setActive(slot0._goSkinbg, false)
		gohelper.setActive(slot0._simagebg.gameObject, true)
		slot0._socialfrienditemcls:selectSkin(slot0._selectMo.id)

		slot0._skinId = slot0._selectMo.id
	end
end

function slot0.onHide(slot0)
	slot1 = PlayerCardModel.instance:getPlayerCardSkinId()
	slot0._skinId = slot1

	slot0._socialfrienditemcls:selectSkin(slot1)
end

function slot0.onDestroy(slot0)
	slot0:removeEvents()

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	gohelper.destroy(slot0._gosocialfrienditem)
end

return slot0
