module("modules.logic.rouge.view.RougeDifficultyItem_Base", package.seeall)

local var_0_0 = class("RougeDifficultyItem_Base", RougeItemNodeBase)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_0.viewGO)
	arg_1_0._goNumList = arg_1_0:getUserDataTb_()
	arg_1_0._txtNumList = arg_1_0:getUserDataTb_()

	arg_1_0:_fillUserDataTb("_txtnum", arg_1_0._goNumList, arg_1_0._txtNumList)

	arg_1_0._goBgList = arg_1_0:getUserDataTb_()

	arg_1_0:_fillUserDataTb("_goBg", arg_1_0._goBgList)
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
	arg_4_0:dispatchEvent(RougeEvent.RougeDifficultyView_OnSelectIndex, arg_4_0:index())
end

function var_0_0.setData(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	local var_5_0 = arg_5_1.difficultyCO
	local var_5_1 = var_5_0.difficulty
	local var_5_2 = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(var_5_1)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._goNumList) do
		gohelper.setActive(iter_5_1, false)
	end

	gohelper.setActive(arg_5_0._goNumList[var_5_2], true)

	for iter_5_2, iter_5_3 in ipairs(arg_5_0._goBgList) do
		gohelper.setActive(iter_5_3, false)
	end

	gohelper.setActive(arg_5_0._goBgList[var_5_2], true)

	arg_5_0._txtNumList[var_5_2].text = var_5_1
	arg_5_0._txtname.text = var_5_0.title
	arg_5_0._txten.text = var_5_0.title_en
end

return var_0_0
