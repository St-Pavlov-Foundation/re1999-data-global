module("modules.logic.rouge.view.RougeFactionItemLocked", package.seeall)

local var_0_0 = class("RougeFactionItemLocked", RougeFactionItem_Base)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBg = gohelper.findChild(arg_1_0.viewGO, "#go_Bg")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "#txt_name/#txt_en")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._txtscrollDesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/viewport/content/#txt_scrollDesc")
	arg_1_0._txtlocked = gohelper.findChildText(arg_1_0.viewGO, "bg/#txt_locked")

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
	RougeFactionItem_Base._editableInitView(arg_4_0)

	local var_4_0 = arg_4_0._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	arg_4_0:_onSetScrollParentGameObject(var_4_0)

	arg_4_0._txtlocked.text = ""
end

function var_0_0._onItemClick(arg_5_0)
	return
end

function var_0_0.onDestroyView(arg_6_0)
	RougeFactionItem_Base.onDestroyView(arg_6_0)
end

function var_0_0.setData(arg_7_0, arg_7_1)
	RougeFactionItem_Base.setData(arg_7_0, arg_7_1)

	local var_7_0 = arg_7_1.styleCO
	local var_7_1 = RougeOutsideModel.instance:config()

	arg_7_0._txtlocked.text = var_7_1:getStyleLockDesc(var_7_0.id)
end

return var_0_0
