module("modules.logic.equip.view.EquipSkillLevelUpView", package.seeall)

local var_0_0 = class("EquipSkillLevelUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtcurleveldesc2 = gohelper.findChildText(arg_1_0.viewGO, "#go_rootinfo/info/curleveldesc/#go_curbaseskill/#txt_curleveldesc2")
	arg_1_0._txtnextleveldesc2 = gohelper.findChildText(arg_1_0.viewGO, "#go_rootinfo/info/nextleveldesc/#go_nextbaseskill/#txt_nextleveldesc2")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gocurbaseskill = gohelper.findChild(arg_1_0.viewGO, "#go_rootinfo/info/curleveldesc/#go_curbaseskill")
	arg_1_0._txtcurlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_rootinfo/info/curleveldesc/#txt_curlevel")
	arg_1_0._gonextbaseskill = gohelper.findChild(arg_1_0.viewGO, "#go_rootinfo/info/nextleveldesc/#go_nextbaseskill")
	arg_1_0._txtnextlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_rootinfo/info/nextleveldesc/#txt_nextlevel")
	arg_1_0._gorootinfo = gohelper.findChild(arg_1_0.viewGO, "#go_rootinfo")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	EquipController.instance:dispatchEvent(EquipEvent.onCloseEquipLevelUpView)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._txtcurleveldesc2.gameObject, false)
	gohelper.setActive(arg_5_0._txtnextleveldesc2.gameObject, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._equip_mo = arg_7_0.viewParam[1]
	arg_7_0.last_refine_lv = arg_7_0.viewParam[2]
	arg_7_0._txtcurlevel.text = "<size=22>Lv.</size>" .. arg_7_0.last_refine_lv
	arg_7_0._txtnextlevel.text = "<size=22>Lv.</size>" .. arg_7_0._equip_mo.refineLv

	local var_7_0 = {
		rootGo = arg_7_0._gocurbaseskill,
		txtBaseDes = arg_7_0._txtcurleveldesc2,
		skillType = arg_7_0._equip_mo.equipId,
		refineLv = arg_7_0.last_refine_lv
	}
	local var_7_1 = {
		rootGo = arg_7_0._gonextbaseskill,
		txtBaseDes = arg_7_0._txtnextleveldesc2,
		skillType = arg_7_0._equip_mo.equipId,
		refineLv = arg_7_0._equip_mo.refineLv
	}

	arg_7_0:_showBaseSkillDes(var_7_0)
	arg_7_0:_showBaseSkillDes(var_7_1)
end

function var_0_0._showBaseSkillDes(arg_8_0, arg_8_1)
	local var_8_0 = EquipHelper.getEquipSkillDescList(arg_8_1.skillType, arg_8_1.refineLv, "#D9A06F")

	if #var_8_0 == 0 then
		gohelper.setActive(arg_8_1.rootGo, false)
	else
		gohelper.setActive(arg_8_1.rootGo, true)

		local var_8_1
		local var_8_2

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			local var_8_3 = gohelper.cloneInPlace(arg_8_1.txtBaseDes.gameObject, "item_" .. iter_8_0):GetComponent(gohelper.Type_TextMesh)

			var_8_3.text = iter_8_1

			gohelper.setActive(var_8_3.gameObject, true)
		end
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
