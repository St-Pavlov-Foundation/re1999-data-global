module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordItem", package.seeall)

local var_0_0 = class("AiZiLaRecordItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtEventTitle = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_EventTitle")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_EventTitle/#txt_TitleEn")
	arg_1_0._goredPoint = gohelper.findChild(arg_1_0.viewGO, "Title/#go_redPoint")
	arg_1_0._txtEventDesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_EventDesc")
	arg_1_0._goOption = gohelper.findChild(arg_1_0.viewGO, "#go_Option")
	arg_1_0._txtOptionTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_Option/#txt_OptionTitle")
	arg_1_0._txtOptionDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_Option/#txt_OptionDesc")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._txtLocked = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#txt_Locked")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	arg_7_0:refreshUI()
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = arg_10_0._mo

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0:getFinishedEventMO()
	local var_10_2 = var_10_1 and true or false

	gohelper.setActive(arg_10_0._goOption, var_10_2)
	gohelper.setActive(arg_10_0._txtEventDesc, var_10_2)
	gohelper.setActive(arg_10_0._goLocked, not var_10_2)

	if var_10_2 then
		arg_10_0:_refreshUnLockUI(var_10_1)
	else
		arg_10_0._txtEventTitle.text = luaLang("v1a5_aizila_unknown_question_mark")
		arg_10_0._txtLocked.text = var_10_0:getLockDesc()
	end
end

function var_0_0._refreshUnLockUI(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.config

	arg_11_0._txtEventTitle.text = GameUtil.setFirstStrSize(var_11_0.name, 60)
	arg_11_0._txtEventDesc.text = var_11_0.desc

	local var_11_1 = arg_11_1:getSelectOptionCfg()

	arg_11_0._txtOptionTitle.text = var_11_1.name
	arg_11_0._txtOptionDesc.text = var_11_1.optionDesc
end

return var_0_0
