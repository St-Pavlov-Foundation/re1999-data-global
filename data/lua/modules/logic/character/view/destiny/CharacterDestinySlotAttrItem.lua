module("modules.logic.character.view.destiny.CharacterDestinySlotAttrItem", package.seeall)

local var_0_0 = class("CharacterDestinySlotAttrItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gospecialbg = gohelper.findChild(arg_1_0.viewGO, "#go_specialbg")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._txtunlocktips = gohelper.findChildText(arg_1_0.viewGO, "#go_lock/#txt_unlocktips")
	arg_1_0._txtlockname = gohelper.findChildText(arg_1_0.viewGO, "#go_lock/layout/#txt_lockname")
	arg_1_0._imagelockicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_lock/layout/#txt_lockname/#image_lockicon")
	arg_1_0._txtlockcur = gohelper.findChildText(arg_1_0.viewGO, "#go_lock/layout/num/#txt_lockcur")
	arg_1_0._golockarrow = gohelper.findChild(arg_1_0.viewGO, "#go_lock/layout/num/#go_lockarrow")
	arg_1_0._txtlocknext = gohelper.findChildText(arg_1_0.viewGO, "#go_lock/layout/num/#txt_locknext")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_unlock")
	arg_1_0._txtunlockname = gohelper.findChildText(arg_1_0.viewGO, "#go_unlock/#txt_unlockname")
	arg_1_0._imageunlockicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_unlock/#txt_unlockname/#image_unlockicon")
	arg_1_0._txtunlockcur = gohelper.findChildText(arg_1_0.viewGO, "#go_unlock/num/#txt_unlockcur")
	arg_1_0._gounlockarrow = gohelper.findChild(arg_1_0.viewGO, "#go_unlock/num/#go_unlockarrow")
	arg_1_0._txtunlocknext = gohelper.findChildText(arg_1_0.viewGO, "#go_unlock/num/#txt_unlocknext")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.viewGO = arg_5_1
	arg_5_0._lockItem = arg_5_0:getUserDataTb_()
	arg_5_0._golockItem = gohelper.findChild(arg_5_0.viewGO, "#go_lock/layout")
	arg_5_0._levelup = gohelper.findChild(arg_5_0.viewGO, "#leveup")
	arg_5_0._lockItem[1] = arg_5_0:__getLockItem(arg_5_0._golockItem)

	arg_5_0:onInitView()
	gohelper.setActive(arg_5_1, true)
	gohelper.setActive(arg_5_0._levelup, false)
end

function var_0_0.addEventListeners(arg_6_0)
	arg_6_0:addEvents()
end

function var_0_0.removeEventListeners(arg_7_0)
	arg_7_0:removeEvents()
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._levelupAnimCallback, arg_8_0)
end

function var_0_0.onUpdateBaseAttrMO(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = HeroConfig.instance:getHeroAttributeCO(arg_9_2.attrId)
	local var_9_1 = var_9_0.name
	local var_9_2 = arg_9_2.curNum or 0
	local var_9_3 = arg_9_2.nextNum or 0

	arg_9_0._txtunlockname.text = var_9_1
	arg_9_0._txtunlockcur.text = arg_9_0:_showAttrValue(var_9_2, var_9_0.showType)
	arg_9_0._txtunlocknext.text = arg_9_0:_showAttrValue(var_9_2 + var_9_3, var_9_0.showType)

	local var_9_4 = arg_9_2.attrId

	arg_9_0.attrId = var_9_4

	local var_9_5

	var_9_5 = CharacterDestinyModel.instance:destinyUpBaseReverseParseAttr(var_9_4) or arg_9_2.attrId

	CharacterController.instance:SetAttriIcon(arg_9_0._imageunlockicon, var_9_5)
	gohelper.setActive(arg_9_0._gounlockarrow, var_9_3 > 0)
	gohelper.setActive(arg_9_0._txtunlocknext.gameObject, var_9_3 > 0)
	gohelper.setActive(arg_9_0._gounlock, true)
	gohelper.setActive(arg_9_0._golock, false)
	recthelper.setAnchorY(arg_9_0._gospecialbg.transform, 0)

	if arg_9_3 then
		local var_9_6 = arg_9_0:_getSpecialBgHeight(arg_9_4)

		recthelper.setHeight(arg_9_0._gospecialbg.transform, var_9_6)
	end

	gohelper.setActive(arg_9_0._gospecialbg, arg_9_3)
end

function var_0_0.onUpdateSpecailAttrMO(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0:onUpdateBaseAttrMO(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
end

function var_0_0.onUpdateLockSpecialAttrMO(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 then
		local var_11_0 = 1
		local var_11_1 = 0

		for iter_11_0, iter_11_1 in pairs(arg_11_3) do
			local var_11_2 = HeroConfig.instance:getHeroAttributeCO(iter_11_1.attrId)
			local var_11_3 = var_11_2.name
			local var_11_4 = iter_11_1.curNum or 0
			local var_11_5 = arg_11_0:_getLockItem(var_11_0)

			if var_11_5 then
				var_11_5.nameTxt.text = var_11_3
				var_11_5.curNumTxt.text = arg_11_0:_showAttrValue(var_11_4, var_11_2.showType)

				local var_11_6 = iter_11_1.attrId

				if (LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpSpecialAttr, var_11_6) or LuaUtil.tableContains(CharacterEnum.UpAttrIdList, var_11_6)) and not arg_11_0._gospecialbg.activeSelf then
					recthelper.setAnchorY(arg_11_0._gospecialbg.transform, -50 - (var_11_0 - 1) * 53)
					gohelper.setActive(arg_11_0._gospecialbg, true)

					var_11_1 = var_11_0
				end

				local var_11_7

				var_11_7 = CharacterDestinyModel.instance:destinyUpBaseReverseParseAttr(var_11_6) or iter_11_1.attrId

				CharacterController.instance:SetAttriIcon(var_11_5.iconImage, var_11_7)
			end

			var_11_0 = var_11_0 + 1
		end

		if var_11_1 > 0 and arg_11_0._gospecialbg.activeSelf then
			local var_11_8 = arg_11_0:_getSpecialBgHeight(var_11_0 - var_11_1)

			recthelper.setHeight(arg_11_0._gospecialbg.transform, var_11_8)
		end

		local var_11_9 = luaLang("character_destinyslot_unlockrank")
		local var_11_10 = CharacterDestinyEnum.RomanNum[arg_11_2]

		arg_11_0._txtunlocktips.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_11_9, var_11_10)
	end

	gohelper.setActive(arg_11_0._gounlock, false)
	gohelper.setActive(arg_11_0._golock, true)
end

function var_0_0._getSpecialBgHeight(arg_12_0, arg_12_1)
	return 50 + arg_12_1 * 70
end

function var_0_0._showAttrValue(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_2 == 1 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), arg_13_1) or arg_13_1
end

function var_0_0._getLockItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._lockItem[arg_14_1]

	if not var_14_0 then
		local var_14_1 = gohelper.cloneInPlace(arg_14_0._golockItem)

		var_14_0 = arg_14_0:__getLockItem(var_14_1)
		arg_14_0._lockItem[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.__getLockItem(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	local var_15_0 = arg_15_0:getUserDataTb_()

	var_15_0.go = arg_15_1
	var_15_0.nameTxt = gohelper.findChildText(arg_15_1, "#txt_lockname")
	var_15_0.iconImage = gohelper.findChildImage(arg_15_1, "#txt_lockname/#image_lockicon")
	var_15_0.curNumTxt = gohelper.findChildText(arg_15_1, "num/#txt_lockcur")
	var_15_0.arrowGo = gohelper.findChild(arg_15_1, "num/#go_lockarrow")
	var_15_0.nextNumTxt = gohelper.findChildText(arg_15_1, "num/#txt_locknext")

	return var_15_0
end

function var_0_0.playLevelUpAnim(arg_16_0)
	gohelper.setActive(arg_16_0._levelup, true)
	TaskDispatcher.runDelay(arg_16_0._levelupAnimCallback, arg_16_0, 1)
end

function var_0_0._levelupAnimCallback(arg_17_0)
	gohelper.setActive(arg_17_0._levelup, false)
end

return var_0_0
