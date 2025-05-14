module("modules.logic.seasonver.act123.view1_9.Season123_1_9CardPackageItem", package.seeall)

local var_0_0 = class("Season123_1_9CardPackageItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gopos = gohelper.findChild(arg_1_0.viewGO, "go_itempos/go_pos")
	arg_1_0._gocount = gohelper.findChild(arg_1_0.viewGO, "go_itempos/go_count")
	arg_1_0._txtcountvalue = gohelper.findChildText(arg_1_0.viewGO, "go_itempos/go_count/bg/#txt_countvalue")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	arg_4_0:refreshUI()
end

function var_0_0.refreshUI(arg_5_0)
	arg_5_0:checkCreateIcon()
	arg_5_0.icon:updateData(arg_5_0._mo.itemId)
	arg_5_0.icon:setIndexLimitShowState(true)

	if arg_5_0._mo.count > 0 then
		gohelper.setActive(arg_5_0._gocount, true)

		arg_5_0._txtcountvalue.text = luaLang("multiple") .. tostring(arg_5_0._mo.count)
	else
		gohelper.setActive(arg_5_0._gocount, false)
	end
end

function var_0_0.checkCreateIcon(arg_6_0)
	if not arg_6_0.icon then
		local var_6_0 = arg_6_0._view.viewContainer:getSetting().otherRes[2]
		local var_6_1 = arg_6_0._view:getResInst(var_6_0, arg_6_0._gopos, "icon")

		arg_6_0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, Season123_1_9CelebrityCardEquip)

		arg_6_0.icon:setClickCall(arg_6_0.onClickSelf, arg_6_0)
	end
end

function var_0_0.onClickSelf(arg_7_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, arg_7_0._mo.itemId)
end

function var_0_0.getAnimator(arg_8_0)
	arg_8_0._animator.enabled = true

	return arg_8_0._animator
end

function var_0_0.onDestroyView(arg_9_0)
	if arg_9_0.icon then
		arg_9_0.icon:disposeUI()
	end
end

return var_0_0
