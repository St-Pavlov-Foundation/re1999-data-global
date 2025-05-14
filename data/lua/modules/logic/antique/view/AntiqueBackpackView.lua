module("modules.logic.antique.view.AntiqueBackpackView", package.seeall)

local var_0_0 = class("AntiqueBackpackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollantique = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_antique")

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
	arg_4_0._ani = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.viewContainer:setCurrentSelectCategoryId(ItemEnum.CategoryType.Antique)

	arg_6_0._ani.enabled = #arg_6_0.tabContainer._tabAbLoaders < 2
	arg_6_0._scrollantique.verticalNormalizedPosition = 1

	arg_6_0:refreshAntique()
end

function var_0_0.refreshAntique(arg_7_0)
	local var_7_0 = AntiqueModel.instance:getAntiqueList()
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		table.insert(var_7_1, iter_7_1)
	end

	AntiqueBackpackListModel.instance:setAntiqueList(var_7_1)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	AntiqueBackpackListModel.instance:clearAntiqueList()
end

return var_0_0
