module("modules.logic.versionactivity1_6.enter.view.V1a6_ExploreEnterView", package.seeall)

local var_0_0 = class("V1a6_ExploreEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
	arg_1_0._txtLockTxt = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	arg_1_0._txtDescr = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/txt_Des")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._onEnterClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._onEnterClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	var_0_0.super.onOpen(arg_4_0)

	local var_4_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Explore)

	gohelper.setActive(arg_4_0._btnEnter, var_4_0)
	gohelper.setActive(arg_4_0._btnLocked, not var_4_0)

	if not var_4_0 then
		local var_4_1 = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Explore).openId
		local var_4_2 = OpenConfig.instance:getOpenCo(var_4_1).episodeId
		local var_4_3 = DungeonConfig.instance:getEpisodeDisplay(var_4_2)

		arg_4_0._txtLockTxt.text = string.format(luaLang("dungeon_unlock_episode_mode_sp"), var_4_3)
	end
end

function var_0_0.onClose(arg_5_0)
	var_0_0.super.onClose(arg_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.config = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Explore)

	local var_6_0 = arg_6_0.config and arg_6_0.config.activityBonus or -1
	local var_6_1 = GameUtil.splitString2(var_6_0, true)

	arg_6_0._items = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = gohelper.create2d(arg_6_0._gorewards, "item" .. iter_6_0)

		recthelper.setSize(var_6_2.transform, 200, 200)

		arg_6_0._items[iter_6_0] = IconMgr.instance:getCommonPropItemIcon(var_6_2)

		arg_6_0._items[iter_6_0]:setMOValue(iter_6_1[1], iter_6_1[2], 1)
		arg_6_0._items[iter_6_0]:isShowEquipAndItemCount(false)
	end

	arg_6_0._txtDescr.text = arg_6_0.config.actDesc
end

function var_0_0._onEnterClick(arg_7_0)
	if ExploreSimpleModel.instance:getMapIsUnLock(301) then
		ExploreSimpleModel.instance:setLastSelectMap(1402, 140201)
	end

	JumpController.instance:jump(440001)
end

return var_0_0
