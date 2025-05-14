module("modules.logic.explore.view.unit.ExploreUseItemConfirmView", package.seeall)

local var_0_0 = class("ExploreUseItemConfirmView")

function var_0_0.ctor(arg_1_0)
	arg_1_0._containerGO = gohelper.create2d(GameSceneMgr.instance:getCurScene().view:getRoot(), "ExploreUseItemConfirmView")
	arg_1_0._uiLoader = PrefabInstantiate.Create(arg_1_0._containerGO)

	arg_1_0._uiLoader:startLoad("ui/viewres/explore/exploreconfirmview.prefab", arg_1_0._onLoaded, arg_1_0)

	local var_1_0 = CameraMgr.instance:getMainCamera()
	local var_1_1 = CameraMgr.instance:getUICamera()
	local var_1_2 = ViewMgr.instance:getUIRoot().transform

	arg_1_0._uiFollower = gohelper.onceAddComponent(arg_1_0._containerGO, typeof(ZProj.UIFollower))

	arg_1_0._uiFollower:Set(var_1_0, var_1_1, var_1_2, arg_1_0._containerGO.transform, 0, 0, 0, 0, 0)
	arg_1_0._uiFollower:SetEnable(false)
	gohelper.setActive(arg_1_0._containerGO, false)
end

function var_0_0.setTarget(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._targetPos = arg_2_2

	if arg_2_1 then
		arg_2_0._uiFollower:SetTarget3d(arg_2_1.transform)
		arg_2_0._uiFollower:SetEnable(true)
		gohelper.setActive(arg_2_0._containerGO, true)
	else
		arg_2_0._uiFollower:SetEnable(false)
		gohelper.setActive(arg_2_0._containerGO, false)
	end
end

function var_0_0._onLoaded(arg_3_0)
	arg_3_0.viewGO = arg_3_0._uiLoader:getInstGO()
	arg_3_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "go_confirm/go_container/btn_confirm")
	arg_3_0._btncancle = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "go_confirm/go_container/btn_cancel")

	arg_3_0._btnconfirm:AddClickListener(arg_3_0.onConfirm, arg_3_0)
	arg_3_0._btncancle:AddClickListener(arg_3_0.onCancel, arg_3_0)
end

function var_0_0.onCancel(arg_4_0)
	ExploreController.instance:getMap():getCompByType(ExploreEnum.MapStatus.UseItem):onCancel(arg_4_0._targetPos)
	arg_4_0:setTarget()
end

function var_0_0.onConfirm(arg_5_0)
	local var_5_0 = ExploreController.instance:getMap()
	local var_5_1 = var_5_0:getCompByType(ExploreEnum.MapStatus.UseItem):getCurItemMo()
	local var_5_2 = arg_5_0._targetPos
	local var_5_3 = var_5_0:getHero()

	var_5_3:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CreateUnit, true, true)
	var_5_3:onCheckDir(var_5_3.nodePos, var_5_2)
	ExploreRpc.instance:sendExploreUseItemRequest(var_5_1.id, var_5_2.x, var_5_2.y)
	var_5_0:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function var_0_0.dispose(arg_6_0)
	if arg_6_0.viewGO then
		arg_6_0._btnconfirm:RemoveClickListener()
		arg_6_0._btncancle:RemoveClickListener()

		arg_6_0._btnconfirm = nil
		arg_6_0._btncancle = nil
		arg_6_0.viewGO = nil
	end

	arg_6_0._targetPos = nil

	arg_6_0._uiLoader:dispose()

	arg_6_0._uiLoader = nil

	gohelper.destroy(arg_6_0._containerGO)

	arg_6_0._containerGO = nil
end

return var_0_0
