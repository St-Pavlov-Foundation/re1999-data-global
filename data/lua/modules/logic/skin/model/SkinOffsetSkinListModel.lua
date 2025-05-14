module("modules.logic.skin.model.SkinOffsetSkinListModel", package.seeall)

local var_0_0 = class("SkinOffsetSkinListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.selectSkinIndex = 0
	arg_1_0.selectSkin = 0
end

function var_0_0.setScrollView(arg_2_0, arg_2_1)
	arg_2_0.scrollView = arg_2_1
end

function var_0_0.initOriginSkinList(arg_3_0)
	arg_3_0._originSkinCoList = {}

	for iter_3_0, iter_3_1 in ipairs(lua_skin.configList) do
		if iter_3_1.characterId > 0 then
			table.insert(arg_3_0._originSkinCoList, iter_3_1)
		end
	end
end

function var_0_0.initSkinList(arg_4_0)
	arg_4_0._skinList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._originSkinCoList) do
		if iter_4_1.characterId > 0 then
			if arg_4_0.filterFunc then
				if arg_4_0.filterFunc(iter_4_1) then
					table.insert(arg_4_0._skinList, {
						skinId = iter_4_1.id,
						skinName = iter_4_1.name
					})
				end
			else
				table.insert(arg_4_0._skinList, {
					skinId = iter_4_1.id,
					skinName = iter_4_1.name
				})
			end
		end
	end

	arg_4_0:refreshList()
	arg_4_0.scrollView:setSkinScrollRectVertical(1 - arg_4_0.selectSkinIndex / #arg_4_0._originSkinCoList)
end

function var_0_0.slideNext(arg_5_0)
	arg_5_0.selectSkinIndex = arg_5_0.selectSkinIndex + 1

	if arg_5_0.selectSkinIndex > #arg_5_0._skinList then
		arg_5_0.selectSkinIndex = 1
	end

	arg_5_0:refreshSelectByIndex(arg_5_0.selectSkinIndex)
end

function var_0_0.slidePre(arg_6_0)
	arg_6_0.selectSkinIndex = arg_6_0.selectSkinIndex - 1

	if arg_6_0.selectSkinIndex < 1 then
		arg_6_0.selectSkinIndex = #arg_6_0._skinList
	end

	arg_6_0:refreshSelectByIndex(arg_6_0.selectSkinIndex)
end

function var_0_0.refreshSelectByIndex(arg_7_0, arg_7_1)
	arg_7_0:setSelectSkin(arg_7_0._skinList[arg_7_1].skinId)
end

function var_0_0.setSelectSkin(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._skinList) do
		if iter_8_1.skinId == arg_8_1 then
			arg_8_0.selectSkinIndex = iter_8_0
			arg_8_0.selectSkin = arg_8_1

			arg_8_0.scrollView.viewContainer.skinOffsetAdjustView:refreshSkin({
				skinId = arg_8_1,
				skinName = iter_8_1.skinName
			})
			SkinOffsetController.instance:dispatchEvent(SkinOffsetController.Event.OnSelectSkinChange)

			return
		end
	end

	logError(string.format("not found skinId : %s index", arg_8_1))
end

function var_0_0.isSelect(arg_9_0, arg_9_1)
	return arg_9_0.selectSkin == arg_9_1
end

function var_0_0.filterById(arg_10_0, arg_10_1)
	arg_10_0._skinList = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._originSkinCoList) do
		if iter_10_1.characterId > 0 and string.match(tostring(iter_10_1.id), arg_10_1) then
			if arg_10_0.filterFunc then
				if arg_10_0.filterFunc(iter_10_1) then
					table.insert(arg_10_0._skinList, {
						skinId = iter_10_1.id,
						skinName = iter_10_1.name
					})
				end
			else
				table.insert(arg_10_0._skinList, {
					skinId = iter_10_1.id,
					skinName = iter_10_1.name
				})
			end
		end
	end

	arg_10_0:refreshList()
end

function var_0_0.filterByName(arg_11_0, arg_11_1)
	arg_11_0._skinList = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._originSkinCoList) do
		if iter_11_1.characterId > 0 and string.match(iter_11_1.name, arg_11_1) then
			if arg_11_0.filterFunc then
				if arg_11_0.filterFunc(iter_11_1) then
					table.insert(arg_11_0._skinList, {
						skinId = iter_11_1.id,
						skinName = iter_11_1.name
					})
				end
			else
				table.insert(arg_11_0._skinList, {
					skinId = iter_11_1.id,
					skinName = iter_11_1.name
				})
			end
		end
	end

	arg_11_0:refreshList()
end

function var_0_0.setInitFilterFunc(arg_12_0, arg_12_1)
	arg_12_0.filterFunc = arg_12_1
end

function var_0_0.getFirst(arg_13_0)
	return arg_13_0._skinList[1]
end

function var_0_0.refreshList(arg_14_0)
	arg_14_0:setList(arg_14_0._skinList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
