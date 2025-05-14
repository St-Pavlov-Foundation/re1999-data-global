module("modules.logic.season.view1_3.Season1_3EquipBookItem", package.seeall)

local var_0_0 = class("Season1_3EquipBookItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gopos = gohelper.findChild(arg_1_0.viewGO, "go_pos")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0._simageroleicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "image_roleicon")
	arg_1_0._txtcountvalue = gohelper.findChildText(arg_1_0.viewGO, "go_count/bg/#txt_countvalue")
	arg_1_0._gocount = gohelper.findChild(arg_1_0.viewGO, "go_count")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "#go_new")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1
	arg_2_0._cfg = SeasonConfig.instance:getSeasonEquipCo(arg_2_0._mo.id)

	if arg_2_0._cfg then
		arg_2_0:refreshUI()
	end

	arg_2_0:checkPlayAnim()
end

var_0_0.ColumnCount = 6
var_0_0.AnimRowCount = 4
var_0_0.OpenAnimTime = 0.06
var_0_0.OpenAnimStartTime = 0.05

function var_0_0.refreshUI(arg_3_0)
	arg_3_0:checkCreateIcon()
	arg_3_0.icon:updateData(arg_3_0._mo.id)
	arg_3_0.icon:setColorDark(arg_3_0._mo.count <= 0)
	gohelper.setActive(arg_3_0._goselect, Activity104EquipItemBookModel.instance.curSelectItemId == arg_3_0._mo.id)
	gohelper.setActive(arg_3_0._gonew, arg_3_0._mo.isNew)

	if arg_3_0._mo.count > 0 then
		gohelper.setActive(arg_3_0._gocount, true)

		arg_3_0._txtcountvalue.text = luaLang("multiple") .. tostring(arg_3_0._mo.count)
	else
		gohelper.setActive(arg_3_0._gocount, false)
	end
end

function var_0_0.checkPlayAnim(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.onDelayPlayOpen, arg_4_0)

	local var_4_0 = Activity104EquipItemBookModel.instance:getDelayPlayTime(arg_4_0._mo)

	if var_4_0 == -1 then
		arg_4_0._animator:Play("idle", 0, 0)

		arg_4_0._animator.speed = 1
	else
		arg_4_0._animator:Play("open", 0, 0)

		arg_4_0._animator.speed = 0

		TaskDispatcher.runDelay(arg_4_0.onDelayPlayOpen, arg_4_0, var_4_0)
	end
end

function var_0_0.onDelayPlayOpen(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.onDelayPlayOpen, arg_5_0)
	arg_5_0._animator:Play("open", 0, 0)

	arg_5_0._animator.speed = 1
end

function var_0_0.checkCreateIcon(arg_6_0)
	if not arg_6_0.icon then
		local var_6_0 = arg_6_0._view.viewContainer:getSetting().otherRes[2]
		local var_6_1 = arg_6_0._view:getResInst(var_6_0, arg_6_0._gopos, "icon")

		arg_6_0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, Season1_3CelebrityCardEquip)

		arg_6_0.icon:setClickCall(arg_6_0.onClickSelf, arg_6_0)
	end
end

function var_0_0.onClickSelf(arg_7_0)
	if arg_7_0._mo then
		Activity104EquipBookController.instance:changeSelect(arg_7_0._mo.id)
	end
end

function var_0_0.onDestroyView(arg_8_0)
	if arg_8_0.icon then
		arg_8_0.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(arg_8_0.onDelayPlayOpen, arg_8_0)
end

return var_0_0
