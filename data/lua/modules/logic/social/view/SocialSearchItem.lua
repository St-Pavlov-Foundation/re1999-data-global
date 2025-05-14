module("modules.logic.social.view.SocialSearchItem", package.seeall)

local var_0_0 = class("SocialSearchItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goplayericon = gohelper.findChild(arg_1_0.viewGO, "#go_playericon")
	arg_1_0._goskinbg = gohelper.findChild(arg_1_0.viewGO, "#go_skinbg")
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.viewGO, "image_ItemBG")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtuid = gohelper.findChildText(arg_1_0.viewGO, "#txt_uid")
	arg_1_0._txtstatus = gohelper.findChildText(arg_1_0.viewGO, "status/#txt_status")
	arg_1_0._txtofflinetime = gohelper.findChildText(arg_1_0.viewGO, "status/#txt_offlinetime")
	arg_1_0._goofflinebg = gohelper.findChild(arg_1_0.viewGO, "status/bg")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_add")
	arg_1_0._gosent = gohelper.findChild(arg_1_0.viewGO, "#go_sent")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._anim.keepAnimatorControllerStateOnDisable = true

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadd:RemoveClickListener()
end

function var_0_0._btnaddOnClick(arg_4_0)
	SocialController.instance:AddFriend(arg_4_0._mo.userId, arg_4_0._addCallback, arg_4_0)
end

function var_0_0._addCallback(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 == 0 or arg_5_2 == -310 then
		arg_5_0._mo:setAddedFriend()
		gohelper.setActive(arg_5_0._btnadd.gameObject, false)
		gohelper.setActive(arg_5_0._gosent, true)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._heros = {}
	arg_6_0._heroParents = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 3 do
		arg_6_0._heroParents[iter_6_0] = gohelper.findChild(arg_6_0.viewGO, "Role/" .. iter_6_0)
	end

	gohelper.addUIClickAudio(arg_6_0._btnadd.gameObject, AudioEnum.UI.UI_Common_Click)

	arg_6_0._playericon = IconMgr.instance:getCommonPlayerIcon(arg_6_0._goplayericon)
end

function var_0_0._refreshUI(arg_7_0)
	arg_7_0._playericon:onUpdateMO(arg_7_0._mo)
	arg_7_0._playericon:setShowLevel(true)

	local var_7_0 = tostring(arg_7_0._mo.userId)
	local var_7_1 = var_7_0
	local var_7_2 = GameUtil.utf8len(var_7_0)

	if var_7_2 > 3 then
		var_7_1 = GameUtil.utf8sub(var_7_0, var_7_2 - 2, var_7_2)
	end

	arg_7_0._txtname.text = string.format("%s#%s", arg_7_0._mo.name, var_7_1)
	arg_7_0._txtuid.text = string.format(var_7_0)

	local var_7_3 = arg_7_0._mo:isSendAddFriend()
	local var_7_4 = tonumber(arg_7_0._mo.time) == 0

	gohelper.setActive(arg_7_0._btnadd, not var_7_3)
	gohelper.setActive(arg_7_0._gosent, var_7_3)
	gohelper.setActive(arg_7_0._txtstatus, var_7_4)
	gohelper.setActive(arg_7_0._txtofflinetime, not var_7_4)

	if not var_7_4 then
		arg_7_0._txtofflinetime.text = SocialConfig.instance:getStatusText(arg_7_0._mo.time)
	end

	gohelper.setActive(arg_7_0._goofflinebg, not var_7_4)

	arg_7_0._txtstatus.text = luaLang("social_online")

	arg_7_0:_loadBg()
end

function var_0_0._loadBg(arg_8_0)
	if not arg_8_0._mo.bg or arg_8_0._mo.bg == 0 then
		arg_8_0._hasSkin = false
	else
		arg_8_0._hasSkin = true

		if not arg_8_0.lastskinId or arg_8_0.lastskinId ~= arg_8_0._mo.bg then
			arg_8_0._skinPath = string.format("ui/viewres/social/socialsearchitem_bg_%s.prefab", arg_8_0._mo.bg)

			arg_8_0:_disposeBg()

			arg_8_0._loader = MultiAbLoader.New()

			arg_8_0._loader:addPath(arg_8_0._skinPath)
			arg_8_0._loader:startLoad(arg_8_0._onLoadFinish, arg_8_0)
		end
	end

	gohelper.setActive(arg_8_0._imagebg.gameObject, not arg_8_0._hasSkin)
	gohelper.setActive(arg_8_0._goskinbg, arg_8_0._hasSkin)
end

function var_0_0._disposeBg(arg_9_0)
	if arg_9_0._loader then
		arg_9_0._loader:dispose()

		arg_9_0._loader = nil
	end

	if arg_9_0._goskinEffect then
		gohelper.destroy(arg_9_0._goskinEffect)

		arg_9_0._goskinEffect = nil
	end
end

function var_0_0._onLoadFinish(arg_10_0)
	local var_10_0 = arg_10_0._loader:getAssetItem(arg_10_0._skinPath):GetResource(arg_10_0._skinPath)

	arg_10_0._goskinEffect = gohelper.clone(var_10_0, arg_10_0._goskinbg)
	arg_10_0.lastskinId = arg_10_0._mo.bg
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	local var_11_0 = UnityEngine.Time.realtimeSinceStartup - SocialModel.instance.playSearchItemAnimDt

	TaskDispatcher.cancelTask(arg_11_0._delayPlaySwtich, arg_11_0)
	gohelper.setActive(arg_11_0.viewGO, true)

	local var_11_1 = var_11_0 - (arg_11_0._index - 1) * 0.1

	if var_11_1 >= 0.5 then
		arg_11_0._anim:Play("open", 0, 1)
	elseif var_11_1 < 0 then
		gohelper.setActive(arg_11_0.viewGO, false)
		TaskDispatcher.runDelay(arg_11_0._delayPlaySwtich, arg_11_0, -var_11_1)
	else
		arg_11_0._anim:Play("switch", 0, var_11_1)
	end

	arg_11_0._mo = arg_11_1

	arg_11_0:_refreshUI()

	local var_11_2 = arg_11_1.infos or {}
	local var_11_3 = #var_11_2

	for iter_11_0 = 1, 3 do
		local var_11_4 = arg_11_0:getHeroIcon(iter_11_0)

		if iter_11_0 <= var_11_3 then
			var_11_4:updateMo(var_11_2[iter_11_0])
		else
			var_11_4:setActive(false)
		end
	end
end

function var_0_0._delayPlaySwtich(arg_12_0)
	gohelper.setActive(arg_12_0.viewGO, true)
	arg_12_0._anim:Play("switch", 0, 0)
	arg_12_0._anim:Update(0)
end

function var_0_0.getHeroIcon(arg_13_0, arg_13_1)
	if not arg_13_0._heros[arg_13_1] then
		local var_13_0 = arg_13_0._view:getResInst("ui/viewres/social/socialheroitem.prefab", arg_13_0._heroParents[arg_13_1], "HeroItem")

		arg_13_0._heros[arg_13_1] = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_0, SocialHeroItem)
	end

	return arg_13_0._heros[arg_13_1]
end

function var_0_0.onDestroy(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayPlaySwtich, arg_14_0)
end

return var_0_0
