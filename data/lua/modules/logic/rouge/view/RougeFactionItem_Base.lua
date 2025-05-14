module("modules.logic.rouge.view.RougeFactionItem_Base", package.seeall)

local var_0_0 = class("RougeFactionItem_Base", RougeItemNodeBase)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_0._goBg)
end

function var_0_0.addEventListeners(arg_2_0)
	RougeItemNodeBase.addEventListeners(arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	RougeItemNodeBase.removeEventListeners(arg_3_0)
	GameUtil.onDestroyViewMember_ClickListener(arg_3_0, "_itemClick")
end

function var_0_0._onItemClick(arg_4_0)
	local var_4_0 = arg_4_0:staticData()

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0.baseViewContainer

	if not var_4_1 then
		return
	end

	var_4_1:dispatchEvent(RougeEvent.RougeFactionView_OnSelectIndex, arg_4_0:index())
end

function var_0_0.setData(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	local var_5_0 = arg_5_1.styleCO

	arg_5_0._txtname.text = var_5_0.name
	arg_5_0._txtscrollDesc.text = var_5_0.desc

	UISpriteSetMgr.instance:setRouge2Sprite(arg_5_0._imageicon, var_5_0.icon)
end

function var_0_0.difficulty(arg_6_0)
	return arg_6_0:parent():difficulty()
end

return var_0_0
