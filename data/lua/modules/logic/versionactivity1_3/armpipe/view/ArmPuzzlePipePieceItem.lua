module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipePieceItem", package.seeall)

local var_0_0 = class("ArmPuzzlePipePieceItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "go_content")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "go_content/image_icon")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "go_content/image_NumBG/txt_Num")
	arg_1_0._txtNumZero = gohelper.findChildText(arg_1_0.viewGO, "go_content/image_NumBG/txt_NumZero")

	arg_1_0:_editableInitView()
end

function var_0_0.addEventListeners(arg_2_0)
	if arg_2_0._btnUIdrag then
		arg_2_0._btnUIdrag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
		arg_2_0._btnUIdrag:AddDragListener(arg_2_0._onDragIng, arg_2_0)
		arg_2_0._btnUIdrag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	end
end

function var_0_0.removeEventListeners(arg_3_0)
	if arg_3_0._btnUIdrag then
		arg_3_0._btnUIdrag:RemoveDragBeginListener()
		arg_3_0._btnUIdrag:RemoveDragListener()
		arg_3_0._btnUIdrag:RemoveDragEndListener()
	end
end

function var_0_0.onStart(arg_4_0)
	return
end

function var_0_0.onDestroy(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._btnUIdrag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._gocontent)
end

function var_0_0._onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._isStarDrag = false

	if arg_7_0:_getPlaceNum() > 0 then
		arg_7_0._isStarDrag = true

		ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragBegin, arg_7_2.position, arg_7_0._typeId, ArmPuzzlePipeEnum.ruleConnect[arg_7_0._typeId])
	end
end

function var_0_0._onDragIng(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._isStarDrag then
		ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragIng, arg_8_2.position)
	end
end

function var_0_0._onDragEnd(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._isStarDrag then
		arg_9_0._isStarDrag = false

		ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragEnd, arg_9_2.position)
	end
end

function var_0_0.setTypeId(arg_10_0, arg_10_1)
	arg_10_0._typeId = arg_10_1
end

function var_0_0.initItem(arg_11_0, arg_11_1)
	return
end

function var_0_0._getPlaceNum(arg_12_0)
	return ArmPuzzlePipeModel.instance:getPlaceNum(arg_12_0._typeId)
end

function var_0_0.refreshUI(arg_13_0)
	local var_13_0 = arg_13_0:_getPlaceNum()
	local var_13_1 = var_13_0 <= 0

	if not var_13_1 then
		arg_13_0._txtNum.text = var_13_0
	else
		arg_13_0._txtNumZero.text = var_13_0
	end

	local var_13_2 = var_13_1 and ArmPuzzlePipeEnum.UIDragEmptyRes[arg_13_0._typeId] or ArmPuzzlePipeEnum.UIDragRes[arg_13_0._typeId]

	UISpriteSetMgr.instance:setArmPipeSprite(arg_13_0._imageicon, var_13_2, true)

	if arg_13_0._isLastZero ~= var_13_1 then
		arg_13_0._isLastZero = var_13_1

		gohelper.setActive(arg_13_0._txtNum, not var_13_1)
		gohelper.setActive(arg_13_0._txtNumZero, var_13_1)
	end
end

return var_0_0
