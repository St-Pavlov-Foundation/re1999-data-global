module("modules.logic.versionactivity1_2.yaxian.view.game.items.YaXianBaffleObject", package.seeall)

local var_0_0 = class("YaXianBaffleObject", UserDataDispose)

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

function var_0_0.getBaffleResPath(arg_4_0)
	if arg_4_0.baffleCo.direction == YaXianGameEnum.BaffleDirection.Left or arg_4_0.baffleCo.direction == YaXianGameEnum.BaffleDirection.Right then
		return arg_4_0.baffleCo.type == 0 and YaXianGameEnum.SceneResPath.LRBaffle0 or YaXianGameEnum.SceneResPath.LRBaffle1
	else
		return arg_4_0.baffleCo.type == 0 and YaXianGameEnum.SceneResPath.TBBaffle0 or YaXianGameEnum.SceneResPath.TBBaffle1
	end
end

function var_0_0.loadAvatar(arg_5_0)
	if not gohelper.isNil(arg_5_0.baffleGo) then
		gohelper.destroy(arg_5_0.baffleGo)
	end

	arg_5_0.loader = PrefabInstantiate.Create(arg_5_0.viewGO)

	arg_5_0.loader:startLoad(arg_5_0:getBaffleResPath(), arg_5_0.onSceneObjectLoadFinish, arg_5_0)
end

function var_0_0.onSceneObjectLoadFinish(arg_6_0)
	arg_6_0.baffleGo = arg_6_0.loader:getInstGO()

	if not gohelper.isNil(arg_6_0.baffleGo) then
		local var_6_0 = gohelper.findChild(arg_6_0.baffleGo, "Canvas")

		if var_6_0 then
			local var_6_1 = var_6_0:GetComponent(typeof(UnityEngine.Canvas))

			if var_6_1 then
				var_6_1.worldCamera = CameraMgr.instance:getMainCamera()
			end
		end
	end

	transformhelper.setLocalScale(arg_6_0.viewGO.transform, 0.8, 0.8, 0.8)
	gohelper.setLayer(arg_6_0.viewGO, UnityLayer.Scene, true)
end

function var_0_0.updatePos(arg_7_0, arg_7_1)
	arg_7_0.baffleCo = arg_7_1

	local var_7_0, var_7_1, var_7_2 = YaXianGameHelper.calBafflePosInScene(arg_7_0.baffleCo.x, arg_7_0.baffleCo.y, arg_7_0.baffleCo.direction)

	transformhelper.setLocalPos(arg_7_0.transform, var_7_0, var_7_1, var_7_2)
	gohelper.setActive(arg_7_0.viewGO, true)
	arg_7_0:loadAvatar()
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
