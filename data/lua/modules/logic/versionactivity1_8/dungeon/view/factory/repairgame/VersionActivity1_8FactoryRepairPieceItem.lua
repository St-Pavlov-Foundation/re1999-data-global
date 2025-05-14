module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairPieceItem", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryRepairPieceItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "go_content")
	arg_1_0._btnContentDrag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._gocontent)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "go_content/image_icon")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "go_content/image_NumBG/txt_Num")
	arg_1_0._txtNumZero = gohelper.findChildText(arg_1_0.viewGO, "go_content/image_NumBG/txt_NumZero")
end

function var_0_0.setTypeId(arg_2_0, arg_2_1)
	arg_2_0._typeId = arg_2_1
end

function var_0_0.addEventListeners(arg_3_0)
	if arg_3_0._btnContentDrag then
		arg_3_0._btnContentDrag:AddDragBeginListener(arg_3_0._onDragBegin, arg_3_0)
		arg_3_0._btnContentDrag:AddDragListener(arg_3_0._onDragIng, arg_3_0)
		arg_3_0._btnContentDrag:AddDragEndListener(arg_3_0._onDragEnd, arg_3_0)
	end
end

function var_0_0.removeEventListeners(arg_4_0)
	if arg_4_0._btnContentDrag then
		arg_4_0._btnContentDrag:RemoveDragBeginListener()
		arg_4_0._btnContentDrag:RemoveDragListener()
		arg_4_0._btnContentDrag:RemoveDragEndListener()
	end
end

function var_0_0._onDragBegin(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._isStarDrag = false

	if arg_5_0:_getPlaceNum() > 0 then
		arg_5_0._isStarDrag = true

		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragBegin, arg_5_2.position, arg_5_0._typeId, ArmPuzzlePipeEnum.ruleConnect[arg_5_0._typeId])
	end
end

function var_0_0._onDragIng(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._isStarDrag then
		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragIng, arg_6_2.position)
	end
end

function var_0_0._onDragEnd(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._isStarDrag then
		arg_7_0._isStarDrag = false

		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragEnd, arg_7_2.position)
	end
end

function var_0_0._getPlaceNum(arg_8_0)
	return Activity157RepairGameModel.instance:getPlaceNum(arg_8_0._typeId)
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = arg_9_0:_getPlaceNum()
	local var_9_1 = var_9_0 <= 0

	if not var_9_1 then
		arg_9_0._txtNum.text = var_9_0
	else
		arg_9_0._txtNumZero.text = var_9_0
	end

	local var_9_2 = var_9_1 and ArmPuzzlePipeEnum.UIDragEmptyRes[arg_9_0._typeId] or ArmPuzzlePipeEnum.UIDragRes[arg_9_0._typeId]

	UISpriteSetMgr.instance:setArmPipeSprite(arg_9_0._imageicon, var_9_2, true)

	if arg_9_0._isLastZero ~= var_9_1 then
		arg_9_0._isLastZero = var_9_1

		gohelper.setActive(arg_9_0._txtNum, not var_9_1)
		gohelper.setActive(arg_9_0._txtNumZero, var_9_1)
	end
end

function var_0_0.onDestroy(arg_10_0)
	return
end

return var_0_0
