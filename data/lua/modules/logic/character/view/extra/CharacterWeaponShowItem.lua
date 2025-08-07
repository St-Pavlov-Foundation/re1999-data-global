module("modules.logic.character.view.extra.CharacterWeaponShowItem", package.seeall)

local var_0_0 = class("CharacterWeaponShowItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "root/#go_select")
	arg_1_0._imageselecticon = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_select/#image_icon")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.viewGO, "root/#go_unselect")
	arg_1_0._imageunselecticon = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_unselect/#image_icon")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "root/#go_unselect/#go_reddot")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "root/#go_lock")
	arg_1_0._imagelockicon = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_lock/#image_icon")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._heroMo:isOwnHero() then
		return
	end

	arg_4_0._mo:cancelNew()
	gohelper.setActive(arg_4_0._goreddot, false)
	CharacterController.instance:dispatchEvent(CharacterEvent.onClickWeapon, arg_4_0._mo.type, arg_4_0._mo.weaponId)
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.viewGO = arg_5_1

	arg_5_0:onInitView()

	arg_5_0._anim = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._txt = gohelper.findChildText(arg_6_0.viewGO, "txt")
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._mo = arg_7_1
	arg_7_0._heroMo = arg_7_2

	local var_7_0 = arg_7_0._mo.co.firsticon

	if not string.nilorempty(var_7_0) then
		UISpriteSetMgr.instance:setUiCharacterSprite(arg_7_0._imageselecticon, var_7_0)
		UISpriteSetMgr.instance:setUiCharacterSprite(arg_7_0._imageunselecticon, var_7_0)
		UISpriteSetMgr.instance:setUiCharacterSprite(arg_7_0._imagelockicon, var_7_0)
	end

	gohelper.setActive(arg_7_0.viewGO, true)
	gohelper.setActive(arg_7_0._goreddot, arg_7_0._heroMo:isOwnHero() and arg_7_1:isNew())
	arg_7_0:refreshStatus()
end

function var_0_0.refreshStatus(arg_8_0)
	local var_8_0 = arg_8_0._mo:isLock()
	local var_8_1 = arg_8_0._mo:isEquip()

	gohelper.setActive(arg_8_0._goselect, not var_8_0 and var_8_1)
	gohelper.setActive(arg_8_0._gounselect, not var_8_0 and not var_8_1)
	gohelper.setActive(arg_8_0._golock, var_8_0)

	if not var_8_0 and GameUtil.playerPrefsGetNumberByUserId(arg_8_0:_getUnlockAnimKey(), 0) == 0 then
		arg_8_0._anim:Play(CharacterExtraEnum.WeaponAnimName.Unlock, 0, 0)
		GameUtil.playerPrefsSetNumberByUserId(arg_8_0:_getUnlockAnimKey(), 1)
	end
end

function var_0_0._getUnlockAnimKey(arg_9_0)
	return (string.format("CharacterWeaponShowItem_getUnlockAnimKey_%s_%s_%s", arg_9_0._mo.heroId, arg_9_0._mo.type, arg_9_0._mo.weaponId))
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
