module("modules.logic.social.view.SocialBlackListItem", package.seeall)

local var_0_0 = class("SocialBlackListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goplayericon = gohelper.findChild(arg_1_0.viewGO, "#go_playericon")
	arg_1_0._goskinbg = gohelper.findChild(arg_1_0.viewGO, "#go_skinbg")
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.viewGO, "bg")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtstatus = gohelper.findChildText(arg_1_0.viewGO, "status/#txt_status")
	arg_1_0._txtofflinetime = gohelper.findChildText(arg_1_0.viewGO, "status/#txt_offlinetime")
	arg_1_0._btnremove = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_remove")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnremove:AddClickListener(arg_2_0._btnremoveOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnremove:RemoveClickListener()
end

function var_0_0._btnremoveOnClick(arg_4_0)
	FriendRpc.instance:sendRemoveBlacklistRequest(arg_4_0._mo.userId)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._playericon = IconMgr.instance:getCommonPlayerIcon(arg_5_0._goplayericon)
end

function var_0_0._refreshUI(arg_6_0)
	arg_6_0._playericon:onUpdateMO(arg_6_0._mo)
	arg_6_0._playericon:setShowLevel(true)

	arg_6_0._txtname.text = arg_6_0._mo.name

	gohelper.setActive(arg_6_0._txtstatus.gameObject, tonumber(arg_6_0._mo.time) == 0)
	gohelper.setActive(arg_6_0._txtofflinetime.gameObject, tonumber(arg_6_0._mo.time) ~= 0)

	if tonumber(arg_6_0._mo.time) ~= 0 then
		arg_6_0._txtofflinetime.text = SocialConfig.instance:getStatusText(arg_6_0._mo.time)
	end

	arg_6_0._txtstatus.text = luaLang("social_online")

	arg_6_0:_loadBg()
end

function var_0_0._loadBg(arg_7_0)
	if not arg_7_0._mo.bg or arg_7_0._mo.bg == 0 then
		arg_7_0._hasSkin = false
	else
		arg_7_0._hasSkin = true

		if not arg_7_0.lastskinId or arg_7_0.lastskinId ~= arg_7_0._mo.bg then
			arg_7_0._skinPath = string.format("ui/viewres/social/socialblacklistitem_bg_%s.prefab", arg_7_0._mo.bg)

			arg_7_0:_disposeBg()

			arg_7_0._loader = MultiAbLoader.New()

			arg_7_0._loader:addPath(arg_7_0._skinPath)
			arg_7_0._loader:startLoad(arg_7_0._onLoadFinish, arg_7_0)
		end
	end

	gohelper.setActive(arg_7_0._imagebg.gameObject, not arg_7_0._hasSkin)
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

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	arg_10_0:_refreshUI()
end

function var_0_0.onDestroy(arg_11_0)
	return
end

return var_0_0
