module("modules.logic.versionactivity1_9.enter.view.subview.V1a9_ExploreEnterView", package.seeall)

local var_0_0 = class("V1a9_ExploreEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/txt_Des")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
end

function var_0_0._btnEnterOnClick(arg_4_0)
	if ExploreSimpleModel.instance:getMapIsUnLock(201) then
		ExploreSimpleModel.instance:setLastSelectMap(1403, 140301)
	end

	if JumpController.instance:jump(440001) then
		ExploreModel.instance.isJumpToExplore = true
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.animComp = VersionActivitySubAnimatorComp.get(arg_5_0.viewGO, arg_5_0)
	arg_5_0.config = ActivityConfig.instance:getActivityCo(VersionActivity1_9Enum.ActivityId.Explore3)

	local var_5_0 = arg_5_0.config and arg_5_0.config.activityBonus or ""
	local var_5_1 = GameUtil.splitString2(var_5_0, true) or {}

	arg_5_0._items = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = gohelper.create2d(arg_5_0._gorewards, "item" .. iter_5_0)

		recthelper.setSize(var_5_2.transform, 250, 250)

		arg_5_0._items[iter_5_0] = IconMgr.instance:getCommonPropItemIcon(var_5_2)

		arg_5_0._items[iter_5_0]:setMOValue(iter_5_1[1], iter_5_1[2], 1)
		arg_5_0._items[iter_5_0]:isShowEquipAndItemCount(false)
	end

	arg_5_0._txtDescr.text = arg_5_0.config.actDesc
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.animComp:playOpenAnim()
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0.animComp:destroy()
end

return var_0_0
