module("modules.logic.rouge.dlc.103.view.RougeMapView_1_103", package.seeall)

local var_0_0 = class("RougeMapView_1_103", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godistotrule = gohelper.findChild(arg_1_0.viewGO, "Left/#go_distortrule")
	arg_1_0._godistotrule2 = gohelper.findChild(arg_1_0.viewGO, "#go_layer_right/#go_rougedistortrule")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:openSubView(RougeMapAttributeComp, nil, arg_2_0._godistotrule)
	arg_2_0:openSubView(RougeMapBossCollectionComp, nil, arg_2_0._godistotrule2)
end

function var_0_0.onClose(arg_3_0)
	return
end

return var_0_0
