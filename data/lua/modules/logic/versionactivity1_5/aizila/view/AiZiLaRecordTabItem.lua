module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordTabItem", package.seeall)

local var_0_0 = class("AiZiLaRecordTabItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._txtLockedTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/image_Locked/#txt_LockedTitle")
	arg_1_0._goUnSelected = gohelper.findChild(arg_1_0.viewGO, "#go_UnSelected")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_UnSelected/image_UnSelected/#txt_Title")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Selected")
	arg_1_0._txtSelectTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_Selected/image_Selected/#txt_SelectTitle")
	arg_1_0._btnTabClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_TabClick")
	arg_1_0._goredPoint = gohelper.findChild(arg_1_0.viewGO, "#go_redPoint")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTabClick:AddClickListener(arg_2_0._btnTabClickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTabClick:RemoveClickListener()
end

function var_0_0._btnTabClickOnClick(arg_4_0)
	if arg_4_0._isUnLock and arg_4_0._mo then
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.UISelectRecordTabItem, arg_4_0._mo.id)
	else
		GameFacade.showToast(ToastEnum.V1a5AiZiLaRecordNotOpen)
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:refreshUI()
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	arg_9_0._isSelect = arg_9_1 and true or false

	gohelper.setActive(arg_9_0._goLocked, not arg_9_0._isUnLock)
	gohelper.setActive(arg_9_0._goUnSelected, arg_9_0._isUnLock and not arg_9_0._isSelect)
	gohelper.setActive(arg_9_0._goSelected, arg_9_0._isUnLock and arg_9_0._isSelect)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = arg_11_0._mo

	arg_11_0._isUnLock = true

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0.config.name

	if not var_11_0:isUnLock() then
		var_11_1 = luaLang("v1a5_aizila_unknown_question_mark")
	end

	arg_11_0._txtTitle.text = var_11_1
	arg_11_0._txtSelectTitle.text = var_11_1

	RedDotController.instance:addRedDot(arg_11_0._goredPoint, RedDotEnum.DotNode.V1a5AiZiLaRecordNew, var_11_0:getRedUid())
	arg_11_0:onSelect(arg_11_0._isSelect)
end

return var_0_0
