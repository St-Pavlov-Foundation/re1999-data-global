module("modules.logic.rouge.view.RougeCollectionListRow", package.seeall)

local var_0_0 = class("RougeCollectionListRow", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#txt_Title/#txt_TitleEn")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_title/#image_icon")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "#go_collectionitem")

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
	gohelper.setActive(arg_4_0._gocollectionitem, false)
	gohelper.setActive(arg_4_0._txtTitleEn, false)

	arg_4_0._itemList = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, RougeEnum.CollectionListRowNum do
		local var_4_0 = gohelper.cloneInPlace(arg_4_0._gocollectionitem)
		local var_4_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_0, RougeCollectionListItem)

		table.insert(arg_4_0._itemList, var_4_1)
	end

	arg_4_0._gridLayout = arg_4_0.viewGO:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._itemList) do
		iter_7_1:onUpdateMO(arg_7_1[iter_7_0])
	end

	local var_7_0 = arg_7_1.type ~= nil

	gohelper.setActive(arg_7_0._gotitle, var_7_0)

	local var_7_1 = arg_7_0._gridLayout.padding

	var_7_1.top = var_7_0 and 61 or 0
	arg_7_0._gridLayout.padding = var_7_1

	if not var_7_0 then
		return
	end

	local var_7_2 = RougeCollectionConfig.instance:getTagConfig(arg_7_1.type)

	if not var_7_2 then
		return
	end

	arg_7_0._txtTitle.text = var_7_2.name

	UISpriteSetMgr.instance:setRougeSprite(arg_7_0._imageicon, var_7_2.iconUrl)
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
