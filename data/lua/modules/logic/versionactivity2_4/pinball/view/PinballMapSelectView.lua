module("modules.logic.versionactivity2_4.pinball.view.PinballMapSelectView", package.seeall)

local var_0_0 = class("PinballMapSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_name")
	arg_1_0._txtdesc1 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#scroll_dec/Viewport/Content/#txt_dec1")
	arg_1_0._txtdesc2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#scroll_dec/Viewport/Content/#txt_dec2")
	arg_1_0._txtdesc3 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#scroll_dec/Viewport/Content/go_item/#txt_dec3")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "Right/#scroll_dec/Viewport/Content/go_item")
	arg_1_0._icontype = gohelper.findChildImage(arg_1_0.viewGO, "Right/#scroll_dec/Viewport/Content/go_item/#txt_dec3/#image_icon")
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_start")
	arg_1_0._txtCost = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_start/#txt_cost")
	arg_1_0._topCurrencyRoot = gohelper.findChild(arg_1_0.viewGO, "#go_topright")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStart:AddClickListener(arg_2_0._onStartClick, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, arg_2_0.updateCost, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStart:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, arg_3_0.updateCost, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._items = arg_4_0:getUserDataTb_()
	arg_4_0._itemSelects = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 4 do
		arg_4_0._items[iter_4_0] = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "Left/#go_item" .. iter_4_0)
		arg_4_0._itemSelects[iter_4_0] = gohelper.findChild(arg_4_0._items[iter_4_0].gameObject, "#go_select")
		gohelper.findChildTextMesh(arg_4_0._items[iter_4_0].gameObject, "txt_name").text = PinballConfig.instance:getRandomEpisode(iter_4_0).name

		arg_4_0:addClickCb(arg_4_0._items[iter_4_0], arg_4_0.onClickSelect, arg_4_0, iter_4_0)
	end

	arg_4_0:onClickSelect(1)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:createCurrencyItem()
	arg_5_0:updateCost()

	if not arg_5_0._enough and not PinballModel.instance.isGuideAddGrain then
		GuideController.instance:dispatchEvent(GuideEvent.TriggerActive, GuideEnum.EventTrigger.Act178FoodNotEnough)
	end
end

function var_0_0.updateCost(arg_6_0)
	local var_6_0 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.EpisodeCost) - PinballModel.instance:getCostDec()
	local var_6_1 = math.max(0, var_6_0)

	if var_6_1 > PinballModel.instance:getResNum(PinballEnum.ResType.Food) then
		arg_6_0._enough = false
		arg_6_0._txtCost.text = string.format("<color=#FC8A6A>-%d", var_6_1)
	else
		arg_6_0._enough = true
		arg_6_0._txtCost.text = string.format("-%d", var_6_1)
	end
end

function var_0_0.createCurrencyItem(arg_7_0)
	local var_7_0 = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone,
		PinballEnum.ResType.Food
	}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = arg_7_0:getResInst(arg_7_0.viewContainer._viewSetting.otherRes.currency, arg_7_0._topCurrencyRoot)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, PinballCurrencyItem):setCurrencyType(iter_7_1)
	end
end

local var_0_1 = {
	PinballEnum.ResType.Stone,
	PinballEnum.ResType.Wood,
	PinballEnum.ResType.Food,
	PinballEnum.ResType.Mine
}

function var_0_0.onClickSelect(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goitem, false)
	gohelper.setActive(arg_8_0._goitem, true)

	arg_8_0._curIndex = arg_8_1

	for iter_8_0 = 1, 4 do
		gohelper.setActive(arg_8_0._itemSelects[iter_8_0], iter_8_0 == arg_8_1)
	end

	local var_8_0 = PinballConfig.instance:getRandomEpisode(arg_8_1)

	if not var_8_0 then
		logError("没有副本配置")

		return
	end

	arg_8_0._txtname.text = var_8_0.name
	arg_8_0._txtdesc1.text = var_8_0.longDesc
	arg_8_0._txtdesc2.text = var_8_0.desc
	arg_8_0._txtdesc3.text = var_8_0.shortDesc

	local var_8_1 = var_0_1[var_8_0.type]

	if not var_8_1 then
		return
	end

	local var_8_2 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_8_1]

	UISpriteSetMgr.instance:setAct178Sprite(arg_8_0._icontype, var_8_2.icon)
end

function var_0_0._onStartClick(arg_9_0)
	if not arg_9_0._enough then
		local var_9_0 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][PinballEnum.ResType.Food]

		GameFacade.showToast(ToastEnum.DiamondBuy, var_9_0.name)

		return
	end

	local var_9_1 = PinballConfig.instance:getRandomEpisode(arg_9_0._curIndex, PinballModel.instance.leftEpisodeId)

	if not var_9_1 then
		logError("随机关卡失败，index：" .. tostring(arg_9_0._curIndex))

		return
	end

	PinballModel.instance.leftEpisodeId = var_9_1.id

	Activity178Rpc.instance:sendAct178StartEpisode(VersionActivity2_4Enum.ActivityId.Pinball, PinballModel.instance.leftEpisodeId, arg_9_0._onReq, arg_9_0)
end

function var_0_0._onReq(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.PinballGameView, {
		index = arg_10_0._curIndex
	})
	ViewMgr.instance:openView(ViewName.PinballStartLoadingView)
	arg_10_0:closeThis()
end

return var_0_0
