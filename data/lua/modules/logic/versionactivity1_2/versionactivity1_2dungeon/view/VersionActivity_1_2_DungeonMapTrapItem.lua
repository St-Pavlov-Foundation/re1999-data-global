module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapTrapItem", package.seeall)

local var_0_0 = class("VersionActivity_1_2_DungeonMapTrapItem", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._topRight = gohelper.findChild(arg_1_0.viewGO, "topRight")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeElementView, arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO):Play("close", nil, nil)

	arg_4_0._closeTween = ZProj.TweenHelper.DOTweenFloat(5, 6.75, 0.5, arg_4_0._tweenFloatFrameCb, arg_4_0.DESTROYSELF, arg_4_0)
end

function var_0_0.onRefreshViewParam(arg_5_0, arg_5_1)
	arg_5_0._config = arg_5_1
end

function var_0_0.onOpen(arg_6_0)
	MainCameraMgr.instance:setLock(true)
	gohelper.setActive(arg_6_0.viewGO, false)

	arg_6_0._trapIds = VersionActivity1_2DungeonModel.instance.trapIds
	arg_6_0._putTrap = VersionActivity1_2DungeonModel.instance.putTrap

	local var_6_0 = {}
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(arg_6_0._config.id)) do
		table.insert(var_6_0, iter_6_1)

		if not arg_6_0._modelItem then
			arg_6_0._modelItem = gohelper.findChild(arg_6_0.viewGO, "Root/rotate/choicelayout/choice")

			table.insert(var_6_1, arg_6_0._modelItem)
		else
			table.insert(var_6_1, gohelper.cloneInPlace(arg_6_0._modelItem))
		end
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		return arg_7_0.id < arg_7_1.id
	end)

	for iter_6_2, iter_6_3 in ipairs(var_6_0) do
		arg_6_0:openSubView(VersionActivity_1_2_DungeonMapTrapChildItem, var_6_1[iter_6_2], nil, iter_6_3)
	end

	TaskDispatcher.runDelay(arg_6_0._showOpenCameraAni, arg_6_0, 0.3)
end

function var_0_0._showOpenCameraAni(arg_8_0)
	gohelper.setActive(arg_8_0.viewGO, true)

	arg_8_0._openTween = ZProj.TweenHelper.DOTweenFloat(6.75, 5, 0.5, arg_8_0._tweenFloatFrameCb, nil, arg_8_0)
end

function var_0_0._tweenFloatFrameCb(arg_9_0, arg_9_1)
	CameraMgr.instance:getMainCamera().orthographicSize = arg_9_1
end

function var_0_0._showCurrency(arg_10_0)
	arg_10_0:com_loadAsset(CurrencyView.prefabPath, arg_10_0._onCurrencyLoaded)
end

function var_0_0._onCurrencyLoaded(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:GetResource()
	local var_11_1 = gohelper.clone(var_11_0, arg_11_0._topRight)
	local var_11_2 = CurrencyEnum.CurrencyType
	local var_11_3 = {
		var_11_2.DryForest
	}
	local var_11_4 = arg_11_0:openSubView(CurrencyView, var_11_1, nil, var_11_3)

	var_11_4.foreShowBtn = true

	var_11_4:_hideAddBtn(CurrencyEnum.CurrencyType.DryForest)
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._showOpenCameraAni, arg_12_0)

	if arg_12_0._openTween then
		ZProj.TweenHelper.KillById(arg_12_0._openTween)
	end

	if arg_12_0._closeTween then
		ZProj.TweenHelper.KillById(arg_12_0._closeTween)
	end

	MainCameraMgr.instance:setLock(false)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
