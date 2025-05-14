module("modules.logic.dungeon.view.DungeonHuaRongView", package.seeall)

local var_0_0 = class("DungeonHuaRongView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_item")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_container/#go_item/#simage_bg")
	arg_1_0._txtnumber = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#go_item/#txt_number")
	arg_1_0._btnshowsteps = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_showsteps")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshowsteps:AddClickListener(arg_2_0._btnshowstepsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshowsteps:RemoveClickListener()
end

var_0_0.originData = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15
}
var_0_0.moveDuration = 0.5

function var_0_0._btnshowstepsOnClick(arg_4_0)
	local var_4_0 = ""

	for iter_4_0 = 1, #arg_4_0.clickedPoses do
		var_4_0 = var_4_0 .. "\n" .. string.format("Vector2(%s, %s),", arg_4_0.clickedPoses[iter_4_0].x, arg_4_0.clickedPoses[iter_4_0].y)
	end

	logWarn(var_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.gridLayoutComp = arg_5_0._gocontainer:GetComponent(gohelper.Type_GridLayoutGroup)

	gohelper.setActive(arg_5_0._goitem, false)
	gohelper.setActive(arg_5_0._btnshowsteps.gameObject, SLFramework.FrameworkSettings.IsEditor)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._callBack = arg_7_0.viewParam.callBack
	arg_7_0._callBackObject = arg_7_0.viewParam.callBackObject
	arg_7_0.itemList = arg_7_0:getEmpty4x4List()
	arg_7_0.clickList = {}
	arg_7_0.emptyPos = Vector2(0, 0)
	arg_7_0.boardData = arg_7_0:initBoardData(var_0_0.originData)
	arg_7_0.movingCount = 0
	arg_7_0._succ = false

	arg_7_0:resetMoveProperties()
	arg_7_0:refreshBoard(arg_7_0.boardData)

	if SLFramework.FrameworkSettings.IsEditor then
		arg_7_0.clickedPoses = {}
	end
end

function var_0_0.onOpenFinish(arg_8_0)
	arg_8_0.gridLayoutComp.enabled = false
end

function var_0_0.initBoardData(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getEmpty4x4List(0)

	for iter_9_0 = 1, #arg_9_1 do
		local var_9_1, var_9_2 = arg_9_0:_numTo4x4Pos(iter_9_0)

		var_9_0[var_9_1][var_9_2] = arg_9_1[iter_9_0]
	end

	return var_9_0
end

function var_0_0.refreshBoard(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_1 do
		for iter_10_1 = 1, #arg_10_1[iter_10_0] do
			local var_10_0 = arg_10_0:getUserDataTb_()

			var_10_0.pos = Vector2(iter_10_0, iter_10_1)
			var_10_0.data = arg_10_1[iter_10_0][iter_10_1]
			var_10_0.go = gohelper.clone(arg_10_0._goitem, arg_10_0._gocontainer, string.format("item%s_%s", iter_10_0, iter_10_1))

			gohelper.setActive(var_10_0.go, true)

			var_10_0.txtnumber = gohelper.findChildText(var_10_0.go, "#txt_number")
			var_10_0.simagebg = gohelper.findChildSingleImage(var_10_0.go, "#simage_bg")
			var_10_0.click = gohelper.getClick(var_10_0.go)

			var_10_0.click:AddClickListener(arg_10_0._onClickItem, arg_10_0, var_10_0)

			if arg_10_1[iter_10_0][iter_10_1] ~= 0 then
				var_10_0.txtnumber.text = arg_10_1[iter_10_0][iter_10_1]

				gohelper.setActive(var_10_0.txtnumber.gameObject, true)
				gohelper.setActive(var_10_0.simagebg.gameObject, true)
			else
				arg_10_0.emptyPos = Vector2(iter_10_0, iter_10_1)

				gohelper.setActive(var_10_0.txtnumber.gameObject, false)
				gohelper.setActive(var_10_0.simagebg.gameObject, false)
			end

			arg_10_0.itemList[iter_10_0][iter_10_1] = var_10_0

			table.insert(arg_10_0.clickList, var_10_0.click)
		end
	end
end

function var_0_0._onClickItem(arg_11_0, arg_11_1)
	if arg_11_0.movingCount ~= 0 then
		return
	end

	local var_11_0 = arg_11_1.pos.x
	local var_11_1 = arg_11_1.pos.y

	if var_11_0 == arg_11_0.emptyPos.x and var_11_1 == arg_11_0.emptyPos.y then
		return
	end

	if var_11_0 ~= arg_11_0.emptyPos.x and var_11_1 ~= arg_11_0.emptyPos.y then
		return
	end

	arg_11_0:resetMoveProperties()

	arg_11_0.clickAnchorPos = arg_11_1.go.transform.anchoredPosition

	if var_11_0 == arg_11_0.emptyPos.x then
		if var_11_1 > arg_11_0.emptyPos.y then
			for iter_11_0 = arg_11_0.emptyPos.y + 1, var_11_1 do
				table.insert(arg_11_0.currSrcTransform, arg_11_0.itemList[var_11_0][iter_11_0].go.transform)
				table.insert(arg_11_0.currDestTransforms, arg_11_0.itemList[var_11_0][iter_11_0 - 1].go.transform)
				table.insert(arg_11_0.currSrcPos, Vector2(var_11_0, iter_11_0))
				table.insert(arg_11_0.currDestPos, Vector2(var_11_0, iter_11_0 - 1))
			end
		else
			for iter_11_1 = arg_11_0.emptyPos.y - 1, var_11_1, -1 do
				table.insert(arg_11_0.currSrcTransform, arg_11_0.itemList[var_11_0][iter_11_1].go.transform)
				table.insert(arg_11_0.currDestTransforms, arg_11_0.itemList[var_11_0][iter_11_1 + 1].go.transform)
				table.insert(arg_11_0.currSrcPos, Vector2(var_11_0, iter_11_1))
				table.insert(arg_11_0.currDestPos, Vector2(var_11_0, iter_11_1 + 1))
			end
		end
	end

	if var_11_1 == arg_11_0.emptyPos.y then
		if var_11_0 > arg_11_0.emptyPos.x then
			for iter_11_2 = arg_11_0.emptyPos.x + 1, var_11_0 do
				table.insert(arg_11_0.currSrcTransform, arg_11_0.itemList[iter_11_2][var_11_1].go.transform)
				table.insert(arg_11_0.currDestTransforms, arg_11_0.itemList[iter_11_2 - 1][var_11_1].go.transform)
				table.insert(arg_11_0.currSrcPos, Vector2(iter_11_2, var_11_1))
				table.insert(arg_11_0.currDestPos, Vector2(iter_11_2 - 1, var_11_1))
			end
		else
			for iter_11_3 = arg_11_0.emptyPos.x - 1, var_11_0, -1 do
				table.insert(arg_11_0.currSrcTransform, arg_11_0.itemList[iter_11_3][var_11_1].go.transform)
				table.insert(arg_11_0.currDestTransforms, arg_11_0.itemList[iter_11_3 + 1][var_11_1].go.transform)
				table.insert(arg_11_0.currSrcPos, Vector2(iter_11_3, var_11_1))
				table.insert(arg_11_0.currDestPos, Vector2(iter_11_3 + 1, var_11_1))
			end
		end
	end

	if SLFramework.FrameworkSettings.IsEditor then
		table.insert(arg_11_0.clickedPoses, arg_11_1.pos)
	end

	arg_11_0:moveItems(arg_11_0.currSrcTransform, arg_11_0.currDestTransforms)
end

function var_0_0.moveItems(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.movingCount = #arg_12_1

	for iter_12_0 = 1, #arg_12_1 do
		local var_12_0, var_12_1 = recthelper.getAnchor(arg_12_2[iter_12_0])

		ZProj.TweenHelper.DOAnchorPos(arg_12_1[iter_12_0], var_12_0, var_12_1, var_0_0.moveDuration, arg_12_0.moveDoneCallback, arg_12_0)
	end
end

function var_0_0.moveDoneCallback(arg_13_0)
	arg_13_0.movingCount = arg_13_0.movingCount - 1

	if arg_13_0.movingCount == 0 then
		arg_13_0:changeBoardData()
		arg_13_0:checkSuccess()
		arg_13_0:resetMoveProperties()
	end
end

function var_0_0.changeBoardData(arg_14_0)
	local var_14_0 = arg_14_0.currSrcPos[#arg_14_0.currSrcPos]
	local var_14_1 = arg_14_0.itemList[arg_14_0.emptyPos.x][arg_14_0.emptyPos.y]

	arg_14_0.emptyPos = var_14_0
	var_14_1.go.transform.anchoredPosition = arg_14_0.clickAnchorPos

	for iter_14_0 = 1, #arg_14_0.currDestPos do
		arg_14_0.itemList[arg_14_0.currDestPos[iter_14_0].x][arg_14_0.currDestPos[iter_14_0].y] = arg_14_0.itemList[arg_14_0.currSrcPos[iter_14_0].x][arg_14_0.currSrcPos[iter_14_0].y]
		arg_14_0.itemList[arg_14_0.currDestPos[iter_14_0].x][arg_14_0.currDestPos[iter_14_0].y].pos = Vector2(arg_14_0.currDestPos[iter_14_0].x, arg_14_0.currDestPos[iter_14_0].y)
	end

	arg_14_0.itemList[var_14_0.x][var_14_0.y] = var_14_1
end

function var_0_0.checkSuccess(arg_15_0)
	if arg_15_0:isValidBoard() then
		logWarn("success")

		arg_15_0._succ = true

		for iter_15_0, iter_15_1 in ipairs(arg_15_0.clickList) do
			iter_15_1:RemoveClickListener()
		end
	end
end

function var_0_0.isValidBoard(arg_16_0)
	for iter_16_0 = 1, 4 do
		for iter_16_1 = 1, 4 do
			if arg_16_0.itemList[iter_16_0][iter_16_1].data + 1 ~= arg_16_0:_4x4ToNumPos(iter_16_0, iter_16_1) then
				return false
			end
		end
	end

	return true
end

function var_0_0.resetMoveProperties(arg_17_0)
	arg_17_0.currSrcTransform = {}
	arg_17_0.currSrcPos = {}
	arg_17_0.currDestTransforms = {}
	arg_17_0.currDestPos = {}
	arg_17_0.clickAnchorPos = nil
end

function var_0_0.getEmpty4x4List(arg_18_0, arg_18_1)
	local var_18_0 = {}

	for iter_18_0 = 1, 4 do
		var_18_0[iter_18_0] = {}

		for iter_18_1 = 1, 4 do
			table.insert(var_18_0[iter_18_0], arg_18_1 or 0)
		end
	end

	return var_18_0
end

function var_0_0._numTo4x4Pos(arg_19_0, arg_19_1)
	local var_19_0 = math.ceil(arg_19_1 / 4)
	local var_19_1 = arg_19_1 % 4

	if var_19_1 == 0 then
		var_19_1 = 4
	end

	return var_19_0, var_19_1
end

function var_0_0._4x4ToNumPos(arg_20_0, arg_20_1, arg_20_2)
	return (arg_20_1 - 1) * 4 + arg_20_2
end

function var_0_0.onClose(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.clickList) do
		iter_21_1:RemoveClickListener()
	end

	arg_21_0.itemList = {}

	if arg_21_0._callBack then
		arg_21_0._callBack(arg_21_0._callBackObject, arg_21_0._succ)
	end
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
