module("modules.logic.season.view1_6.Season1_6EquipComposeItem", package.seeall)

local var_0_0 = class("Season1_6EquipComposeItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gopos = gohelper.findChild(arg_1_0.viewGO, "go_pos")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0._simageroleicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "image_roleicon")
	arg_1_0._gorolebg = gohelper.findChild(arg_1_0.viewGO, "bg")
	arg_1_0._imageroleicon = gohelper.findChildImage(arg_1_0.viewGO, "image_roleicon")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1.originMO
	arg_2_0._listMO = arg_2_1
	arg_2_0._cfg = SeasonConfig.instance:getSeasonEquipCo(arg_2_0._mo.itemId)

	if arg_2_0._cfg then
		arg_2_0:refreshUI()
	end

	arg_2_0:checkPlayAnim()
end

function var_0_0.refreshUI(arg_3_0)
	arg_3_0:checkCreateIcon()
	arg_3_0.icon:updateData(arg_3_0._cfg.equipId)

	local var_3_0 = Activity104EquipItemComposeModel.instance:getSelectedRare()
	local var_3_1 = var_3_0 ~= nil and var_3_0 ~= arg_3_0._cfg.rare

	arg_3_0.icon:setColorDark(var_3_1)
	arg_3_0:setRoleIconDark(var_3_1)
	gohelper.setActive(arg_3_0._goselect, Activity104EquipItemComposeModel.instance:isEquipSelected(arg_3_0._mo.uid))

	local var_3_2 = Activity104EquipItemComposeModel.instance:getEquipedHeroUid(arg_3_0._mo.uid)

	arg_3_0:refreshEquipedHero(var_3_2)
end

function var_0_0.setRoleIconDark(arg_4_0, arg_4_1)
	if arg_4_1 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._imageroleicon, "#7b7b7b")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._imageroleicon, "#ffffff")
	end
end

function var_0_0.refreshEquipedHero(arg_5_0, arg_5_1)
	if not arg_5_1 or arg_5_1 == Activity104EquipItemComposeModel.EmptyUid then
		gohelper.setActive(arg_5_0._simageroleicon, false)
		gohelper.setActive(arg_5_0._gorolebg, false)

		return
	end

	local var_5_0

	if arg_5_1 == Activity104EquipItemComposeModel.MainRoleHeroUid then
		var_5_0 = Activity104Enum.MainRoleHeadIconID
	else
		local var_5_1 = HeroModel.instance:getById(arg_5_1)

		if not var_5_1 then
			gohelper.setActive(arg_5_0._simageroleicon, false)
			gohelper.setActive(arg_5_0._gorolebg, false)

			return
		end

		var_5_0 = var_5_1.skin
	end

	gohelper.setActive(arg_5_0._simageroleicon, true)
	gohelper.setActive(arg_5_0._gorolebg, true)
	arg_5_0._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(var_5_0))
end

var_0_0.ColumnCount = 6
var_0_0.AnimRowCount = 4
var_0_0.OpenAnimTime = 0.06
var_0_0.OpenAnimStartTime = 0.05

function var_0_0.checkPlayAnim(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onDelayPlayOpen, arg_6_0)

	local var_6_0 = Activity104EquipItemComposeModel.instance:getDelayPlayTime(arg_6_0._listMO)

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

		arg_8_0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, Season1_6CelebrityCardEquip)

		arg_8_0.icon:setClickCall(arg_8_0.onClickSelf, arg_8_0)
		arg_8_0.icon:setLongPressCall(arg_8_0.onLongPress, arg_8_0)
	end
end

function var_0_0.onClickSelf(arg_9_0)
	if arg_9_0._mo then
		Activity104EquipComposeController.instance:changeSelectCard(arg_9_0._mo.uid)
	end
end

function var_0_0.onLongPress(arg_10_0)
	local var_10_0 = {
		actId = arg_10_0._view.viewParam.actId
	}

	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.EquipCard, arg_10_0._cfg.equipId, var_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0.icon then
		arg_11_0.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(arg_11_0.onDelayPlayOpen, arg_11_0)
end

return var_0_0
