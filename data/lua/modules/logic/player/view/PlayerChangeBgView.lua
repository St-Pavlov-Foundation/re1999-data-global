module("modules.logic.player.view.PlayerChangeBgView", package.seeall)

local var_0_0 = class("PlayerChangeBgView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bgroot")
	arg_1_0._goRoot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._goFriend = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright/#go_friend")
	arg_1_0._btnFriend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_topright/btn_friend")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_topright/#go_friend/#go_item1/#txt_name")
	arg_1_0._txtname2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_topright/#go_friend/#go_item2/#txt_name")
	arg_1_0._txtonline = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_topright/#go_friend/#go_item1/#txt_online")
	arg_1_0._txtLv = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_topright/#go_friend/#go_item1/headframe/bg/#txt_lv")
	arg_1_0._txtLv2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_topright/#go_friend/#go_item2/#txt_lv")
	arg_1_0._simagehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_topright/#go_friend/#go_item1/headframe/#simage_headicon")
	arg_1_0._simagehead2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_topright/#go_friend/#go_item2/headframe/#simage_headicon")
	arg_1_0._godefaultbg = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright/#go_friend/#go_item1/#go_bgdefault")
	arg_1_0._godefaultbg2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright/#go_friend/#go_item2/#go_bgdefault")
	arg_1_0._bg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_topright/#go_friend/bg2")
	arg_1_0._bg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_topright/#go_friend/#go_item1/bg2")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnFriend:AddClickListener(arg_2_0._showHideFriend, arg_2_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, arg_2_0._onTouchScreen, arg_2_0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangeBgTab, arg_2_0.onBgTabIndexChange, arg_2_0)
	PlayerController.instance:registerCallback(PlayerEvent.ShowHideRoot, arg_2_0.showHideRoot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnFriend:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, arg_3_0._onTouchScreen, arg_3_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangeBgTab, arg_3_0.onBgTabIndexChange, arg_3_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ShowHideRoot, arg_3_0.showHideRoot, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._bgComp = MonoHelper.addLuaComOnceToGo(arg_4_0._gobg, PlayerBgComp)
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam or {}

	if var_5_0.bgComp then
		gohelper.destroy(arg_5_0._gobg)

		arg_5_0._bgComp = var_5_0.bgComp

		arg_5_0._bgComp.go.transform:SetParent(arg_5_0.viewGO.transform, false)
		arg_5_0._bgComp.go.transform:SetSiblingIndex(0)
	end

	local var_5_1 = PlayerModel.instance:getPlayinfo()

	gohelper.setActive(arg_5_0._goFriend, false)

	if arg_5_0.viewParam and arg_5_0.viewParam.itemMo then
		local var_5_2 = PlayerConfig.instance:getBgCo(arg_5_0.viewParam.itemMo.id)

		var_5_0.bgCo = var_5_2

		arg_5_0:onSelectBg(var_5_2)
	else
		local var_5_3 = lua_player_bg.configList
		local var_5_4 = 1

		for iter_5_0 = 1, #var_5_3 do
			if var_5_3[iter_5_0].item == var_5_1.bg then
				var_5_4 = iter_5_0

				break
			end
		end

		var_5_0.bgCo = var_5_3[var_5_4]
		var_5_0.selectIndex = var_5_4
		arg_5_0._selectIndex = var_5_4

		arg_5_0:onSelectBg(var_5_3[var_5_4])
	end

	ViewMgr.instance:openView(ViewName.PlayerChangeBgListView, var_5_0)

	arg_5_0._txtname.text = var_5_1.name
	arg_5_0._txtname2.text = var_5_1.name
	arg_5_0._txtonline.text = luaLang("social_online")
	arg_5_0._txtLv.text = "Lv." .. var_5_1.level
	arg_5_0._txtLv2.text = formatLuaLang("playerchangebgview_namelv", var_5_1.level)

	local var_5_5 = var_5_1.portrait

	if not arg_5_0._liveHeadIcon then
		arg_5_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_5_0._simagehead)
	end

	arg_5_0._liveHeadIcon:setLiveHead(var_5_5)

	if not arg_5_0._liveHeadIcon2 then
		arg_5_0._liveHeadIcon2 = IconMgr.instance:getCommonLiveHeadIcon(arg_5_0._simagehead2)
	end

	arg_5_0._liveHeadIcon2:setLiveHead(var_5_5)
	arg_5_0._anim:Play("open")
end

function var_0_0.onBgTabIndexChange(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0._selectIndex then
		gohelper.setActive(arg_6_0.viewGO, false)
		gohelper.setActive(arg_6_0.viewGO, true)
		arg_6_0._anim:Play("switch", 0, 0)
	end

	arg_6_0._selectIndex = arg_6_1

	UIBlockMgr.instance:startBlock("PlayerChangeBgView_switch")
	TaskDispatcher.runDelay(arg_6_0._delayShowBg, arg_6_0, 0.16)
end

function var_0_0._delayShowBg(arg_7_0)
	UIBlockMgr.instance:endBlock("PlayerChangeBgView_switch")
	arg_7_0:onSelectBg(lua_player_bg.configList[arg_7_0._selectIndex])
end

function var_0_0.onSelectBg(arg_8_0, arg_8_1)
	arg_8_0._bgComp:showBg(arg_8_1)

	local var_8_0 = true

	if arg_8_1.item ~= 0 then
		local var_8_1

		var_8_1 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, arg_8_1.item) > 0
	end

	gohelper.setActive(arg_8_0._godefaultbg, arg_8_1.item == 0)
	gohelper.setActive(arg_8_0._godefaultbg2, arg_8_1.item == 0)

	if arg_8_1.item ~= 0 then
		arg_8_0._bg1:LoadImage(string.format("singlebg/playerinfo/%s.png", arg_8_1.infobg))
		arg_8_0._bg2:LoadImage(string.format("singlebg/playerinfo/%s.png", arg_8_1.chatbg))
	end
end

function var_0_0._showHideFriend(arg_9_0)
	gohelper.setActive(arg_9_0._goFriend, not arg_9_0._goFriend.activeSelf)
end

function var_0_0.showHideRoot(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0._anim:Play("open")
	else
		arg_10_0._anim:Play("close")
	end
end

function var_0_0._onTouchScreen(arg_11_0)
	if arg_11_0._goFriend.activeSelf then
		local var_11_0 = arg_11_0._btnFriend.transform
		local var_11_1 = GamepadController.instance:getMousePosition()
		local var_11_2 = recthelper.getWidth(var_11_0)
		local var_11_3 = recthelper.getHeight(var_11_0)
		local var_11_4 = recthelper.screenPosToAnchorPos(var_11_1, var_11_0)

		if var_11_4.x >= -var_11_2 / 2 and var_11_4.x <= var_11_2 / 2 and var_11_4.y <= var_11_3 / 2 and var_11_4.y >= -var_11_3 / 2 then
			return
		end

		gohelper.setActive(arg_11_0._goFriend, false)
	end
end

function var_0_0.onClose(arg_12_0)
	UIBlockMgr.instance:endBlock("PlayerChangeBgView_switch")
	arg_12_0._anim:Play("close")
	ViewMgr.instance:closeView(ViewName.PlayerChangeBgListView)
	arg_12_0._simagehead:UnLoadImage()
	arg_12_0._simagehead2:UnLoadImage()
	arg_12_0._bg1:UnLoadImage()
	arg_12_0._bg2:UnLoadImage()
end

return var_0_0
