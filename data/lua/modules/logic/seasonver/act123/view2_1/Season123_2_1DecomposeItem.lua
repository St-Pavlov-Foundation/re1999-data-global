module("modules.logic.seasonver.act123.view2_1.Season123_2_1DecomposeItem", package.seeall)

local var_0_0 = class("Season123_2_1DecomposeItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gopos = gohelper.findChild(arg_1_0.viewGO, "go_pos")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0._simageroleicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "image_roleicon")
	arg_1_0._gorolebg = gohelper.findChild(arg_1_0.viewGO, "bg")
	arg_1_0._imageroleicon = gohelper.findChildImage(arg_1_0.viewGO, "image_roleicon")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goDecomposeEffect = gohelper.findChild(arg_1_0.viewGO, "vx_compose")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnRefleshDecomposeItemUI, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnBatchDecomposeEffectPlay, arg_2_0.showDecomposeEffect, arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.CloseBatchDecomposeEffect, arg_2_0.hideDecomposeEffect, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnRefleshDecomposeItemUI, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnBatchDecomposeEffectPlay, arg_3_0.showDecomposeEffect, arg_3_0)
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.CloseBatchDecomposeEffect, arg_3_0.hideDecomposeEffect, arg_3_0)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._cfg = Season123Config.instance:getSeasonEquipCo(arg_4_0._mo.itemId)

	if arg_4_0._cfg then
		arg_4_0:refreshUI()
	end

	arg_4_0:checkPlayAnim()
end

var_0_0.AnimRowCount = 4
var_0_0.OpenAnimTime = 0.06
var_0_0.OpenAnimStartTime = 0.05

function var_0_0.refreshUI(arg_5_0)
	arg_5_0:checkCreateIcon()
	arg_5_0.icon:updateData(arg_5_0._mo.itemId)
	arg_5_0.icon:setIndexLimitShowState(true)
	gohelper.setActive(arg_5_0._goselect, Season123DecomposeModel.instance:isSelectedItem(arg_5_0._mo.uid))

	local var_5_0 = Season123DecomposeModel.instance:getItemUidToHeroUid(arg_5_0._mo.uid)

	arg_5_0:refreshEquipedHero(var_5_0)
end

function var_0_0.refreshEquipedHero(arg_6_0, arg_6_1)
	if not arg_6_1 or arg_6_1 == Activity123Enum.EmptyUid then
		gohelper.setActive(arg_6_0._simageroleicon, false)
		gohelper.setActive(arg_6_0._gorolebg, false)

		return
	end

	local var_6_0

	if arg_6_1 == Activity123Enum.MainRoleHeroUid then
		var_6_0 = Activity123Enum.MainRoleHeadIconID
	else
		local var_6_1 = HeroModel.instance:getById(arg_6_1)

		if not var_6_1 then
			gohelper.setActive(arg_6_0._simageroleicon, false)
			gohelper.setActive(arg_6_0._gorolebg, false)

			return
		end

		var_6_0 = var_6_1.skin
	end

	gohelper.setActive(arg_6_0._simageroleicon, true)
	gohelper.setActive(arg_6_0._gorolebg, true)
	arg_6_0._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(var_6_0))
end

function var_0_0.checkPlayAnim(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.onDelayPlayOpen, arg_7_0)

	local var_7_0 = arg_7_0._view.viewContainer:getLineCount()

	Season123DecomposeModel.instance:setItemCellCount(var_7_0)

	local var_7_1 = Season123DecomposeModel.instance:getDelayPlayTime(arg_7_0._mo)

	if var_7_1 == -1 then
		arg_7_0._animator:Play("idle", 0, 0)

		arg_7_0._animator.speed = 1
	else
		arg_7_0._animator:Play("open", 0, 0)

		arg_7_0._animator.speed = 0

		TaskDispatcher.runDelay(arg_7_0.onDelayPlayOpen, arg_7_0, var_7_1)
	end
end

function var_0_0.onDelayPlayOpen(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onDelayPlayOpen, arg_8_0)
	arg_8_0._animator:Play("open", 0, 0)

	arg_8_0._animator.speed = 1
end

function var_0_0.checkCreateIcon(arg_9_0)
	if not arg_9_0.icon then
		local var_9_0 = arg_9_0._view.viewContainer:getSetting().otherRes[2]
		local var_9_1 = arg_9_0._view:getResInst(var_9_0, arg_9_0._gopos, "icon")

		arg_9_0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, Season123_2_1CelebrityCardEquip)

		arg_9_0.icon:setClickCall(arg_9_0.onClickSelf, arg_9_0)
	end
end

function var_0_0.onClickSelf(arg_10_0)
	if not Season123DecomposeModel.instance.curSelectItemDict[arg_10_0._mo.uid] and Season123DecomposeModel.instance:isSelectItemMaxCount() then
		GameFacade.showToast(ToastEnum.OverMaxCount)

		return
	end

	Season123DecomposeModel.instance:setCurSelectItemUid(arg_10_0._mo.uid)
	arg_10_0:refreshUI()
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnDecomposeItemSelect)
end

function var_0_0.showDecomposeEffect(arg_11_0)
	if Season123DecomposeModel.instance.curSelectItemDict[arg_11_0._mo.uid] then
		gohelper.setActive(arg_11_0._goDecomposeEffect, false)
		gohelper.setActive(arg_11_0._goDecomposeEffect, true)
	else
		arg_11_0:hideDecomposeEffect()
	end
end

function var_0_0.hideDecomposeEffect(arg_12_0)
	gohelper.setActive(arg_12_0._goDecomposeEffect, false)
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0.icon then
		arg_13_0.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(arg_13_0.onDelayPlayOpen, arg_13_0)
end

return var_0_0
