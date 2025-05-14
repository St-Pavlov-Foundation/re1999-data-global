module("modules.logic.versionactivity2_5.liangyue.view.LiangYueDragItem", package.seeall)

local var_0_0 = class("LiangYueDragItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.rectTran = arg_1_1.transform
	arg_1_0._image_illustration = gohelper.findChildSingleImage(arg_1_1, "Piece")
	arg_1_0._image_illustration_frame = gohelper.findChildSingleImage(arg_1_1, "PieceFrame")
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_1, "Tips/image_NumBG/#txt_Num")
	arg_1_0._goTips = gohelper.findChild(arg_1_1, "Tips")
	arg_1_0._goTargetIconOneRow = gohelper.findChild(arg_1_1, "Tips/TargetIconOneRow")
	arg_1_0._goTargetIconTwoColumn = gohelper.findChild(arg_1_1, "Tips/TargetIconTwoColumn")
	arg_1_0._goTargetIconOneColumn = gohelper.findChild(arg_1_1, "Tips/TargetIconOneColumn")

	arg_1_0:initComp()
end

function var_0_0.initComp(arg_2_0)
	arg_2_0._iconHeight = recthelper.getHeight(arg_2_0._image_illustration.transform)
	arg_2_0._iconWidth = recthelper.getWidth(arg_2_0._image_illustration.transform)
	arg_2_0._attributeItemList = {}

	local var_2_0 = {
		arg_2_0._goTargetIconOneColumn,
		arg_2_0._goTargetIconTwoColumn,
		arg_2_0._goTargetIconOneRow
	}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = LiangYueAttributeItem.New()

		var_2_1:init(iter_2_1)
		table.insert(arg_2_0._attributeItemList, var_2_1)
	end
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0.go, arg_3_1)
end

function var_0_0.setInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.id = arg_4_1
	arg_4_0.config = arg_4_2
	arg_4_0.isStatic = arg_4_3
	arg_4_0.isFinish = arg_4_4

	local var_4_0 = string.format("v2a5_liangyue_game_list_piece%s", arg_4_2.imageId)

	arg_4_0._image_illustration:LoadImage(ResUrl.getV2a5LiangYueImg(var_4_0), arg_4_0.onIllustrationLoadBack, arg_4_0)

	if arg_4_3 then
		local var_4_1 = string.format("v2a5_liangyue_game_pieceframe%s", arg_4_2.imageId)

		arg_4_0._image_illustration_frame:LoadImage(ResUrl.getV2a5LiangYueImg(var_4_1), arg_4_0.onIllustrationBgLoadBack, arg_4_0)
	end

	gohelper.setActive(arg_4_0._goTips, arg_4_3 and not arg_4_4)
	gohelper.setActive(arg_4_0._image_illustration_frame.gameObject, arg_4_3)
end

function var_0_0.setIndex(arg_5_0, arg_5_1)
	arg_5_0._txtNum.text = arg_5_1
end

function var_0_0.setAttributeState(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._goTips, arg_6_1)
end

function var_0_0.onIllustrationBgLoadBack(arg_7_0)
	ZProj.UGUIHelper.SetImageSize(arg_7_0._image_illustration_frame.gameObject)
end

function var_0_0.onIllustrationLoadBack(arg_8_0)
	local var_8_0 = arg_8_0._image_illustration.transform

	ZProj.UGUIHelper.SetImageSize(var_8_0.gameObject)

	local var_8_1 = recthelper.getWidth(var_8_0)
	local var_8_2 = recthelper.getHeight(var_8_0)

	arg_8_0.width = var_8_1
	arg_8_0.height = var_8_2

	recthelper.setSize(arg_8_0.go.transform, var_8_1, var_8_2)

	local var_8_3 = arg_8_0.isStatic

	if not var_8_3 or arg_8_0.isFinish then
		return
	end

	local var_8_4 = arg_8_0.config

	arg_8_0:setAttributeInfo(var_8_4.activityId, var_8_4.id, var_8_3)
end

function var_0_0.setAttributeInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = LiangYueConfig.instance:getIllustrationAttribute(arg_9_1, arg_9_2)
	local var_9_1 = LiangYueConfig.instance:getIllustrationShape(arg_9_1, arg_9_2)
	local var_9_2 = #var_9_1[1]
	local var_9_3 = #var_9_1
	local var_9_4 = Mathf.Clamp(var_9_2, LiangYueEnum.AttributeType.OneColumn, LiangYueEnum.AttributeType.OneRow)
	local var_9_5 = arg_9_0._attributeItemList[var_9_4]

	var_9_5:setInfo(var_9_0)

	if arg_9_0._shapeId == arg_9_2 then
		return
	end

	arg_9_0._shapeId = arg_9_2

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._attributeItemList) do
		iter_9_1:setActive(iter_9_0 == var_9_4)
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_1) do
		local var_9_6 = 0

		for iter_9_4, iter_9_5 in ipairs(iter_9_3) do
			if iter_9_5 == 1 then
				var_9_6 = var_9_6 + 1

				if var_9_6 == var_9_2 then
					arg_9_0._currentItem = var_9_5

					var_9_5:setItemPos(iter_9_2, var_9_3)
					logNormal("第一个最宽的行索引: " .. iter_9_2)

					if arg_9_3 then
						arg_9_0:delayRefreshInfo()
					end

					return
				end
			end
		end
	end

	logError("can not find fixable row")

	arg_9_0._currentItem = var_9_5

	var_9_5:setItemPos(1, var_9_3)

	if arg_9_3 then
		arg_9_0:delayRefreshInfo()
	end
end

function var_0_0.delayRefreshInfo(arg_10_0)
	ZProj.UGUIHelper.RebuildLayout(arg_10_0._currentItem.go.transform)
	arg_10_0:setAttributeState(false)
	TaskDispatcher.runDelay(arg_10_0.setItemPosY, arg_10_0, 0.1)
end

function var_0_0.setItemPosY(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.setItemPosY, arg_11_0)
	arg_11_0:setAttributeState(true)

	local var_11_0 = arg_11_0._currentItem

	if var_11_0 == nil then
		logError("没有找到对应的数值组件")

		return
	end

	local var_11_1 = var_11_0.yPos
	local var_11_2 = var_11_0.columnCount
	local var_11_3 = arg_11_0.height / var_11_2
	local var_11_4 = 0

	ZProj.UGUIHelper.RebuildLayout(arg_11_0._currentItem.go.transform)

	local var_11_5 = LiangYueEnum.AttributeOffset
	local var_11_6 = arg_11_0.height * 0.5

	if var_11_1 <= 1 then
		var_11_4 = (var_11_2 - var_11_1 + 1) * var_11_3 - var_11_5
	else
		var_11_4 = (var_11_2 - var_11_1) * var_11_3 + var_11_5
	end

	recthelper.setAnchorY(arg_11_0._goTips.transform, var_11_4 - var_11_6)
end

function var_0_0.onDestroy(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.setItemPosY, arg_12_0)
end

return var_0_0
