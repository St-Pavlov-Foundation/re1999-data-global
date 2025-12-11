module("modules.logic.survival.view.rewardinherit.survivalrewardselect.SurvivalRewardSelectCell", package.seeall)

local var_0_0 = class("SurvivalRewardSelectCell", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.viewContainer = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0._gobagitem = gohelper.findChild(arg_2_0.viewGO, "#go_bagitem")
	arg_2_0._goempty = gohelper.findChild(arg_2_0.viewGO, "#go_empty")
	arg_2_0.btnClick = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btnClick")

	local var_2_0 = arg_2_0.viewContainer:getSetting().otherRes.survivalmapbagitem
	local var_2_1 = arg_2_0.viewContainer:getResInst(var_2_0, arg_2_0._gobagitem)

	arg_2_0.survivalBagItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_1, SurvivalBagItem)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btnClick, arg_3_0.onClickBtnAdd, arg_3_0)
end

function var_0_0.onClickBtnAdd(arg_4_0)
	if arg_4_0.inheritId then
		ViewMgr.instance:openView(ViewName.SurvivalRewardSelectView)
	end
end

function var_0_0.setData(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0.viewGO, arg_5_1 ~= nil)

	if not arg_5_1 then
		return
	end

	arg_5_0.inheritId = arg_5_1.inheritId
	arg_5_0.itemId = arg_5_1.itemId

	if arg_5_0.itemId then
		gohelper.setActive(arg_5_0._goempty, false)
		gohelper.setActive(arg_5_0.survivalBagItem.go, true)

		local var_5_0 = SurvivalBagItemMo.New()

		var_5_0:init({
			id = arg_5_0.itemId,
			count = arg_5_1.count
		})
		arg_5_0.survivalBagItem:updateMo(var_5_0, {
			forceShowIcon = true
		})
	elseif arg_5_0.inheritId > 0 then
		gohelper.setActive(arg_5_0._goempty, arg_5_0.inheritId == nil)
		gohelper.setActive(arg_5_0.survivalBagItem.go, arg_5_0.inheritId ~= nil)

		if not arg_5_0.inheritId then
			return
		end

		arg_5_0.handbookMo = SurvivalRewardInheritModel.instance:getInheritMoByInheritIdId(arg_5_0.inheritId)
		arg_5_0.itemMo = arg_5_0.handbookMo:getSurvivalBagItemMo()

		arg_5_0.survivalBagItem:updateMo(arg_5_0.itemMo)
		arg_5_0.survivalBagItem:setTextName(false)
		arg_5_0.survivalBagItem:setShowNum(false)
	elseif arg_5_0.inheritId == -10 then
		gohelper.setActive(arg_5_0._goempty, true)
		gohelper.setActive(arg_5_0.survivalBagItem.go, false)
	end
end

return var_0_0
