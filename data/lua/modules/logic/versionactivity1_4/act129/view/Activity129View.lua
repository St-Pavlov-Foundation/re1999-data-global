module("modules.logic.versionactivity1_4.act129.view.Activity129View", package.seeall)

local var_0_0 = class("Activity129View", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.simageBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")

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
	arg_4_0.simageBg:LoadImage("singlebg/v1a4_tokenstore_singlebg/v1a4_tokenstore_fullbg1.png")
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.actId = arg_6_0.viewParam.actId

	Activity129Rpc.instance:sendGet129InfosRequest(arg_6_0.actId)
	ActivityEnterMgr.instance:enterActivity(arg_6_0.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		arg_6_0.actId
	})
end

function var_0_0.onClose(arg_7_0)
	Activity129Model.instance:setSelectPoolId(nil, true)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0.simageBg:UnLoadImage()
end

return var_0_0
