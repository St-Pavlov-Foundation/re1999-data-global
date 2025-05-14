module("modules.logic.player.view.WaterMarkView", package.seeall)

local var_0_0 = class("WaterMarkView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goWaterMarkTemplate = gohelper.findChild(arg_1_0.viewGO, "#txt_template")

	gohelper.setActive(arg_1_0.goWaterMarkTemplate, false)

	arg_1_0.goWaterMarkList = arg_1_0:getUserDataTb_()

	local var_1_0 = ViewMgr.instance:getUILayer(UILayerName.IDCanvasPopUp)

	arg_1_0.maxWidth, arg_1_0.maxHeight = recthelper.getWidth(var_1_0.transform), recthelper.getHeight(var_1_0.transform)
	arg_1_0.wInterval, arg_1_0.hInterval = 200, 50
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:updateWaterMark(arg_2_0.viewParam.userId)
end

function var_0_0.updateWaterMark(arg_3_0, arg_3_1)
	if arg_3_1 == arg_3_0.userId then
		return
	end

	arg_3_0.userId = arg_3_1

	local var_3_0 = arg_3_0.wInterval
	local var_3_1 = arg_3_0.hInterval
	local var_3_2
	local var_3_3
	local var_3_4 = 0

	while var_3_1 <= arg_3_0.maxHeight do
		var_3_4 = var_3_4 + 1

		local var_3_5 = arg_3_0.goWaterMarkList[var_3_4]

		if not var_3_5 then
			var_3_5 = gohelper.cloneInPlace(arg_3_0.goWaterMarkTemplate):GetComponent(gohelper.Type_TextMesh)

			table.insert(arg_3_0.goWaterMarkList, var_3_5)
		end

		gohelper.setActive(var_3_5.gameObject, true)

		var_3_5.text = arg_3_0.userId
		var_3_5.color = var_3_4 % 2 == 0 and Color.New(1, 1, 1, 0.16) or Color.New(0, 0, 0, 0.16)

		recthelper.setAnchor(var_3_5.gameObject.transform, var_3_0, var_3_1)
		transformhelper.setLocalRotation(var_3_5.gameObject.transform, 0, 0, -25)

		var_3_1 = var_3_1 + arg_3_0.hInterval
		var_3_0 = var_3_0 + arg_3_0.wInterval

		if var_3_0 >= arg_3_0.maxWidth then
			var_3_0 = var_3_0 - arg_3_0.maxWidth
		end
	end

	for iter_3_0 = var_3_4 + 1, #arg_3_0.goWaterMarkList do
		gohelper.setActive(arg_3_0.goWaterMarkList[iter_3_0].gameObject, false)
	end
end

function var_0_0.hideWaterMark(arg_4_0)
	gohelper.setActive(arg_4_0.viewGO, false)
end

function var_0_0.showWaterMark(arg_5_0)
	gohelper.setActive(arg_5_0.viewGO, true)
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0.goWaterMarkList = nil
end

return var_0_0
