module("modules.logic.player.view.PlayerChangeBgListView", package.seeall)

slot0 = class("PlayerChangeBgListView", BaseView)

function slot0.onInitView(slot0)
	slot0._goRoot = gohelper.findChild(slot0.viewGO, "root")
	slot0._btnHide = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_bottom/#btn_hide")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "root/#go_bottom")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "root/#go_bottom/bottom/#scroll_bg/Viewport/Content/#go_item")
	slot0._goitemparent = slot0._goitem.transform.parent.gameObject
	slot0._golock = gohelper.findChild(slot0.viewGO, "root/#go_bottom/bottom/#go_lock")
	slot0._gocur = gohelper.findChild(slot0.viewGO, "root/#go_bottom/bottom/#go_curbg")
	slot0._btnChange = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_bottom/bottom/#btn_change")
	slot0._txtbgname = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_bottom/top/namebg/#txt_bgName")
	slot0._txtbgdesc = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_bottom/top/#txt_bgdesc")
	slot0._gobglock = gohelper.findChild(slot0.viewGO, "root/#go_bottom/top/#go_lock")
	slot0._txtbglock = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_bottom/top/#go_lock/#txt_lock")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEvents(slot0)
	slot0._btnHide:AddClickListener(slot0._hideRoot, slot0)
	slot0._btnChange:AddClickListener(slot0._changeBg, slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangeBgTab, slot0.onBgTabIndexChange, slot0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, slot0._onPlayerInfoChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnHide:RemoveClickListener()
	slot0._btnChange:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangeBgTab, slot0.onBgTabIndexChange, slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, slot0._onPlayerInfoChange, slot0)
end

function slot0.onOpen(slot0)
	PostProcessingMgr.instance:setBlurWeight(1)

	if slot0.viewParam and slot0.viewParam.itemMo then
		recthelper.setAnchorY(slot0._gobottom.transform, -109)
		slot0:onSelectBg(slot0.viewParam.bgCo)
	else
		recthelper.setAnchorY(slot0._gobottom.transform, 202)

		slot1 = lua_player_bg.configList
		slot2 = slot0.viewParam.selectIndex
		slot0._selectIndex = slot2

		slot0:onSelectBg(slot1[slot2])
		gohelper.CreateObjList(slot0, slot0._createItem, slot1, slot0._goitemparent, slot0._goitem, PlayerChangeBgItem)
		slot0:updateApplyStatus()
	end

	slot0:playOpenAnim()
end

function slot0.updateApplyStatus(slot0)
	if slot0.viewParam and slot0.viewParam.itemMo then
		return
	end

	if not lua_player_bg.configList[slot0._selectIndex] then
		return
	end

	slot2 = true
	slot3 = PlayerModel.instance:getPlayinfo()

	if slot1.item ~= 0 then
		slot2 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot1.item) > 0
	end

	gohelper.setActive(slot0._golock, not slot2)
	gohelper.setActive(slot0._gocur, slot2 and slot3.bg == slot1.item)
	gohelper.setActive(slot0._btnChange, slot2 and slot3.bg ~= slot1.item)
end

function slot0.onBgTabIndexChange(slot0, slot1)
	slot0._selectIndex = slot1

	slot0:onSelectBg(lua_player_bg.configList[slot1])
	slot0:updateApplyStatus()
end

function slot0._onPlayerInfoChange(slot0)
	slot0:updateApplyStatus()
end

function slot0._changeBg(slot0)
	if not lua_player_bg.configList[slot0._selectIndex] then
		return
	end

	PlayerRpc.instance:sendSetPlayerBgRequest(slot1.item)
end

function slot0._createItem(slot0, slot1, slot2, slot3)
	slot1:initMo(slot2, slot3, slot0._selectIndex)
end

function slot0.onSelectBg(slot0, slot1)
	slot2 = true

	if slot1.item ~= 0 then
		slot2 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot1.item) > 0
	end

	slot0._txtbgname.text = slot1.name

	if slot2 then
		slot0._txtbgdesc.text = slot1.desc

		gohelper.setActive(slot0._gobglock, false)
	else
		slot0._txtbgdesc.text = ""
		slot0._txtbglock.text = slot1.lockdesc

		gohelper.setActive(slot0._gobglock, true)
	end
end

function slot0.playOpenAnim(slot0)
	if slot0.viewParam and slot0.viewParam.itemMo then
		slot0._anim:Play("up")
	else
		slot0._anim:Play("open")
	end
end

function slot0.playCloseAnim(slot0)
	if slot0.viewParam and slot0.viewParam.itemMo then
		slot0._anim:Play("down")
	else
		slot0._anim:Play("close")
	end
end

function slot0._hideRoot(slot0)
	slot0._isHide = true

	slot0:playCloseAnim()
	PlayerController.instance:dispatchEvent(PlayerEvent.ShowHideRoot, false)
end

function slot0._delayEndBlock(slot0)
	UIBlockMgr.instance:endBlock("PlayerChangeBgListView_ShowRoot")
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayEndBlock, slot0)
	UIBlockMgr.instance:endBlock("PlayerChangeBgListView_ShowRoot")
end

function slot0._onTouchScreen(slot0)
	if slot0._isHide then
		TaskDispatcher.runDelay(slot0._delayEndBlock, slot0, 0.33)
		UIBlockMgr.instance:startBlock("PlayerChangeBgListView_ShowRoot")
		slot0:playOpenAnim()
		PlayerController.instance:dispatchEvent(PlayerEvent.ShowHideRoot, true)
	end

	slot0._isHide = false
end

return slot0
