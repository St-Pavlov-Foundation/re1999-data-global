module("modules.logic.character.view.extra.CharacterWeaponEffectItem", package.seeall)

local var_0_0 = class("CharacterWeaponEffectItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagemainicon = gohelper.findChildImage(arg_1_0.viewGO, "main/#image_icon")
	arg_1_0._imagesecondicon = gohelper.findChildImage(arg_1_0.viewGO, "second/#image_icon")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._txteffect = gohelper.findChildText(arg_1_0.viewGO, "#txt_effect")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btntxt:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not arg_4_0.heroMo:isOwnHero() then
		return
	end

	if not arg_4_0.weaponMo then
		return
	end

	if arg_4_0.weaponMo:isConfirmWeaponGroup(arg_4_0._mo.firstId, arg_4_0._mo.secondId) then
		return
	end

	arg_4_0.weaponMo:confirmWeaponGroup(arg_4_0._mo.firstId, arg_4_0._mo.secondId)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._btntxt = SLFramework.UGUI.UIClickListener.Get(arg_5_0._txteffect.gameObject)

	arg_5_0._btntxt:AddClickListener(arg_5_0._btnclickOnClick, arg_5_0)

	arg_5_0._anim = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0._txteffect.gameObject, SkillDescComp)
	arg_6_0.heroMo = arg_6_2
	arg_6_0.weaponMo = arg_6_0.heroMo.extraMo:getWeaponMo()
	arg_6_0._mo = arg_6_1

	arg_6_0._skillDesc:updateInfo(arg_6_0._txteffect, arg_6_1:getSecondDesc(), arg_6_0.heroMo.heroId)
	gohelper.setActive(arg_6_0.viewGO, true)
	arg_6_0:refreshSelect()
	gohelper.setActive(arg_6_0.viewGO, false)
	TaskDispatcher.runDelay(arg_6_0._playOpenAnim, arg_6_0, 0.06 * (arg_6_3 - 1))

	local var_6_0 = arg_6_0._mo.firstId
	local var_6_1 = arg_6_0._mo.secondId
	local var_6_2 = arg_6_0.weaponMo:getWeaponMoByTypeId(CharacterExtraEnum.WeaponType.First, var_6_0)
	local var_6_3 = arg_6_0.weaponMo:getWeaponMoByTypeId(CharacterExtraEnum.WeaponType.Second, var_6_1)
	local var_6_4 = var_6_2.co.firsticon

	if not string.nilorempty(var_6_4) then
		UISpriteSetMgr.instance:setUiCharacterSprite(arg_6_0._imagemainicon, var_6_4)
	end

	local var_6_5 = var_6_3.co.secondicon

	if not string.nilorempty(var_6_5) then
		UISpriteSetMgr.instance:setUiCharacterSprite(arg_6_0._imagesecondicon, var_6_5)
	end
end

function var_0_0._playOpenAnim(arg_7_0)
	gohelper.setActive(arg_7_0.viewGO, true)
	arg_7_0._anim:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.refreshSelect(arg_8_0)
	local var_8_0 = arg_8_0.weaponMo:isConfirmWeaponGroup(arg_8_0._mo.firstId, arg_8_0._mo.secondId)

	arg_8_0:onSelect(var_8_0)
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goselect, arg_9_1)
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._playOpenAnim, arg_10_0)
end

return var_0_0
