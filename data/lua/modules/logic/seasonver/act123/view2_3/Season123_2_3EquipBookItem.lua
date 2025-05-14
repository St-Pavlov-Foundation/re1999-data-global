module("modules.logic.seasonver.act123.view2_3.Season123_2_3EquipBookItem", package.seeall)

local var_0_0 = class("Season123_2_3EquipBookItem", ListScrollCellExtend)

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

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._cfg = Season123Config.instance:getSeasonEquipCo(arg_4_0._mo.id)

	if arg_4_0._cfg then
		arg_4_0:refreshUI()
	end

	arg_4_0:checkPlayAnim()
end

var_0_0.ColumnCount = 6
var_0_0.AnimRowCount = 4
var_0_0.OpenAnimTime = 0.06
var_0_0.OpenAnimStartTime = 0.05

function var_0_0.refreshUI(arg_5_0)
	arg_5_0:checkCreateIcon()
	arg_5_0.icon:updateData(arg_5_0._mo.id)
	arg_5_0.icon:setColorDark(arg_5_0._mo.count <= 0)
	arg_5_0.icon:setIndexLimitShowState(true)
	gohelper.setActive(arg_5_0._goselect, Season123EquipBookModel.instance.curSelectItemId == arg_5_0._mo.id)
	gohelper.setActive(arg_5_0._gonew, arg_5_0._mo.isNew)

	if arg_5_0._mo.count > 0 then
		gohelper.setActive(arg_5_0._gocount, true)

		arg_5_0._txtcountvalue.text = luaLang("multiple") .. tostring(arg_5_0._mo.count)
	else
		gohelper.setActive(arg_5_0._gocount, false)
	end
end

function var_0_0.checkPlayAnim(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onDelayPlayOpen, arg_6_0)

	local var_6_0 = Season123EquipBookModel.instance:getDelayPlayTime(arg_6_0._mo)

	if var_6_0 == -1 then
		arg_6_0._animator:Play("idle", 0, 0)

		arg_6_0._animator.speed = 1
	else
		arg_6_0._animator:Play("open", 0, 0)

		arg_6_0._animator.speed = 0

		TaskDispatcher.runDelay(arg_6_0.onDelayPlayOpen, arg_6_0, var_6_0)
	end
end

function var_0_0.onDelayPlayOpen(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.onDelayPlayOpen, arg_7_0)
	arg_7_0._animator:Play("open", 0, 0)

	arg_7_0._animator.speed = 1
end

function var_0_0.checkCreateIcon(arg_8_0)
	if not arg_8_0.icon then
		local var_8_0 = arg_8_0._view.viewContainer:getSetting().otherRes[2]
		local var_8_1 = arg_8_0._view:getResInst(var_8_0, arg_8_0._gopos, "icon")

		arg_8_0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, Season123_2_3CelebrityCardEquip)

		arg_8_0.icon:setClickCall(arg_8_0.onClickSelf, arg_8_0)
	end
end

function var_0_0.onClickSelf(arg_9_0)
	if arg_9_0._mo then
		Season123EquipBookController.instance:changeSelect(arg_9_0._mo.id)
	end
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0.icon then
		arg_10_0.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(arg_10_0.onDelayPlayOpen, arg_10_0)
end

return var_0_0
