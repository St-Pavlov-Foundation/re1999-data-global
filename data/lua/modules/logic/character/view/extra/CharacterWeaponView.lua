module("modules.logic.character.view.extra.CharacterWeaponView", package.seeall)

local var_0_0 = class("CharacterWeaponView", BaseView)
local var_0_1 = 0
local var_0_2 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollmain = gohelper.findChildScrollRect(arg_1_0.viewGO, "main/#scroll_main")
	arg_1_0._gomain = gohelper.findChild(arg_1_0.viewGO, "main/#go_main")
	arg_1_0._imagemainweapon = gohelper.findChildImage(arg_1_0.viewGO, "main/#go_main/equiped/#image_weapon")
	arg_1_0._txtmainname = gohelper.findChildText(arg_1_0.viewGO, "main/#go_main/equiped/#txt_name")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/#go_main/#btn_click")
	arg_1_0._scrollsecond = gohelper.findChildScrollRect(arg_1_0.viewGO, "second/#scroll_second")
	arg_1_0._gosecond = gohelper.findChild(arg_1_0.viewGO, "second/#go_second")
	arg_1_0._imagesecondweapon = gohelper.findChildImage(arg_1_0.viewGO, "second/#go_second/equiped/#image_weapon")
	arg_1_0._txtsecondname = gohelper.findChildText(arg_1_0.viewGO, "second/#go_second/equiped/#txt_name")
	arg_1_0._btnsecondclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "second/#go_second/#btn_click")
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#go_effect")
	arg_1_0._goeffectTitle = gohelper.findChild(arg_1_0.viewGO, "#go_effect/#go_effectTitle")
	arg_1_0._btneffect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_effect/#btn_effect")
	arg_1_0._scrolleffect = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_effect/#scroll_effect")
	arg_1_0._txtfirsteffect = gohelper.findChildText(arg_1_0.viewGO, "#go_effect/#scroll_effect/Viewport/Content/#txt_firsteffect")
	arg_1_0._txtsecondeffect = gohelper.findChildText(arg_1_0.viewGO, "#go_effect/#scroll_effect/Viewport/Content/#txt_secondeffect")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_effect/#scroll_effect/Viewport/Content/#go_empty")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btneffect:AddClickListener(arg_2_0._btneffectOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_2_0._onSuccessHeroRankUp, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, arg_2_0._onChoiceHero3123WeaponReply, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onClickWeapon, arg_2_0._onClickWeapon, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btneffect:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_3_0._onSuccessHeroRankUp, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, arg_3_0._onChoiceHero3123WeaponReply, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onClickWeapon, arg_3_0._onClickWeapon, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._btneffectOnClick(arg_4_0)
	CharacterController.instance:openCharacterWeaponEffectView(arg_4_0.heroMo)
end

function var_0_0._onSuccessHeroRankUp(arg_5_0)
	arg_5_0:_refreshWeaponStatus()
	arg_5_0:_refreshWeaponUnlock()
end

function var_0_0._onChoiceHero3123WeaponReply(arg_6_0)
	arg_6_0:_refreshWeaponStatus()

	if not ViewMgr.instance:isOpen(ViewName.CharacterWeaponEffectView) then
		arg_6_0:_playSwitchAnim()
	end
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.CharacterWeaponEffectView then
		arg_7_0:_playSwitchAnim()
	end
end

function var_0_0._onClickWeapon(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.weaponMo:getWeaponMoByTypeId(arg_8_1, arg_8_2)

	if var_8_0 then
		if var_8_0:isLock() then
			if arg_8_1 == CharacterExtraEnum.WeaponType.Second and not arg_8_0.weaponMo:isUnlockWeapon(arg_8_1) then
				local var_8_1 = arg_8_0.weaponMo:getUnlockWeaponRank(arg_8_1)

				GameFacade.showToast(ToastEnum.CharacterSecondWeaponRankUnlock, GameUtil.getNum2Chinese(var_8_1 - 1))
			end

			return
		elseif var_8_0:isNormal() then
			arg_8_0.weaponMo:setChoiceHero3123WeaponRequest(arg_8_1, arg_8_2)
		end
	end

	arg_8_0:_refreshWeaponStatus()
end

function var_0_0._editableInitView(arg_9_0)
	local var_9_0 = gohelper.findChild(arg_9_0.viewGO, "main/#scroll_main/Viewport/Content")
	local var_9_1 = gohelper.findChild(arg_9_0.viewGO, "second/#scroll_second/Viewport/Content")
	local var_9_2 = gohelper.findChild(arg_9_0.viewGO, "main/#scroll_main/Viewport/Content/go_item")
	local var_9_3 = gohelper.findChild(arg_9_0.viewGO, "second/#scroll_second/Viewport/Content/go_item")
	local var_9_4 = gohelper.findChild(arg_9_0.viewGO, "main/#go_main/equiped")
	local var_9_5 = gohelper.findChild(arg_9_0.viewGO, "second/#go_second/equiped")
	local var_9_6 = gohelper.findChild(arg_9_0.viewGO, "main/#go_main/unequip")
	local var_9_7 = gohelper.findChild(arg_9_0.viewGO, "second/#go_second/unequip")

	arg_9_0._curShowWeapon = {}

	local var_9_8 = arg_9_0._gomain:GetComponent(typeof(UnityEngine.Animator))
	local var_9_9 = arg_9_0._gosecond:GetComponent(typeof(UnityEngine.Animator))
	local var_9_10 = gohelper.findChild(arg_9_0._txtfirsteffect.gameObject, "#switch")
	local var_9_11 = gohelper.findChild(arg_9_0._txtsecondeffect.gameObject, "#switch")
	local var_9_12 = gohelper.findChild(arg_9_0.viewGO, "second/#go_second/locked")

	arg_9_0._weaponItems = arg_9_0:getUserDataTb_()
	arg_9_0._weaponTypeComp = {
		[CharacterExtraEnum.WeaponType.First] = {
			content = var_9_0,
			prefabItem = var_9_2,
			equipRoot = var_9_4,
			unequipRoot = var_9_6,
			anim = var_9_8,
			effect = var_9_10,
			nameTxt = arg_9_0._txtmainname,
			iconImage = arg_9_0._imagemainweapon
		},
		[CharacterExtraEnum.WeaponType.Second] = {
			content = var_9_1,
			prefabItem = var_9_3,
			equipRoot = var_9_5,
			unequipRoot = var_9_7,
			lock = var_9_12,
			anim = var_9_9,
			effect = var_9_11,
			nameTxt = arg_9_0._txtsecondname,
			iconImage = arg_9_0._imagesecondweapon
		}
	}

	gohelper.setActive(var_9_2, false)
	gohelper.setActive(var_9_3, false)

	arg_9_0._txtsecondweaponLock = gohelper.findChildText(arg_9_0.viewGO, "second/#go_second/locked/txt_locked")
	arg_9_0._effectAnim = arg_9_0._goeffect:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:_refreshWeaponStatus()
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0.heroMo = arg_11_0.viewParam
	arg_11_0.weaponMo = arg_11_0.heroMo.extraMo:getWeaponMo()

	arg_11_0:_refreshWeapon()
	arg_11_0:_refreshEquip()
	arg_11_0:_refreshWeaponUnlock()

	local var_11_0 = arg_11_0.weaponMo:getUnlockWeaponRank(CharacterExtraEnum.WeaponType.Second)
	local var_11_1 = luaLang("characterweaponview_unlock_rank")
	local var_11_2 = GameUtil.getNum2Chinese(var_11_0 - 1)

	arg_11_0._txtsecondweaponLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_11_1, var_11_2)
end

function var_0_0._refreshWeaponUnlock(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._weaponTypeComp) do
		local var_12_0 = arg_12_0.weaponMo:isUnlockWeapon(iter_12_0)

		if var_12_0 then
			local var_12_1 = arg_12_0:_getPlayUnlockWeaponAnimKey(iter_12_0)

			if GameUtil.playerPrefsGetNumberByUserId(var_12_1, var_0_1) == var_0_1 then
				iter_12_1.anim:Play(CharacterExtraEnum.WeaponAnimName.Unlock, 0, 0)
				GameUtil.playerPrefsSetNumberByUserId(var_12_1, var_0_2)
				AudioMgr.instance:trigger(AudioEnum2_9.Character.ui_role_aijiao_jiesuo)
			end
		else
			gohelper.setActive(iter_12_1.equipRoot.gameObject, false)
			gohelper.setActive(iter_12_1.unequipRoot.gameObject, false)
		end

		if iter_12_1.lock then
			gohelper.setActive(iter_12_1.lock.gameObject, not var_12_0)
		end
	end
end

function var_0_0._getPlayUnlockWeaponAnimKey(arg_13_0, arg_13_1)
	return (string.format("CharacterWeaponView_PlayWeaponAnimKey_%s_%s", arg_13_0.heroMo.heroId, arg_13_1))
end

function var_0_0._refreshWeaponStatus(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._weaponItems) do
		for iter_14_2, iter_14_3 in pairs(iter_14_1) do
			iter_14_3:refreshStatus()
		end
	end
end

function var_0_0._refreshEquip(arg_15_0)
	local var_15_0 = arg_15_0.heroMo.exSkillLevel

	for iter_15_0, iter_15_1 in pairs(CharacterExtraEnum.WeaponType) do
		local var_15_1 = arg_15_0.weaponMo:getCurEquipWeapon(iter_15_1)
		local var_15_2 = arg_15_0._weaponTypeComp[iter_15_1]

		if var_15_1 and var_15_1 ~= 0 then
			local var_15_3 = arg_15_0.weaponMo:getWeaponMoByTypeId(iter_15_1, var_15_1)

			if var_15_3 then
				var_15_2.nameTxt.text = var_15_3.co.name

				local var_15_4 = var_15_3.co.secondicon

				if not string.nilorempty(var_15_4) then
					UISpriteSetMgr.instance:setUiCharacterSprite(var_15_2.iconImage, var_15_4)
				end
			end

			gohelper.setActive(var_15_2.equipRoot, true)
			gohelper.setActive(var_15_2.unequipRoot, false)
		else
			gohelper.setActive(var_15_2.equipRoot, false)

			local var_15_5 = arg_15_0.weaponMo:isUnlockWeapon(iter_15_1)

			gohelper.setActive(var_15_2.unequipRoot, var_15_5)
		end

		local var_15_6 = arg_15_0._curShowWeapon[iter_15_1] or {}

		var_15_6.id = var_15_1
		arg_15_0._curShowWeapon[iter_15_1] = var_15_6
	end

	local var_15_7 = arg_15_0._curShowWeapon[CharacterExtraEnum.WeaponType.First]
	local var_15_8 = var_15_7 and var_15_7.id or 0

	if var_15_8 == 0 then
		gohelper.setActive(arg_15_0._txtfirsteffect.gameObject, false)
		gohelper.setActive(arg_15_0._txtsecondeffect.gameObject, false)
		gohelper.setActive(arg_15_0._goempty.gameObject, true)

		return
	end

	local var_15_9 = arg_15_0._curShowWeapon[CharacterExtraEnum.WeaponType.Second]
	local var_15_10 = var_15_9 and var_15_9.id or 0
	local var_15_11 = CharacterExtraConfig.instance:getEzioWeaponGroupCos(var_15_8, var_15_10, var_15_0)

	var_15_7.desc = var_15_11.firstDesc
	arg_15_0._firstSkillDesc = arg_15_0._firstSkillDesc or MonoHelper.addNoUpdateLuaComOnceToGo(arg_15_0._txtfirsteffect.gameObject, SkillDescComp)

	arg_15_0._firstSkillDesc:updateInfo(arg_15_0._txtfirsteffect, var_15_11.firstDesc, arg_15_0.heroMo.heroId)
	arg_15_0._firstSkillDesc:setTipParam(nil, Vector2(250, -100))
	arg_15_0._firstSkillDesc:setBuffTipPivot(CommonBuffTipEnum.Pivot.Down)
	gohelper.setActive(arg_15_0._txtfirsteffect.gameObject, true)
	gohelper.setActive(arg_15_0._goempty.gameObject, false)

	if var_15_10 == 0 then
		gohelper.setActive(arg_15_0._txtsecondeffect.gameObject, false)

		return
	end

	var_15_9.desc = var_15_11.secondDesc
	arg_15_0._secondSkillDesc = arg_15_0._secondSkillDesc or MonoHelper.addNoUpdateLuaComOnceToGo(arg_15_0._txtsecondeffect.gameObject, SkillDescComp)

	arg_15_0._secondSkillDesc:updateInfo(arg_15_0._txtsecondeffect, var_15_11.secondDesc, arg_15_0.heroMo.heroId)
	arg_15_0._secondSkillDesc:setTipParam(nil, Vector2(250, -100))
	arg_15_0._secondSkillDesc:setBuffTipPivot(CommonBuffTipEnum.Pivot.Down)
	gohelper.setActive(arg_15_0._txtsecondeffect.gameObject, true)
end

function var_0_0._checkDescHeight(arg_16_0, arg_16_1)
	local var_16_0 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_16_0._txtfirsteffect, arg_16_1.firstDesc) + SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_16_0._txtsecondeffect, arg_16_1.secondDesc) + 20
	local var_16_1 = 246
	local var_16_2 = 168
	local var_16_3 = GameUtil.clamp(var_16_0, var_16_2, var_16_1)

	recthelper.setHeight(arg_16_0._scrolleffect.transform, var_16_3)
end

function var_0_0._refreshWeapon(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(CharacterExtraEnum.WeaponType) do
		local var_17_0 = arg_17_0.weaponMo:getWeaponMosByType(iter_17_1)

		for iter_17_2, iter_17_3 in ipairs(var_17_0) do
			arg_17_0:_getWeaponItem(iter_17_1, iter_17_2):onUpdateMO(iter_17_3, arg_17_0.heroMo)
		end
	end
end

function var_0_0._getWeaponItem(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._weaponItems[arg_18_1] then
		arg_18_0._weaponItems[arg_18_1] = arg_18_0:getUserDataTb_()
	end

	local var_18_0 = arg_18_0._weaponItems[arg_18_1][arg_18_2]

	if not var_18_0 then
		local var_18_1 = arg_18_0._weaponTypeComp[arg_18_1]
		local var_18_2 = var_18_1.content
		local var_18_3 = var_18_1.prefabItem
		local var_18_4 = gohelper.clone(var_18_3, var_18_2)

		var_18_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_4, CharacterWeaponShowItem)
		arg_18_0._weaponItems[arg_18_1][arg_18_2] = var_18_0
	end

	return var_18_0
end

function var_0_0._playSwitchAnim(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._refreshEquip, arg_19_0)

	local var_19_0 = false
	local var_19_1 = arg_19_0.weaponMo:getWeaponGroupCo()

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._weaponTypeComp) do
		local var_19_2 = arg_19_0.weaponMo:getCurEquipWeapon(iter_19_0)
		local var_19_3 = arg_19_0._curShowWeapon[iter_19_0]

		if var_19_3.id ~= var_19_2 then
			iter_19_1.anim:Play(CharacterExtraEnum.WeaponAnimName.Switch, 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_9.Character.ui_role_aijiao_wuqi)
		end

		local var_19_4 = iter_19_0 == CharacterExtraEnum.WeaponType.First and var_19_1.firstDesc or var_19_1.secondDesc

		if var_19_3.desc ~= var_19_4 then
			gohelper.setActive(iter_19_1.effect, true)

			var_19_0 = true
		else
			gohelper.setActive(iter_19_1.effect, false)
		end
	end

	if var_19_0 then
		arg_19_0._effectAnim:Play(CharacterExtraEnum.WeaponAnimName.Switch, 0, 0)
	end

	TaskDispatcher.runDelay(arg_19_0._refreshEquip, arg_19_0, 0.16)
end

function var_0_0.onClose(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._refreshEquip, arg_20_0)
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
