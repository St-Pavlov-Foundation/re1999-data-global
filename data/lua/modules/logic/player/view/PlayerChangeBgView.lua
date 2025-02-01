module("modules.logic.player.view.PlayerChangeBgView", package.seeall)

slot0 = class("PlayerChangeBgView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bgroot")
	slot0._goRoot = gohelper.findChild(slot0.viewGO, "root")
	slot0._goFriend = gohelper.findChild(slot0.viewGO, "root/#go_topright/#go_friend")
	slot0._btnFriend = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_topright/btn_friend")
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_topright/#go_friend/#go_item1/#txt_name")
	slot0._txtname2 = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_topright/#go_friend/#go_item2/#txt_name")
	slot0._txtonline = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_topright/#go_friend/#go_item1/#txt_online")
	slot0._txtLv = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_topright/#go_friend/#go_item1/headframe/bg/#txt_lv")
	slot0._txtLv2 = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_topright/#go_friend/#go_item2/#txt_lv")
	slot0._simagehead = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_topright/#go_friend/#go_item1/headframe/#simage_headicon")
	slot0._simagehead2 = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_topright/#go_friend/#go_item2/headframe/#simage_headicon")
	slot0._godefaultbg = gohelper.findChild(slot0.viewGO, "root/#go_topright/#go_friend/#go_item1/#go_bgdefault")
	slot0._godefaultbg2 = gohelper.findChild(slot0.viewGO, "root/#go_topright/#go_friend/#go_item2/#go_bgdefault")
	slot0._bg1 = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_topright/#go_friend/bg2")
	slot0._bg2 = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_topright/#go_friend/#go_item1/bg2")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnFriend:AddClickListener(slot0._showHideFriend, slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangeBgTab, slot0.onBgTabIndexChange, slot0)
	PlayerController.instance:registerCallback(PlayerEvent.ShowHideRoot, slot0.showHideRoot, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnFriend:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangeBgTab, slot0.onBgTabIndexChange, slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ShowHideRoot, slot0.showHideRoot, slot0)
end

function slot0._editableInitView(slot0)
	slot0._bgComp = MonoHelper.addLuaComOnceToGo(slot0._gobg, PlayerBgComp)
end

function slot0.onOpen(slot0)
	if (slot0.viewParam or {}).bgComp then
		gohelper.destroy(slot0._gobg)

		slot0._bgComp = slot1.bgComp

		slot0._bgComp.go.transform:SetParent(slot0.viewGO.transform, false)
		slot0._bgComp.go.transform:SetSiblingIndex(0)
	end

	slot2 = PlayerModel.instance:getPlayinfo()

	gohelper.setActive(slot0._goFriend, false)

	if slot0.viewParam and slot0.viewParam.itemMo then
		slot3 = PlayerConfig.instance:getBgCo(slot0.viewParam.itemMo.id)
		slot1.bgCo = slot3

		slot0:onSelectBg(slot3)
	else
		slot4 = 1

		for slot8 = 1, #lua_player_bg.configList do
			if slot3[slot8].item == slot2.bg then
				slot4 = slot8

				break
			end
		end

		slot1.bgCo = slot3[slot4]
		slot1.selectIndex = slot4
		slot0._selectIndex = slot4

		slot0:onSelectBg(slot3[slot4])
	end

	ViewMgr.instance:openView(ViewName.PlayerChangeBgListView, slot1)

	slot0._txtname.text = slot2.name
	slot0._txtname2.text = slot2.name
	slot0._txtonline.text = luaLang("social_online")
	slot0._txtLv.text = "Lv." .. slot2.level
	slot0._txtLv2.text = formatLuaLang("playerchangebgview_namelv", slot2.level)
	slot3 = slot2.portrait

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simagehead)
	end

	slot0._liveHeadIcon:setLiveHead(slot3)

	if not slot0._liveHeadIcon2 then
		slot0._liveHeadIcon2 = IconMgr.instance:getCommonLiveHeadIcon(slot0._simagehead2)
	end

	slot0._liveHeadIcon2:setLiveHead(slot3)
	slot0._anim:Play("open")
end

function slot0.onBgTabIndexChange(slot0, slot1)
	if slot1 ~= slot0._selectIndex then
		gohelper.setActive(slot0.viewGO, false)
		gohelper.setActive(slot0.viewGO, true)
		slot0._anim:Play("switch", 0, 0)
	end

	slot0._selectIndex = slot1

	UIBlockMgr.instance:startBlock("PlayerChangeBgView_switch")
	TaskDispatcher.runDelay(slot0._delayShowBg, slot0, 0.16)
end

function slot0._delayShowBg(slot0)
	UIBlockMgr.instance:endBlock("PlayerChangeBgView_switch")
	slot0:onSelectBg(lua_player_bg.configList[slot0._selectIndex])
end

function slot0.onSelectBg(slot0, slot1)
	slot0._bgComp:showBg(slot1)

	slot2 = true

	if slot1.item ~= 0 then
		slot2 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot1.item) > 0
	end

	gohelper.setActive(slot0._godefaultbg, slot1.item == 0)
	gohelper.setActive(slot0._godefaultbg2, slot1.item == 0)

	if slot1.item ~= 0 then
		slot0._bg1:LoadImage(string.format("singlebg/playerinfo/%s.png", slot1.infobg))
		slot0._bg2:LoadImage(string.format("singlebg/playerinfo/%s.png", slot1.chatbg))
	end
end

function slot0._showHideFriend(slot0)
	gohelper.setActive(slot0._goFriend, not slot0._goFriend.activeSelf)
end

function slot0.showHideRoot(slot0, slot1)
	if slot1 then
		slot0._anim:Play("open")
	else
		slot0._anim:Play("close")
	end
end

function slot0._onTouchScreen(slot0)
	if slot0._goFriend.activeSelf then
		slot1 = slot0._btnFriend.transform
		slot4 = recthelper.getHeight(slot1)

		if recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot1).x >= -recthelper.getWidth(slot1) / 2 and slot5.x <= slot3 / 2 and slot5.y <= slot4 / 2 and slot5.y >= -slot4 / 2 then
			return
		end

		gohelper.setActive(slot0._goFriend, false)
	end
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("PlayerChangeBgView_switch")
	slot0._anim:Play("close")
	ViewMgr.instance:closeView(ViewName.PlayerChangeBgListView)
	slot0._simagehead:UnLoadImage()
	slot0._simagehead2:UnLoadImage()
	slot0._bg1:UnLoadImage()
	slot0._bg2:UnLoadImage()
end

return slot0
