module("modules.logic.backpack.controller.BackpackController", package.seeall)

local var_0_0 = class("BackpackController", BaseController)

var_0_0.BackpackViewTabContainerId = 2

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	arg_3_0:registerCallback(BackpackEvent.SelectCategoryById, arg_3_0._onSelectCategoryById, arg_3_0)
end

function var_0_0._onSelectCategoryById(arg_4_0, arg_4_1)
	arg_4_0._selectCategoryType = tonumber(arg_4_1)
end

function var_0_0.enterItemBackpack(arg_5_0, arg_5_1)
	local var_5_0 = {
		cateList = arg_5_0:getCategoryCoList(),
		itemList = BackpackModel.instance:getBackpackList()
	}

	if arg_5_0._selectCategoryType then
		arg_5_1 = arg_5_1 or arg_5_0._selectCategoryType
	end

	arg_5_0._selectCategoryType = nil
	arg_5_1 = arg_5_1 or ItemEnum.CategoryType.Material

	BackpackModel.instance:setCurCategoryId(arg_5_1)
	BackpackModel.instance:setBackpackItemList(var_5_0.itemList)
	BackpackModel.instance:setBackpackCategoryList(var_5_0.cateList)
	BackpackCategoryListModel.instance:setCategoryList(var_5_0.cateList)

	local var_5_1 = BackpackModel.instance:getCurCategoryId()
	local var_5_2 = BackpackModel.instance:getCategoryItemlist(var_5_1)

	BackpackPropListModel.instance:setCategoryPropItemList(var_5_2)

	local var_5_3 = {
		data = var_5_0
	}

	var_5_3.isJump = true

	if arg_5_1 == ItemEnum.CategoryType.Equip then
		var_5_3.defaultTabIds = {}
		var_5_3.defaultTabIds[var_0_0.BackpackViewTabContainerId] = 2
	elseif arg_5_1 == ItemEnum.CategoryType.Antique then
		-- block empty
	end

	ViewMgr.instance:openView(ViewName.BackpackView, var_5_3)
end

function var_0_0.getCategoryCoList(arg_6_0)
	local var_6_0 = tabletool.copy(BackpackConfig.instance:getCategoryCO())

	table.remove(var_6_0, 1)

	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Equip) then
		local var_6_1 = {
			id = ItemEnum.CategoryType.Equip,
			name = luaLang("equip")
		}

		var_6_1.subname = "PSYCHUBE"

		table.insert(var_6_0, var_6_1)
	end

	if AntiqueModel.instance:isAntiqueUnlock() then
		local var_6_2 = {
			id = ItemEnum.CategoryType.Antique,
			name = luaLang("antique")
		}

		var_6_2.subname = "Collections"

		table.insert(var_6_0, var_6_2)
	end

	return var_6_0
end

function var_0_0.reInit(arg_7_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
