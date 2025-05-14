module("modules.logic.versionactivity1_4.act129.view.Activity129EntranceView", package.seeall)

local var_0_0 = class("Activity129EntranceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goEntrance = gohelper.findChild(arg_1_0.viewGO, "#go_Entrance")
	arg_1_0.txtLimitTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_Entrance/Title/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0.itemDict = {}
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, arg_2_0.onEnterPool, arg_2_0)
	arg_2_0:addEventCb(Activity129Controller.instance, Activity129Event.OnGetInfoSuccess, arg_2_0.OnGetInfoSuccess, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, arg_3_0.onEnterPool, arg_3_0)
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnGetInfoSuccess, arg_3_0.OnGetInfoSuccess, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onEnterPool(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.OnGetInfoSuccess(arg_7_0)
	arg_7_0:refreshView(true)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.actId = arg_8_0.viewParam.actId
	arg_8_0.isOpen = true

	arg_8_0:refreshView()
end

function var_0_0.refreshView(arg_9_0, arg_9_1)
	TaskDispatcher.cancelTask(arg_9_0.refreshLeftTime, arg_9_0)

	if Activity129Model.instance:getSelectPoolId() then
		gohelper.setActive(arg_9_0.goEntrance, false)

		arg_9_0.isOpen = false

		return
	end

	gohelper.setActive(arg_9_0.goEntrance, true)

	if not arg_9_0.isOpen then
		arg_9_0.anim:Play("switch", 0, 0)
	end

	arg_9_0.isOpen = true

	if not arg_9_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_open)
	end

	local var_9_0 = Activity129Config.instance:getPoolDict(arg_9_0.actId)

	if var_9_0 then
		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			local var_9_1 = arg_9_0.itemDict[iter_9_1.poolId] or arg_9_0:createPoolItem(iter_9_1.poolId)

			arg_9_0:refreshPoolItem(var_9_1, iter_9_1)
		end
	end

	arg_9_0:refreshLeftTime()
	TaskDispatcher.runRepeat(arg_9_0.refreshLeftTime, arg_9_0, 60)
end

function var_0_0.createPoolItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getUserDataTb_()

	var_10_0.poolId = arg_10_1
	var_10_0.go = gohelper.findChild(arg_10_0.goEntrance, string.format("Item%s", arg_10_1))
	var_10_0.goItems = gohelper.findChild(var_10_0.go, "items")
	var_10_0.txtItemTitle = gohelper.findChildTextMesh(var_10_0.go, "items/txt_ItemTitle")
	var_10_0.goGet = gohelper.findChild(var_10_0.go, "#go_Get")
	var_10_0.click = gohelper.findChildClickWithAudio(var_10_0.go, "click", AudioEnum.UI.play_ui_payment_click)

	var_10_0.click:AddClickListener(arg_10_0._onClickItem, arg_10_0, var_10_0)

	var_10_0.simages = var_10_0.goItems:GetComponentsInChildren(typeof(SLFramework.UGUI.SingleImage), true)

	local var_10_1 = var_10_0.simages:GetEnumerator()

	while var_10_1:MoveNext() do
		local var_10_2 = var_10_1.Current.curImageUrl

		var_10_1.Current.curImageUrl = nil

		var_10_1.Current:LoadImage(var_10_2)
	end

	var_10_0.graphics = {}

	local var_10_3 = var_10_0.goItems:GetComponentsInChildren(gohelper.Type_Image, true):GetEnumerator()

	while var_10_3:MoveNext() do
		table.insert(var_10_0.graphics, {
			comp = var_10_3.Current,
			color = GameUtil.colorToHex(var_10_3.Current.color)
		})
	end

	local var_10_4 = var_10_0.goItems:GetComponentsInChildren(gohelper.Type_TextMesh, true):GetEnumerator()

	while var_10_4:MoveNext() do
		table.insert(var_10_0.graphics, {
			comp = var_10_4.Current,
			color = GameUtil.colorToHex(var_10_4.Current.color)
		})
	end

	arg_10_0.itemDict[arg_10_1] = var_10_0

	return var_10_0
end

function var_0_0.refreshPoolItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1.txtItemTitle.text = arg_11_2.name

	local var_11_0 = Activity129Model.instance:checkPoolIsEmpty(arg_11_0.actId, arg_11_2.poolId)

	gohelper.setActive(arg_11_1.goGet, var_11_0)

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.graphics) do
		SLFramework.UGUI.GuiHelper.SetColor(iter_11_1.comp, var_11_0 and "#808080" or iter_11_1.color)
	end
end

function var_0_0._onClickItem(arg_12_0, arg_12_1)
	Activity129Model.instance:setSelectPoolId(arg_12_1.poolId)
end

function var_0_0.refreshLeftTime(arg_13_0)
	local var_13_0 = ActivityModel.instance:getActMO(arg_13_0.actId)

	if var_13_0 then
		arg_13_0.txtLimitTime.text = formatLuaLang("remain", string.format("%s%s", var_13_0:getRemainTime()))
	end
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.refreshLeftTime, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.itemDict) do
		local var_15_0 = iter_15_1.simages:GetEnumerator()

		while var_15_0:MoveNext() do
			var_15_0.Current:UnLoadImage()
		end

		iter_15_1.click:RemoveClickListener()
	end
end

return var_0_0
