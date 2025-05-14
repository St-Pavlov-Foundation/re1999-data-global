module("modules.logic.room.view.record.RoomTradeTaskItem", package.seeall)

local var_0_0 = class("RoomTradeTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._txttask = gohelper.findChildText(arg_1_0.viewGO, "#txt_task")
	arg_1_0._gofinish1 = gohelper.findChild(arg_1_0.viewGO, "#txt_task/#go_finish1")
	arg_1_0._txttaskprogress = gohelper.findChildText(arg_1_0.viewGO, "#txt_taskprogress")
	arg_1_0._gofinish2 = gohelper.findChild(arg_1_0.viewGO, "#go_finish2")
	arg_1_0._gojump = gohelper.findChild(arg_1_0.viewGO, "#go_jump")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_jump/#btn_jump")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
end

function var_0_0._btnjumpOnClick(arg_4_0)
	if arg_4_0._mo then
		local var_4_0 = arg_4_0._mo.co.jumpId

		RoomJumpController.instance:jumpFormTaskView(var_4_0)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txtLineHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_5_0._txttask, " ")
end

function var_0_0.activeGo(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.viewGO, arg_6_1)
end

local var_0_1 = {
	offest = 50,
	height = 100,
	descWidthMax = 556,
	progressWidthMax = 300,
	spacing = 10,
	width = 662
}

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	if arg_7_1 then
		if arg_7_1.co then
			local var_7_0 = arg_7_1.co.desc
			local var_7_1 = arg_7_1.progress
			local var_7_2 = arg_7_1.co.maxProgress
			local var_7_3 = luaLang("room_trade_progress")
			local var_7_4 = var_7_2 <= var_7_1 and "#000000" or "#A75A29"
			local var_7_5 = GameUtil.getSubPlaceholderLuaLangThreeParam(var_7_3, var_7_4, var_7_1, var_7_2)

			arg_7_0:_setItemHeight(var_7_0, var_7_5)

			arg_7_0._txttask.text = var_7_0
			arg_7_0._txttaskprogress.text = var_7_5
		end

		arg_7_0:_refreshFinish()
	end
end

function var_0_0._setItemHeight(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_8_0._txttask, arg_8_1)
	local var_8_1 = 100

	if not arg_8_0._mo.hasFinish then
		local var_8_2 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_8_0._txttaskprogress, arg_8_2)

		var_8_1 = math.min(var_8_2, var_0_1.progressWidthMax)
	end

	local var_8_3 = arg_8_0._txtLineHeight
	local var_8_4 = var_0_1.width - var_8_1

	recthelper.setWidth(arg_8_0._txttask.transform, var_8_4)

	if var_8_4 < var_8_0 then
		var_8_3 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_8_0._txttask, arg_8_1)
	end

	recthelper.setWidth(arg_8_0._txttaskprogress.transform, var_8_1)
	recthelper.setHeight(arg_8_0._txttaskprogress.transform, arg_8_0._txtLineHeight)
	recthelper.setHeight(arg_8_0._txttask.transform, var_8_3)
	recthelper.setHeight(arg_8_0.viewGO.transform, var_8_3 + var_0_1.offest)
end

function var_0_0.getNextItemAnchorY(arg_9_0, arg_9_1)
	if arg_9_1 < 0 then
		arg_9_1 = arg_9_1 + var_0_1.spacing
	else
		arg_9_1 = -var_0_1.spacing
	end

	recthelper.setAnchorY(arg_9_0.viewGO.transform, arg_9_1)

	return arg_9_1 - recthelper.getHeight(arg_9_0.viewGO.transform)
end

function var_0_0._refreshFinish(arg_10_0)
	if arg_10_0._mo.hasFinish then
		if arg_10_0._mo.new then
			arg_10_0:playFinishAnim()
		else
			arg_10_0:_activeFinishTask(true)
		end
	else
		arg_10_0:_activeFinishTask(false)
	end
end

function var_0_0.playFinishAnim(arg_11_0)
	arg_11_0:_activeFinishTask(true)
end

function var_0_0._activeFinishTask(arg_12_0, arg_12_1)
	for iter_12_0 = 1, 2 do
		gohelper.setActive(arg_12_0["_gofinish" .. iter_12_0], arg_12_1)
	end

	local var_12_0 = arg_12_0._txttask.color

	arg_12_0._txttask.color = Color(var_12_0.r, var_12_0.b, var_12_0.g, arg_12_1 and 0.5 or 1)

	UISpriteSetMgr.instance:setCritterSprite(arg_12_0._imageicon, arg_12_1 and "room_task_point2" or "room_task_point1")
	gohelper.setActive(arg_12_0._txttaskprogress.gameObject, not arg_12_1)

	local var_12_1 = not string.nilorempty(arg_12_0._mo.co.jumpId) and not arg_12_1

	gohelper.setActive(arg_12_0._gojump.gameObject, var_12_1)
end

return var_0_0
