module("modules.logic.versionactivity1_5.act142.view.game.Activity142BaffleObject", package.seeall)

local var_0_0 = class("Activity142BaffleObject", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.baffleContainerTr = arg_1_1
end

function var_0_0.init(arg_2_0)
	arg_2_0:createSceneNode()
end

function var_0_0.createSceneNode(arg_3_0)
	arg_3_0.viewGO = UnityEngine.GameObject.New("baffle_item")
	arg_3_0.transform = arg_3_0.viewGO.transform

	arg_3_0.transform:SetParent(arg_3_0.baffleContainerTr, false)
end

function var_0_0.updatePos(arg_4_0, arg_4_1)
	arg_4_0.baffleCo = arg_4_1

	local var_4_0, var_4_1, var_4_2 = Activity142Helper.calBafflePosInScene(arg_4_0.baffleCo.x, arg_4_0.baffleCo.y, arg_4_0.baffleCo.direction)

	transformhelper.setLocalPos(arg_4_0.transform, var_4_0, var_4_1, var_4_2)
	gohelper.setActive(arg_4_0.viewGO, true)
	arg_4_0:loadAvatar()
end

function var_0_0.loadAvatar(arg_5_0)
	if not gohelper.isNil(arg_5_0.baffleGo) then
		gohelper.destroy(arg_5_0.baffleGo)
	end

	arg_5_0.loader = PrefabInstantiate.Create(arg_5_0.viewGO)

	local var_5_0 = arg_5_0:getBaffleResPath()

	arg_5_0.loader:startLoad(var_5_0, arg_5_0.onSceneObjectLoadFinish, arg_5_0)
end

function var_0_0.getBaffleResPath(arg_6_0)
	return Activity142Helper.getBaffleResPath(arg_6_0.baffleCo)
end

function var_0_0.onSceneObjectLoadFinish(arg_7_0)
	arg_7_0.baffleGo = arg_7_0.loader:getInstGO()

	if not gohelper.isNil(arg_7_0.baffleGo) then
		local var_7_0 = gohelper.findChild(arg_7_0.baffleGo, "Canvas")

		if var_7_0 then
			local var_7_1 = var_7_0:GetComponent(typeof(UnityEngine.Canvas))

			if var_7_1 then
				var_7_1.worldCamera = CameraMgr.instance:getMainCamera()
			end
		end
	end

	gohelper.setLayer(arg_7_0.viewGO, UnityLayer.Scene, true)
end

function var_0_0.recycle(arg_8_0)
	gohelper.setActive(arg_8_0.viewGO, false)
end

function var_0_0.dispose(arg_9_0)
	if arg_9_0.loader then
		arg_9_0.loader:dispose()

		arg_9_0.loader = nil
	end

	gohelper.setActive(arg_9_0.viewGO, true)
	gohelper.destroy(arg_9_0.viewGO)
	arg_9_0:__onDispose()
end

return var_0_0
