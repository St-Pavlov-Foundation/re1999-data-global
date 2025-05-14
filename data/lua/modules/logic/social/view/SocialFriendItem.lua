module("modules.logic.social.view.SocialFriendItem", package.seeall)

local var_0_0 = class("SocialFriendItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._goskinbg = gohelper.findChild(arg_1_0.viewGO, "#go_skinbg")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_bg")
	arg_1_0._imagegobg = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/#go_bg")
	arg_1_0._gobgselect = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_bgselect")
	arg_1_0._imagegoselectbg = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/#go_bgselect")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goplayericon = gohelper.findChild(arg_1_0.viewGO, "#go_playericon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "name/#txt_name")
	arg_1_0._txtnameoffline = gohelper.findChildText(arg_1_0.viewGO, "name/#txt_nameoffline")
	arg_1_0._txtstatus = gohelper.findChildText(arg_1_0.viewGO, "status/#txt_status")
	arg_1_0._txtofflinetime = gohelper.findChildText(arg_1_0.viewGO, "status/#txt_offlinetime")
	arg_1_0._friendreddot = gohelper.findChild(arg_1_0.viewGO, "#go_friendreddot")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	SocialModel.instance:setSelectFriend(arg_4_0._mo.userId)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._playericon = IconMgr.instance:getCommonPlayerIcon(arg_5_0._goplayericon)

	arg_5_0:addEventCb(SocialController.instance, SocialEvent.SelectFriend, arg_5_0._onFriendSelect, arg_5_0)
	arg_5_0:addEventCb(SocialController.instance, SocialEvent.FriendDescChange, arg_5_0.updateName, arg_5_0)
end

function var_0_0._refreshUI(arg_6_0)
	arg_6_0._playericon:onUpdateMO(arg_6_0._mo)
	arg_6_0._playericon:setShowLevel(true)

	local var_6_0 = arg_6_0:_isSelectFriend()

	arg_6_0._playericon:isSelectInFriend(var_6_0)

	if RedDotModel.instance:getDotInfo(RedDotEnum.DotNode.FriendInfoDetail, tonumber(arg_6_0._mo.userId)) then
		RedDotController.instance:addRedDot(arg_6_0._friendreddot, RedDotEnum.DotNode.FriendInfoDetail, tonumber(arg_6_0._mo.userId))
	end

	gohelper.setActive(arg_6_0._txtstatus.gameObject, tonumber(arg_6_0._mo.time) == 0)
	gohelper.setActive(arg_6_0._txtofflinetime.gameObject, tonumber(arg_6_0._mo.time) ~= 0)
	gohelper.setActive(arg_6_0._txtname.gameObject, tonumber(arg_6_0._mo.time) == 0)
	gohelper.setActive(arg_6_0._txtnameoffline.gameObject, tonumber(arg_6_0._mo.time) ~= 0)
	arg_6_0._playericon:setPlayerIconGray(tonumber(arg_6_0._mo.time) ~= 0)

	if tonumber(arg_6_0._mo.time) ~= 0 then
		arg_6_0._txtofflinetime.text = SocialConfig.instance:getStatusText(arg_6_0._mo.time)
	end

	arg_6_0:updateName()

	arg_6_0._txtstatus.text = luaLang("social_online")

	arg_6_0:_loadBg(arg_6_0._mo.bg)
	arg_6_0:_onFriendSelect()
end

function var_0_0._loadBg(arg_7_0, arg_7_1)
	if not arg_7_1 or arg_7_1 == 0 then
		arg_7_0._hasSkin = false
	else
		arg_7_0._hasSkin = true

		if not arg_7_0.lastskinId or arg_7_0.lastskinId ~= arg_7_1 then
			arg_7_0._skinPath = string.format("ui/viewres/social/socialfrienditem_bg_%s.prefab", arg_7_1)

			arg_7_0:_disposeBg()

			arg_7_0._loader = MultiAbLoader.New()

			arg_7_0._loader:addPath(arg_7_0._skinPath)
			arg_7_0._loader:startLoad(arg_7_0._onLoadFinish, arg_7_0)
		end
	end

	gohelper.setActive(arg_7_0._gonormal, not arg_7_0._hasSkin)
	gohelper.setActive(arg_7_0._goskinbg, arg_7_0._hasSkin)
end

function var_0_0._disposeBg(arg_8_0)
	if arg_8_0._loader then
		arg_8_0._loader:dispose()

		arg_8_0._loader = nil
	end

	if arg_8_0._goskinEffect then
		gohelper.destroy(arg_8_0._goskinEffect)

		arg_8_0._goskinEffect = nil
	end
end

function var_0_0._onLoadFinish(arg_9_0)
	local var_9_0 = arg_9_0._loader:getAssetItem(arg_9_0._skinPath):GetResource(arg_9_0._skinPath)

	arg_9_0._goskinEffect = gohelper.clone(var_9_0, arg_9_0._goskinbg)
	arg_9_0.lastskinId = arg_9_0._mo.bg
end

function var_0_0.setBgState(arg_10_0, arg_10_1)
	local var_10_0 = gohelper.findChild(arg_10_1, "online")
	local var_10_1 = gohelper.findChild(arg_10_1, "offline")

	if not arg_10_0._isplaycard then
		local var_10_2 = arg_10_0:_isSelectFriend()

		gohelper.setActive(var_10_1, not var_10_2)
		gohelper.setActive(var_10_0, var_10_2)
	else
		gohelper.setActive(var_10_1, false)
		gohelper.setActive(var_10_0, true)
	end
end

function var_0_0.selectSkin(arg_11_0, arg_11_1)
	arg_11_0._isplaycard = true

	arg_11_0:_loadBg(arg_11_1)
end

function var_0_0.updateName(arg_12_0, arg_12_1)
	if arg_12_1 and arg_12_1 ~= arg_12_0._mo.id then
		return
	end

	local var_12_0 = arg_12_0._mo and arg_12_0._mo.name or ""

	if arg_12_0:_isSelectFriend() then
		if not string.nilorempty(arg_12_0._mo.desc) then
			arg_12_0._txtname.text = "<size=32><color=#c66030>" .. var_12_0 .. "<color=#5c574d>(" .. arg_12_0._mo.desc .. ")"
			arg_12_0._txtnameoffline.text = "<size=32><color=#c66030>" .. var_12_0 .. "<color=#5c574d>(" .. arg_12_0._mo.desc .. ")"
		else
			arg_12_0._txtname.text = "<size=38><color=#c66030>" .. var_12_0
			arg_12_0._txtnameoffline.text = "<size=38><color=#222222>" .. var_12_0
		end

		arg_12_0._txtstatus.text = "<color=#56A165>" .. arg_12_0._txtstatus.text
	else
		if not string.nilorempty(arg_12_0._mo.desc) then
			arg_12_0._txtname.text = "<size=32><color=#404040>" .. var_12_0 .. "<color=#5c574d>(" .. arg_12_0._mo.desc .. ")"
			arg_12_0._txtnameoffline.text = "<size=32><color=#222222>" .. var_12_0 .. "<color=#5c574d>(" .. arg_12_0._mo.desc .. ")"
		else
			arg_12_0._txtname.text = "<size=38><color=#404040>" .. var_12_0
			arg_12_0._txtnameoffline.text = "<size=38><color=#222222>" .. var_12_0
		end

		arg_12_0._txtstatus.text = "<color=#4E7656>" .. arg_12_0._txtstatus.text
	end
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1)
	arg_13_0._mo = arg_13_1

	arg_13_0:_refreshUI()
end

local var_0_1 = Color.New(1, 1, 1, 1)
local var_0_2 = Color.New(1, 1, 1, 0.7)

function var_0_0._onFriendSelect(arg_14_0)
	local var_14_0 = SocialModel.instance:getSelectFriend()
	local var_14_1 = arg_14_0._mo.userId == var_14_0

	gohelper.setActive(arg_14_0._gobg, not var_14_1)
	gohelper.setActive(arg_14_0._gobgselect, var_14_1)
	gohelper.setActive(arg_14_0._goarrow, var_14_1)
	arg_14_0._playericon:isSelectInFriend(arg_14_0:_isSelectFriend())
	arg_14_0:updateName()
	arg_14_0:setBgState(arg_14_0._goskinEffect)
end

function var_0_0._isSelectFriend(arg_15_0)
	local var_15_0 = SocialModel.instance:getSelectFriend()

	if arg_15_0._mo.userId == var_15_0 then
		return true
	end

	return false
end

function var_0_0.onDestroy(arg_16_0)
	arg_16_0:removeEventCb(SocialController.instance, SocialEvent.SelectFriend, arg_16_0._onFriendSelect, arg_16_0)
	arg_16_0:removeEventCb(SocialController.instance, SocialEvent.FriendDescChange, arg_16_0.updateName, arg_16_0)
end

return var_0_0
