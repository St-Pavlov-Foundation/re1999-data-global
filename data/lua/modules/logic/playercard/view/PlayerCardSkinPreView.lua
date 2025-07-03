module("modules.logic.playercard.view.PlayerCardSkinPreView", package.seeall)

local var_0_0 = class("PlayerCardSkinPreView", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._isopen = false

	arg_1_0:onInitView()
	arg_1_0:addEvents()
	arg_1_0:initView()
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btndetail = gohelper.findChildButton(arg_2_0.viewGO, "#btn_detail")
	arg_2_0._gosocialfrienditemnode = gohelper.findChild(arg_2_0.viewGO, "#btn_detail/#go_socialfrienditem")
	arg_2_0._gochat = gohelper.findChild(arg_2_0.viewGO, "#go_chat")
	arg_2_0._btnclose = gohelper.findChildButton(arg_2_0.viewGO, "#go_chat/#btn_close")
	arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_0.viewGO, "#go_chat/#simage_chatbg")
	arg_2_0._gobg = gohelper.findChild(arg_2_0.viewGO, "#go_chat/#simage_chatbg")
	arg_2_0._goSkinbg = gohelper.findChild(arg_2_0.viewGO, "#go_chat/#go_skinbg")

	gohelper.setActive(arg_2_0._gochat, arg_2_0._isopen)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btndetail, arg_3_0.onClickDetail, arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnclose, arg_3_0.onClickDetail, arg_3_0)
	arg_3_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, arg_3_0.onSwitchView, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeClickCb(arg_4_0._btndetail, arg_4_0.onClickDetail, arg_4_0)
	arg_4_0:removeClickCb(arg_4_0._btnclose, arg_4_0.onClickDetail, arg_4_0)
	arg_4_0:removeEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, arg_4_0.onSwitchView, arg_4_0)
end

function var_0_0.onClickDetail(arg_5_0)
	arg_5_0._isopen = not arg_5_0._isopen

	gohelper.setActive(arg_5_0._gochat, arg_5_0._isopen)
end

function var_0_0.initView(arg_6_0)
	arg_6_0._skinId = PlayerCardModel.instance:getPlayerCardSkinId()
	arg_6_0._itemPath = "ui/viewres/social/socialfrienditem.prefab"
	arg_6_0._loader = MultiAbLoader.New()

	if arg_6_0._skinId and arg_6_0._skinId ~= 0 then
		arg_6_0._hasSkin = true
		arg_6_0._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", arg_6_0._skinId)

		arg_6_0._loader:addPath(arg_6_0._skinPath)
	else
		arg_6_0._hasSkin = false
	end

	gohelper.setActive(arg_6_0._goSkinbg, arg_6_0._hasSkin)
	gohelper.setActive(arg_6_0._gobg, not arg_6_0._hasSkin)
	arg_6_0._loader:addPath(arg_6_0._itemPath)
	arg_6_0._loader:startLoad(arg_6_0._onLoadFinish, arg_6_0)

	arg_6_0._selectMo = PlayerCardModel.instance:getSelectSkinMO()
end

function var_0_0.switchSkin(arg_7_0, arg_7_1)
	gohelper.destroy(arg_7_0._goskinEffect)

	arg_7_0._switchskinloader = MultiAbLoader.New()

	if arg_7_1 and arg_7_1 ~= 0 then
		arg_7_0._hasSkin = true
		arg_7_0._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", arg_7_1)

		arg_7_0._loader:addPath(arg_7_0._skinPath)
	else
		arg_7_0._hasSkin = false
	end

	gohelper.setActive(arg_7_0._gobg, not arg_7_0._hasSkin)
	gohelper.setActive(arg_7_0._goSkinbg, arg_7_0._hasSkin)
	gohelper.setActive(arg_7_0._gosocialfrienditem, false)
	arg_7_0._switchskinloader:addPath(arg_7_0._skinPath)
	arg_7_0._switchskinloader:startLoad(arg_7_0._onLoadSkinFinish, arg_7_0)
end

function var_0_0._onLoadSkinFinish(arg_8_0)
	local var_8_0 = arg_8_0._switchskinloader:getAssetItem(arg_8_0._skinPath):GetResource(arg_8_0._skinPath)

	arg_8_0._goskinEffect = gohelper.clone(var_8_0, arg_8_0._goSkinbg)

	gohelper.setActive(arg_8_0._gosocialfrienditem, true)
end

function var_0_0.updateBg(arg_9_0)
	local var_9_0 = "img_chat_bg.png"

	arg_9_0._simagebg:LoadImage(ResUrl.getSocialIcon(var_9_0))
end

function var_0_0.updateItem(arg_10_0)
	arg_10_0._socialfrienditemcls:selectSkin(arg_10_0._selectMo.id)
end

function var_0_0._onLoadFinish(arg_11_0)
	if arg_11_0._hasSkin then
		local var_11_0 = arg_11_0._loader:getAssetItem(arg_11_0._skinPath):GetResource(arg_11_0._skinPath)

		arg_11_0._goskinEffect = gohelper.clone(var_11_0, arg_11_0._goSkinbg)
	end

	local var_11_1 = arg_11_0._loader:getAssetItem(arg_11_0._itemPath):GetResource(arg_11_0._itemPath)

	arg_11_0._gosocialfrienditem = gohelper.clone(var_11_1, arg_11_0._gosocialfrienditemnode)
	arg_11_0._socialfrienditemcls = MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._gosocialfrienditem, SocialFriendItem)

	local var_11_2 = PlayerModel.instance:getPlayinfo()
	local var_11_3 = {
		time = 0,
		userId = var_11_2.userId,
		name = var_11_2.name,
		level = var_11_2.level,
		portrait = var_11_2.portrait
	}
	local var_11_4 = PlayerCardModel.instance:getPlayerCardSkinId()

	arg_11_0._socialfrienditemcls:onUpdateMO(var_11_3)
	arg_11_0._socialfrienditemcls:selectSkin(var_11_4)
end

function var_0_0.onSwitchView(arg_12_0, arg_12_1)
	arg_12_0._selectMo = PlayerCardModel.instance:getSelectSkinMO()

	if arg_12_0._selectMo.id ~= 0 then
		gohelper.setActive(arg_12_0._goSkinbg, true)
		gohelper.setActive(arg_12_0._gobg, false)

		if arg_12_0._selectMo.id ~= arg_12_0._skinId then
			arg_12_0._skinId = arg_12_0._selectMo.id

			arg_12_0:switchSkin(arg_12_0._skinId)
			arg_12_0._socialfrienditemcls:selectSkin(arg_12_0._skinId)
		end
	else
		gohelper.setActive(arg_12_0._goSkinbg, false)
		gohelper.setActive(arg_12_0._gobg, true)
		arg_12_0._socialfrienditemcls:selectSkin(arg_12_0._selectMo.id)

		arg_12_0._skinId = arg_12_0._selectMo.id
	end
end

function var_0_0.onHide(arg_13_0)
	local var_13_0 = PlayerCardModel.instance:getPlayerCardSkinId()

	if arg_13_0._skinId ~= var_13_0 then
		arg_13_0:switchSkin(var_13_0)

		arg_13_0._skinId = var_13_0
	end

	arg_13_0._socialfrienditemcls:selectSkin(var_13_0)
end

function var_0_0.onDestroy(arg_14_0)
	arg_14_0:removeEvents()

	if arg_14_0._loader then
		arg_14_0._loader:dispose()

		arg_14_0._loader = nil
	end

	gohelper.destroy(arg_14_0._gosocialfrienditem)
end

return var_0_0
