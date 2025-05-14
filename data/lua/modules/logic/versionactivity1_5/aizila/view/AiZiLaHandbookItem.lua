module("modules.logic.versionactivity1_5.aizila.view.AiZiLaHandbookItem", package.seeall)

local var_0_0 = class("AiZiLaHandbookItem", AiZiLaGoodsItem)

function var_0_0._btnclickOnClick(arg_1_0)
	if arg_1_0._mo then
		AiZiLaHandbookListModel.instance:setSelect(arg_1_0._mo.itemId)
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.SelectItem)
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._canvasGroup = gohelper.onceAddComponent(arg_2_0.viewGO, gohelper.Type_CanvasGroup)
	arg_2_0._goimagerare = arg_2_0._imagerare.gameObject
	arg_2_0._goimageicon = arg_2_0._imageicon.gameObject
	arg_2_0._goimagecountBG = arg_2_0._imagecountBG.gameObject
	arg_2_0._lastGray = false
end

function var_0_0._editableAddEvents(arg_3_0)
	return
end

function var_0_0._editableRemoveEvents(arg_4_0)
	return
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	local var_5_0 = arg_5_1:getQuantity()

	arg_5_0._txtcount.text = var_5_0

	arg_5_0:_refreshIcon(arg_5_1.itemId)
	arg_5_0:_refreshGray(not AiZiLaModel.instance:isCollectItemId(arg_5_1.itemId))
end

function var_0_0._refreshGray(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 and true or false

	if arg_6_0._lastGray ~= var_6_0 then
		arg_6_0._lastGray = var_6_0
		arg_6_0._canvasGroup.alpha = var_6_0 and 0.75 or 1

		arg_6_0:_setGrayMode(arg_6_0._goimagerare, var_6_0)
		arg_6_0:_setGrayMode(arg_6_0._goimageicon, var_6_0)
		arg_6_0:_setGrayMode(arg_6_0._goimagecountBG, var_6_0)
	end
end

function var_0_0._setGrayMode(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 then
		ZProj.UGUIHelper.SetGrayFactor(arg_7_1, 0.8)
	else
		ZProj.UGUIHelper.SetGrayscale(arg_7_1, false)
	end
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
