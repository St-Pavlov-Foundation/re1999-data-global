module("modules.logic.dungeon.view.DungeonViewEffect", package.seeall)

local var_0_0 = class("DungeonViewEffect", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gostory = gohelper.findChild(arg_1_0.viewGO, "#go_story")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._effect = gohelper.findChild(arg_4_0.viewGO, "#go_story/effect")
	arg_4_0._effectTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_4_0._effect)

	arg_4_0._effectTouchEventMgr:SetIgnoreUI(true)
	arg_4_0._effectTouchEventMgr:SetOnlyTouch(true)
	arg_4_0._effectTouchEventMgr:SetOnTouchDownCb(arg_4_0._onEffectTouchDown, arg_4_0)
	arg_4_0:_loadEffect()
end

function var_0_0._loadEffect(arg_5_0)
	arg_5_0._effectItem = arg_5_0:getUserDataTb_()
	arg_5_0._effectIndex = 1
	arg_5_0._effectNum = 3
	arg_5_0._effectUrl = "ui/viewres/dungeon/dungeonview_effect.prefab"
	arg_5_0._effectLoader = MultiAbLoader.New()

	arg_5_0._effectLoader:addPath(arg_5_0._effectUrl)
	arg_5_0._effectLoader:startLoad(arg_5_0._effectLoaded, arg_5_0)
end

function var_0_0._effectLoaded(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getAssetItem(arg_6_0._effectUrl):GetResource(arg_6_0._effectUrl)

	for iter_6_0 = 1, arg_6_0._effectNum do
		local var_6_1 = arg_6_0:getUserDataTb_()

		var_6_1.go = gohelper.clone(var_6_0, arg_6_0._effect)
		var_6_1.tweenId = nil

		table.insert(arg_6_0._effectItem, var_6_1)
		gohelper.setActive(var_6_1.go, false)
	end
end

function var_0_0._onEffectTouchDown(arg_7_0, arg_7_1)
	if UIBlockMgr.instance:isBlock() then
		return
	end

	local var_7_0 = ViewMgr.instance:getOpenViewNameList()

	if not var_7_0 or #var_7_0 <= 0 then
		return
	end

	for iter_7_0 = #var_7_0, 1, -1 do
		local var_7_1 = ViewMgr.instance:getSetting(var_7_0[iter_7_0])

		if var_7_0[iter_7_0] ~= ViewName.DungeonView and (var_7_1.layer == "POPUP_TOP" or var_7_1.layer == "POPUP") then
			return
		end

		if var_7_0[iter_7_0] == ViewName.DungeonView then
			break
		end
	end

	local var_7_2 = arg_7_0._effectItem[arg_7_0._effectIndex]

	if not var_7_2 then
		return
	end

	arg_7_1 = recthelper.screenPosToAnchorPos(arg_7_1, arg_7_0._effect.transform)

	if var_7_2.tweenId then
		ZProj.TweenHelper.KillById(var_7_2.tweenId)
		gohelper.setActive(var_7_2.go, false)
	end

	gohelper.setActive(var_7_2.go, true)
	transformhelper.setLocalPosXY(var_7_2.go.transform, arg_7_1.x, arg_7_1.y)

	var_7_2.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, nil, arg_7_0._effectTweenFinish, arg_7_0, arg_7_0._effectIndex)

	if arg_7_0._effectIndex >= arg_7_0._effectNum then
		arg_7_0._effectIndex = 1
	else
		arg_7_0._effectIndex = arg_7_0._effectIndex + 1
	end
end

function var_0_0._effectTweenFinish(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._effectItem[arg_8_1]

	if not var_8_0 then
		return
	end

	var_8_0.tweenId = nil

	gohelper.setActive(var_8_0.go, false)
end

function var_0_0.onDestroyView(arg_9_0)
	if arg_9_0._effectTouchEventMgr then
		TouchEventMgrHepler.remove(arg_9_0._effectTouchEventMgr)

		arg_9_0._effectTouchEventMgr = nil
	end

	if arg_9_0._effectLoader then
		arg_9_0._effectLoader:dispose()
	end

	for iter_9_0 = 1, #arg_9_0._effectItem do
		local var_9_0 = arg_9_0._effectItem[iter_9_0]

		if var_9_0.tweenId then
			ZProj.TweenHelper.KillById(var_9_0.tweenId)
		end
	end
end

return var_0_0
