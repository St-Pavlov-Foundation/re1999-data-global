module("modules.logic.explore.view.unit.ExploreUnitBaseView", package.seeall)

local var_0_0 = class("ExploreUnitBaseView", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.unit = arg_1_1
	arg_1_0.url = arg_1_2
	arg_1_0.viewGO = nil
	arg_1_0.isInitDone = false

	arg_1_0:startLoad()
end

function var_0_0.startLoad(arg_2_0)
	if arg_2_0._uiLoader or not arg_2_0.url then
		return
	end

	arg_2_0._containerGO = gohelper.create2d(GameSceneMgr.instance:getCurScene().view:getRoot(), arg_2_0.unit.id)
	arg_2_0._uiLoader = PrefabInstantiate.Create(arg_2_0._containerGO)

	arg_2_0._uiLoader:startLoad(arg_2_0.url, arg_2_0._onLoaded, arg_2_0)
end

function var_0_0._onLoaded(arg_3_0)
	arg_3_0.isInitDone = true

	local var_3_0 = CameraMgr.instance:getMainCamera()
	local var_3_1 = CameraMgr.instance:getUICamera()
	local var_3_2 = ViewMgr.instance:getUIRoot().transform

	arg_3_0.viewGO = arg_3_0._uiLoader:getInstGO()
	arg_3_0._uiFollower = gohelper.onceAddComponent(arg_3_0._containerGO, typeof(ZProj.UIFollower))

	arg_3_0._uiFollower:Set(var_3_0, var_3_1, var_3_2, arg_3_0.unit._displayTr or arg_3_0.unit.trans, 0, 0, 0, 0, arg_3_0._offsetY2d or 15)
	arg_3_0._uiFollower:SetEnable(true)
	arg_3_0:onInit()
	arg_3_0:addEventListeners()
	arg_3_0:onOpen()
end

function var_0_0.setTarget(arg_4_0, arg_4_1)
	if not arg_4_0.isInitDone then
		return
	end

	arg_4_0._uiFollower:SetTarget3d(arg_4_1.transform)
end

function var_0_0.onInit(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.closeThis(arg_8_0)
	arg_8_0.unit.uiComp:removeUI(arg_8_0.class)
end

function var_0_0.tryDispose(arg_9_0)
	if arg_9_0.isInitDone then
		arg_9_0:removeEventListeners()
		arg_9_0:onClose()
		arg_9_0:onDestroy()
		gohelper.destroy(arg_9_0._containerGO)

		arg_9_0.isInitDone = false
	end

	arg_9_0._containerGO = nil
	arg_9_0._uiFollower = nil

	if arg_9_0._uiLoader then
		arg_9_0._uiLoader:dispose()

		arg_9_0._uiLoader = nil
	end

	arg_9_0.viewGO = nil
	arg_9_0.unit = nil
	arg_9_0.url = nil
end

return var_0_0
