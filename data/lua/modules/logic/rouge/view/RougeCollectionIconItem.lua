module("modules.logic.rouge.view.RougeCollectionIconItem", package.seeall)

local var_0_0 = class("RougeCollectionIconItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._gogridcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_gridcontainer")
	arg_1_0._gogrid = gohelper.findChild(arg_1_0.viewGO, "#go_gridcontainer/#go_grid")
	arg_1_0._goholetool = gohelper.findChild(arg_1_0.viewGO, "#go_holetool")
	arg_1_0._goholeitem = gohelper.findChild(arg_1_0.viewGO, "#go_holetool/#go_holeitem")
	arg_1_0._gridList = arg_1_0:getUserDataTb_()

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

local var_0_1 = 46
local var_0_2 = 46

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(arg_4_1)

	arg_4_0._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_4_1))
	RougeCollectionHelper.loadShapeGrid(arg_4_1, arg_4_0._gogridcontainer, arg_4_0._gogrid, arg_4_0._gridList)
	gohelper.setActive(arg_4_0.viewGO, true)
end

function var_0_0.setPerCellSize(arg_5_0, arg_5_1, arg_5_2)
	RougeCollectionHelper.computeAndSetCollectionIconScale(arg_5_0._collectionCfg.id, arg_5_0._simageicon.transform, arg_5_1, arg_5_2)

	arg_5_0._perCellWidth = arg_5_1 or var_0_1
	arg_5_0._perCellHeight = arg_5_2 or var_0_2
end

function var_0_0.setCollectionIconSize(arg_6_0, arg_6_1, arg_6_2)
	recthelper.setSize(arg_6_0._simageicon.transform, arg_6_1, arg_6_2)
end

function var_0_0.setHolesVisible(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._goholetool, arg_7_1)
end

function var_0_0.destroy(arg_8_0)
	arg_8_0._simageicon:UnLoadImage()
	arg_8_0:__onDispose(arg_8_0)
end

return var_0_0
