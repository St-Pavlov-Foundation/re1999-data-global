module("modules.logic.versionactivity1_9.fairyland.controller.FairyLandController", package.seeall)

local var_0_0 = class("FairyLandController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.openFairyLandView(arg_3_0, arg_3_1)
	arg_3_0.viewParam = arg_3_1

	if FairyLandModel.instance.hasInfo then
		arg_3_0:_openView()
	else
		FairyLandRpc.instance:sendGetFairylandInfoRequest(arg_3_0._openView, arg_3_0)
	end
end

function var_0_0._openView(arg_4_0)
	if FairyLandModel.instance:isFinishFairyLand() then
		arg_4_0:checkFinishFairyLandElement()

		return
	end

	ViewMgr.instance:openView(ViewName.FairyLandView, arg_4_0.viewParam)
end

function var_0_0.checkFinishFairyLandElement(arg_5_0)
	if not DungeonMapModel.instance:elementIsFinished(FairyLandEnum.ElementId) then
		DungeonRpc.instance:sendMapElementRequest(FairyLandEnum.ElementId)
	end
end

function var_0_0.openDialogView(arg_6_0, arg_6_1)
	var_0_0.instance:dispatchEvent(FairyLandEvent.ShowDialogView, arg_6_1)
end

function var_0_0.closeDialogView(arg_7_0)
	var_0_0.instance:dispatchEvent(FairyLandEvent.CloseDialogView)
end

function var_0_0.openCompleteView(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = FairyLandEnum.Puzzle2ShapeType[arg_8_1]

	if var_8_0 then
		ViewMgr.instance:openView(ViewName.FairyLandCompleteView, {
			shapeType = var_8_0,
			callback = arg_8_2,
			callbackObj = arg_8_3
		})
	elseif arg_8_2 then
		arg_8_2(arg_8_3)
	end
end

function var_0_0.endFairyLandStory()
	var_0_0.instance:checkFinishFairyLandElement()
end

var_0_0.instance = var_0_0.New()

return var_0_0
