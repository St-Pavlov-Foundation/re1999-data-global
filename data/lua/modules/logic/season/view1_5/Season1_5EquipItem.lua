module("modules.logic.season.view1_5.Season1_5EquipItem", package.seeall)

local var_0_0 = class("Season1_5EquipItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gopos = gohelper.findChild(arg_1_0.viewGO, "go_pos")
	arg_1_0._gorole = gohelper.findChild(arg_1_0.viewGO, "go_role")
	arg_1_0._simageroleicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_role/image_roleicon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "#go_new")
	arg_1_0._gocount = gohelper.findChild(arg_1_0.viewGO, "go_count")
	arg_1_0._txtcountvalue = gohelper.findChildText(arg_1_0.viewGO, "go_count/bg/#txt_countvalue")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._imageroleicon = gohelper.findChildImage(arg_1_0.viewGO, "go_role/image_roleicon")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._uid = arg_4_1.id
	arg_4_0._itemId = arg_4_1.itemId

	arg_4_0:refreshUI()
	arg_4_0:checkPlayAnim()
end

var_0_0.ColumnCount = 6
var_0_0.AnimRowCount = 4
var_0_0.OpenAnimTime = 0.06
var_0_0.OpenAnimStartTime = 0.05

function var_0_0.checkPlayAnim(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.onDelayPlayOpen, arg_5_0)

	local var_5_0 = Activity104EquipItemListModel.instance:getDelayPlayTime(arg_5_0._mo)

	if var_5_0 == -1 then
		arg_5_0._animator:Play("idle", 0, 0)

		arg_5_0._animator.speed = 1
	else
		arg_5_0._animator:Play("open", 0, 0)

		arg_5_0._animator.speed = 0

		TaskDispatcher.runDelay(arg_5_0.onDelayPlayOpen, arg_5_0, var_5_0)
	end
end

function var_0_0.onDelayPlayOpen(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onDelayPlayOpen, arg_6_0)
	arg_6_0._animator:Play("open", 0, 0)

	arg_6_0._animator.speed = 1
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = arg_7_0._uid
	local var_7_1 = Activity104EquipItemListModel.isTrialEquip(var_7_0)

	arg_7_0:refreshIcon(arg_7_0._itemId, var_7_0)

	local var_7_2, var_7_3 = Activity104EquipItemListModel.instance:getItemEquipedPos(var_7_0)

	gohelper.setActive(arg_7_0._goselect, Activity104EquipItemListModel.instance:isItemUidInShowSlot(var_7_0))
	gohelper.setActive(arg_7_0._gonew, not var_7_1 and not Activity104EquipItemListModel.instance.recordNew:contain(var_7_0))

	if var_7_2 == nil then
		gohelper.setActive(arg_7_0._gorole, false)
	else
		local var_7_4 = Activity104EquipItemListModel.instance:getPosHeroUid(var_7_2)

		if var_7_4 ~= nil and var_7_4 ~= Activity104EquipItemListModel.EmptyUid then
			arg_7_0:refreshEquipedHero(var_7_4)
		else
			gohelper.setActive(arg_7_0._gorole, false)
		end
	end

	arg_7_0:refreshDeckCount()
end

function var_0_0.refreshDeckCount(arg_8_0)
	local var_8_0 = arg_8_0._uid
	local var_8_1, var_8_2 = Activity104EquipItemListModel.instance:getNeedShowDeckCount(var_8_0)

	gohelper.setActive(arg_8_0._gocount, var_8_1)

	if var_8_1 then
		arg_8_0._txtcountvalue.text = luaLang("multiple") .. tostring(var_8_2)
	end
end

function var_0_0.refreshEquipedHero(arg_9_0, arg_9_1)
	local var_9_0 = HeroModel.instance:getById(arg_9_1) or HeroGroupTrialModel.instance:getById(arg_9_1)

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0.skin

	gohelper.setActive(arg_9_0._gorole, true)
	arg_9_0._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(var_9_1))
end

function var_0_0.refreshIcon(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:checkCreateIcon()

	if arg_10_1 then
		arg_10_0.icon:updateData(arg_10_1)

		local var_10_0 = Activity104EquipItemListModel.instance:disableBecauseSameCard(arg_10_2)
		local var_10_1 = Activity104EquipItemListModel.instance:disableBecauseRole(arg_10_1)
		local var_10_2 = Activity104EquipItemListModel.instance:disableBecauseCareerNotFit(arg_10_1)
		local var_10_3 = var_10_0 or var_10_2 or var_10_1

		arg_10_0.icon:setColorDark(var_10_3)
		arg_10_0:setRoleIconDark(var_10_3)
	end
end

function var_0_0.checkCreateIcon(arg_11_0)
	if not arg_11_0.icon then
		local var_11_0 = arg_11_0._view.viewContainer:getSetting().otherRes[2]
		local var_11_1 = arg_11_0._view:getResInst(var_11_0, arg_11_0._gopos, "icon")

		arg_11_0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1, Season1_5CelebrityCardEquip)

		arg_11_0.icon:setClickCall(arg_11_0.onClickSelf, arg_11_0)
	end
end

function var_0_0.setRoleIconDark(arg_12_0, arg_12_1)
	if arg_12_1 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._imageroleicon, "#7b7b7b")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._imageroleicon, "#ffffff")
	end
end

function var_0_0.onClickSelf(arg_13_0)
	local var_13_0 = arg_13_0._uid

	logNormal("onClickSelf : " .. tostring(var_13_0))
	arg_13_0:checkClickNew(var_13_0)

	if arg_13_0:checkCanNotEquipWithToast(var_13_0) then
		return
	end

	if Activity104EquipItemListModel.instance.curEquipMap[Activity104EquipItemListModel.instance.curSelectSlot] == var_13_0 then
		return
	end

	Activity104EquipController.instance:equipItemOnlyShow(var_13_0)
end

function var_0_0.checkClickNew(arg_14_0, arg_14_1)
	if not Activity104EquipItemListModel.instance.recordNew:contain(arg_14_1) then
		Activity104EquipItemListModel.instance.recordNew:add(arg_14_1)
		gohelper.setActive(arg_14_0._gonew, false)
	end
end

var_0_0.Toast_Same_Card = 2851
var_0_0.Toast_Wrong_Type = 2852
var_0_0.Toast_MainRole_Wrong_Type = 2854
var_0_0.Toast_Other_Hero_Equiped = 2853
var_0_0.Toast_Career_Wrong = 2859
var_0_0.Toast_Slot_Lock = 67

function var_0_0.checkCanNotEquipWithToast(arg_15_0, arg_15_1)
	if Activity104EquipItemListModel.instance:slotIsLock(Activity104EquipItemListModel.instance.curSelectSlot) then
		GameFacade.showToast(var_0_0.Toast_Slot_Lock)

		return true
	end

	if Activity104EquipItemListModel.instance:disableBecauseSameCard(arg_15_1) then
		GameFacade.showToast(var_0_0.Toast_Same_Card)

		return true
	end

	local var_15_0 = Activity104EquipItemListModel.instance:getEquipMO(arg_15_1)

	if var_15_0 then
		if Activity104EquipItemListModel.instance:disableBecauseRole(var_15_0.itemId) then
			if Activity104EquipItemListModel.instance.curPos == Activity104EquipItemListModel.MainCharPos then
				GameFacade.showToast(var_0_0.Toast_MainRole_Wrong_Type)
			else
				GameFacade.showToast(var_0_0.Toast_Wrong_Type)
			end

			return true
		end

		if Activity104EquipItemListModel.instance:disableBecauseCareerNotFit(var_15_0.itemId) then
			GameFacade.showToast(var_0_0.Toast_Career_Wrong)

			return true
		end
	end

	return false
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0.icon then
		arg_16_0.icon:removeEventListeners()
		arg_16_0.icon:disposeUI()
	end
end

return var_0_0
