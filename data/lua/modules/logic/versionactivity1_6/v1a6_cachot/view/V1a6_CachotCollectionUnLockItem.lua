module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionUnLockItem", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionUnLockItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_collection")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "top/#txt_name")

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

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	local var_6_0 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_6_0._mo.id)

	if var_6_0 then
		arg_6_0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_6_0.icon))

		arg_6_0._txtname.text = tostring(var_6_0.name)
	end
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagecollection:UnLoadImage()
end

return var_0_0
