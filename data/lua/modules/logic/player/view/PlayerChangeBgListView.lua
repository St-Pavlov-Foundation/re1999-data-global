module("modules.logic.player.view.PlayerChangeBgListView", package.seeall)

local var_0_0 = class("PlayerChangeBgListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goRoot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/#btn_hide")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/bottom/#scroll_bg/Viewport/Content/#go_item")
	arg_1_0._goitemparent = arg_1_0._goitem.transform.parent.gameObject
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/bottom/#go_lock")
	arg_1_0._gocur = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/bottom/#go_curbg")
	arg_1_0._btnChange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bottom/bottom/#btn_change")
	arg_1_0._txtbgname = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_bottom/top/namebg/#txt_bgName")
	arg_1_0._txtbgdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_bottom/top/#txt_bgdesc")
	arg_1_0._gobglock = gohelper.findChild(arg_1_0.viewGO, "root/#go_bottom/top/#go_lock")
	arg_1_0._txtbglock = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_bottom/top/#go_lock/#txt_lock")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnHide:AddClickListener(arg_2_0._hideRoot, arg_2_0)
	arg_2_0._btnChange:AddClickListener(arg_2_0._changeBg, arg_2_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, arg_2_0._onTouchScreen, arg_2_0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangeBgTab, arg_2_0.onBgTabIndexChange, arg_2_0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, arg_2_0._onPlayerInfoChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnHide:RemoveClickListener()
	arg_3_0._btnChange:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, arg_3_0._onTouchScreen, arg_3_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangeBgTab, arg_3_0.onBgTabIndexChange, arg_3_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, arg_3_0._onPlayerInfoChange, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	PostProcessingMgr.instance:setBlurWeight(1)

	if arg_4_0.viewParam and arg_4_0.viewParam.itemMo then
		recthelper.setAnchorY(arg_4_0._gobottom.transform, -109)
		arg_4_0:onSelectBg(arg_4_0.viewParam.bgCo)
	else
		recthelper.setAnchorY(arg_4_0._gobottom.transform, 202)

		local var_4_0 = lua_player_bg.configList
		local var_4_1 = arg_4_0.viewParam.selectIndex

		arg_4_0._selectIndex = var_4_1

		arg_4_0:onSelectBg(var_4_0[var_4_1])
		gohelper.CreateObjList(arg_4_0, arg_4_0._createItem, var_4_0, arg_4_0._goitemparent, arg_4_0._goitem, PlayerChangeBgItem)
		arg_4_0:updateApplyStatus()
	end

	arg_4_0:playOpenAnim()
end

function var_0_0.updateApplyStatus(arg_5_0)
	if arg_5_0.viewParam and arg_5_0.viewParam.itemMo then
		return
	end

	local var_5_0 = lua_player_bg.configList[arg_5_0._selectIndex]

	if not var_5_0 then
		return
	end

	local var_5_1 = true
	local var_5_2 = PlayerModel.instance:getPlayinfo()

	if var_5_0.item ~= 0 then
		var_5_1 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, var_5_0.item) > 0
	end

	gohelper.setActive(arg_5_0._golock, not var_5_1)
	gohelper.setActive(arg_5_0._gocur, var_5_1 and var_5_2.bg == var_5_0.item)
	gohelper.setActive(arg_5_0._btnChange, var_5_1 and var_5_2.bg ~= var_5_0.item)
end

function var_0_0.onBgTabIndexChange(arg_6_0, arg_6_1)
	arg_6_0._selectIndex = arg_6_1

	arg_6_0:onSelectBg(lua_player_bg.configList[arg_6_1])
	arg_6_0:updateApplyStatus()
end

function var_0_0._onPlayerInfoChange(arg_7_0)
	arg_7_0:updateApplyStatus()
end

function var_0_0._changeBg(arg_8_0)
	local var_8_0 = lua_player_bg.configList[arg_8_0._selectIndex]

	if not var_8_0 then
		return
	end

	PlayerRpc.instance:sendSetPlayerBgRequest(var_8_0.item)
end

function var_0_0._createItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_1:initMo(arg_9_2, arg_9_3, arg_9_0._selectIndex)
end

function var_0_0.onSelectBg(arg_10_0, arg_10_1)
	local var_10_0 = true

	if arg_10_1.item ~= 0 then
		var_10_0 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, arg_10_1.item) > 0
	end

	arg_10_0._txtbgname.text = arg_10_1.name

	if var_10_0 then
		arg_10_0._txtbgdesc.text = arg_10_1.desc

		gohelper.setActive(arg_10_0._gobglock, false)
	else
		arg_10_0._txtbgdesc.text = ""
		arg_10_0._txtbglock.text = arg_10_1.lockdesc

		gohelper.setActive(arg_10_0._gobglock, true)
	end
end

function var_0_0.playOpenAnim(arg_11_0)
	if arg_11_0.viewParam and arg_11_0.viewParam.itemMo then
		arg_11_0._anim:Play("up")
	else
		arg_11_0._anim:Play("open")
	end
end

function var_0_0.playCloseAnim(arg_12_0)
	if arg_12_0.viewParam and arg_12_0.viewParam.itemMo then
		arg_12_0._anim:Play("down")
	else
		arg_12_0._anim:Play("close")
	end
end

function var_0_0._hideRoot(arg_13_0)
	arg_13_0._isHide = true

	arg_13_0:playCloseAnim()
	PlayerController.instance:dispatchEvent(PlayerEvent.ShowHideRoot, false)
end

function var_0_0._delayEndBlock(arg_14_0)
	UIBlockMgr.instance:endBlock("PlayerChangeBgListView_ShowRoot")
end

function var_0_0.onClose(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._delayEndBlock, arg_15_0)
	UIBlockMgr.instance:endBlock("PlayerChangeBgListView_ShowRoot")
end

function var_0_0._onTouchScreen(arg_16_0)
	if arg_16_0._isHide then
		TaskDispatcher.runDelay(arg_16_0._delayEndBlock, arg_16_0, 0.33)
		UIBlockMgr.instance:startBlock("PlayerChangeBgListView_ShowRoot")
		arg_16_0:playOpenAnim()
		PlayerController.instance:dispatchEvent(PlayerEvent.ShowHideRoot, true)
	end

	arg_16_0._isHide = false
end

return var_0_0
