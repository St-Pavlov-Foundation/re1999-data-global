module("modules.logic.chessgame.game.interact.ChessInteractComp", package.seeall)

local var_0_0 = class("ChessInteractComp")
local var_0_1 = {
	[ChessGameEnum.InteractType.Normal] = ChessInteractBase,
	[ChessGameEnum.InteractType.Role] = ChessInteractPlayer,
	[ChessGameEnum.InteractType.Teleport] = ChessInteractBase,
	[ChessGameEnum.InteractType.Hit] = ChessInteractBase,
	[ChessGameEnum.InteractType.Save] = ChessInteractBase,
	[ChessGameEnum.InteractType.Hunter] = ChessInteractHunter,
	[ChessGameEnum.InteractType.Prey] = ChessInteractBase,
	[ChessGameEnum.InteractType.Obstacle] = ChessInteractObstacle
}
local var_0_2 = {}
local var_0_3 = {
	[ChessGameEnum.GameEffectType.Display] = ChessEffectBase,
	[ChessGameEnum.GameEffectType.Talk] = ChessEffectBase
}
local var_0_4 = {}

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.mo = arg_1_2
	arg_1_0.mapId = arg_1_1

	local var_1_0 = arg_1_0.mo:getConfig()

	arg_1_0.id = arg_1_0.mo:getId()

	if var_1_0 then
		arg_1_0.objType = var_1_0.interactType
		arg_1_0.config = var_1_0

		local var_1_1 = var_1_0.interactType

		arg_1_0._handler = (var_0_1[var_1_1] or var_0_0).New()

		arg_1_0._handler:init(arg_1_0)
	end

	local var_1_2 = arg_1_0.mo:getEffectType()

	if var_1_2 and var_1_2 ~= ChessGameEnum.GameEffectType.None then
		local var_1_3 = var_0_4[arg_1_2.actId]

		arg_1_0.chessEffectObj = (var_1_3 and var_1_3[var_1_2] or var_0_3[var_1_2]).New(arg_1_0)
	end

	arg_1_0.avatar = nil
end

function var_0_0.updateComp(arg_2_0, arg_2_1)
	arg_2_0.mo = arg_2_1

	local var_2_0 = arg_2_0.mo:getConfig()

	arg_2_0:updatePos(var_2_0)

	if arg_2_0.objType == ChessGameEnum.InteractType.Hunter then
		arg_2_0:getHandler():refreshAlarmArea()
	end
end

function var_0_0.setAvatar(arg_3_0, arg_3_1)
	arg_3_0.avatar = arg_3_1

	arg_3_0:updateAvatarInScene()
end

function var_0_0.checkShowAvatar(arg_4_0)
	return arg_4_0.avatar and arg_4_0.avatar.isLoaded
end

function var_0_0.setCurrpath(arg_5_0, arg_5_1)
	arg_5_0._path = arg_5_1
end

function var_0_0.getCurrpath(arg_6_0)
	return arg_6_0._path
end

function var_0_0.checkHaveAvatarPath(arg_7_0)
	local var_7_0 = arg_7_0.mo:getConfig().path

	if not string.nilorempty(var_7_0) then
		return true
	end

	return false
end

function var_0_0.updateAvatarInScene(arg_8_0)
	if not arg_8_0.avatar or not arg_8_0.avatar.sceneGo then
		return
	end

	local var_8_0 = arg_8_0.mo:getConfig()

	arg_8_0:updatePos(var_8_0)

	if arg_8_0.avatar.loader and var_8_0 then
		local var_8_1 = var_8_0.path

		arg_8_0.avatar.name = SLFramework.FileHelper.GetFileName(var_8_1, false)

		if not string.nilorempty(var_8_1) then
			if arg_8_0:getCurrpath() == var_8_1 then
				return
			end

			if not arg_8_0.avatar.loader:getAssetItem(var_8_1) then
				arg_8_0.avatar.loader:startLoad(var_8_1, arg_8_0.onSceneObjectLoadFinish, arg_8_0)
				arg_8_0:setCurrpath(var_8_1)
			end
		end
	end
end

function var_0_0.updatePos(arg_9_0, arg_9_1)
	if not arg_9_0.avatar or not arg_9_0.avatar.sceneGo then
		return
	end

	if arg_9_0.mo.posX and arg_9_0.mo.posY and arg_9_1 then
		local var_9_0 = arg_9_1.offset

		arg_9_0.avatar.sceneX = arg_9_0.mo.posX or arg_9_1.x
		arg_9_0.avatar.sceneY = arg_9_0.mo.posY or arg_9_1.x

		local var_9_1 = {
			z = 0,
			x = arg_9_0.mo.posX,
			y = arg_9_0.mo.posY
		}
		local var_9_2 = ChessGameHelper.nodePosToWorldPos(var_9_1)

		transformhelper.setLocalPos(arg_9_0.avatar.sceneTf, var_9_2.x + var_9_0.x, var_9_2.y + var_9_0.y, var_9_2.z + var_9_0.z)

		local var_9_3 = arg_9_0.mo.direction or arg_9_1.dir

		arg_9_0._handler:faceTo(var_9_3)
	end
end

function var_0_0.changeModule(arg_10_0, arg_10_1)
	if arg_10_0:getCurrpath() == arg_10_1 then
		return
	end

	if not arg_10_0._oldLoader then
		arg_10_0._oldLoader = arg_10_0.avatar.loader
	elseif arg_10_0.avatar.loader then
		arg_10_0.avatar.loader:dispose()

		arg_10_0.avatar.loader = nil
	end

	arg_10_0:loadModule(arg_10_1)
end

function var_0_0.loadModule(arg_11_0, arg_11_1)
	gohelper.destroyAllChildren(arg_11_0.avatar.sceneGo)

	arg_11_0.avatar.loader = PrefabInstantiate.Create(arg_11_0.avatar.sceneGo)

	if not string.nilorempty(arg_11_1) then
		local var_11_0 = arg_11_0.avatar.loader:getAssetItem(arg_11_1)

		if not gohelper.isNil(var_11_0) then
			arg_11_0.avatar.loader:startLoad(arg_11_1, arg_11_0.onSceneObjectLoadFinish, arg_11_0)
			arg_11_0:setCurrpath(arg_11_1)
		end
	end
end

var_0_0.DirectionList = {
	2,
	4,
	6,
	8
}
var_0_0.DirectionSet = {}

for iter_0_0, iter_0_1 in pairs(var_0_0.DirectionList) do
	var_0_0.DirectionSet[iter_0_1] = true
end

function var_0_0.onSceneObjectLoadFinish(arg_12_0)
	if arg_12_0.avatar and arg_12_0.avatar.loader then
		local var_12_0 = arg_12_0.avatar.loader:getInstGO()

		if not gohelper.isNil(var_12_0) and not arg_12_0.avatar.isLoaded then
			local var_12_1 = gohelper.findChild(var_12_0, "Canvas")

			if var_12_1 then
				local var_12_2 = var_12_1:GetComponent(typeof(UnityEngine.Canvas))

				if var_12_2 then
					var_12_2.worldCamera = CameraMgr.instance:getMainCamera()
				end
			end

			for iter_12_0, iter_12_1 in ipairs(var_0_0.DirectionList) do
				arg_12_0.avatar["goFaceTo" .. iter_12_1] = gohelper.findChild(var_12_0, "dir_" .. iter_12_1)
			end

			arg_12_0.avatar.effectNode = gohelper.findChild(var_12_0, "icon")
		end

		arg_12_0.avatar.isLoaded = true

		arg_12_0:getHandler():onAvatarLoaded()
		ChessGameController.instance.interactsMgr:checkCompleletedLoaded(arg_12_0.mo.id)
	end
end

function var_0_0.tryGetGameObject(arg_13_0)
	if arg_13_0.avatar and arg_13_0.avatar.loader then
		local var_13_0 = arg_13_0.avatar.loader:getInstGO()

		if not gohelper.isNil(var_13_0) then
			return var_13_0
		end
	end
end

function var_0_0.tryGetSceneGO(arg_14_0)
	if arg_14_0.avatar and not gohelper.isNil(arg_14_0.avatar.sceneGo) then
		return arg_14_0.avatar.sceneGo
	end
end

function var_0_0.hideSelf(arg_15_0)
	if arg_15_0.avatar and not gohelper.isNil(arg_15_0.avatar.sceneGo) then
		gohelper.setActive(arg_15_0.avatar.sceneGo, false)
	end
end

function var_0_0.isShow(arg_16_0)
	if not arg_16_0.mo then
		return false
	else
		return arg_16_0.mo:isShow()
	end
end

function var_0_0.getAvatarName(arg_17_0)
	local var_17_0 = arg_17_0.mo.actId
	local var_17_1 = arg_17_0.mo.id
	local var_17_2 = ChessGameConfig.instance:getInteractObjectCo(var_17_0, var_17_1)

	if var_17_2 then
		return var_17_2.avatar
	end
end

function var_0_0.getObjId(arg_18_0)
	return arg_18_0.id
end

function var_0_0.getObjType(arg_19_0)
	return arg_19_0.objType
end

function var_0_0.getObjPosIndex(arg_20_0)
	return arg_20_0.mo:getPosIndex()
end

function var_0_0.getHandler(arg_21_0)
	return arg_21_0._handler
end

function var_0_0.onCancelSelect(arg_22_0)
	if arg_22_0:getHandler() then
		arg_22_0:getHandler():onCancelSelect()
	end

	if arg_22_0.chessEffectObj then
		arg_22_0.chessEffectObj:onCancelSelect()
	end
end

function var_0_0.onSelected(arg_23_0)
	if arg_23_0:getHandler() then
		arg_23_0:getHandler():onSelected()
	end

	if arg_23_0.chessEffectObj then
		arg_23_0.chessEffectObj:onSelected()
	end
end

function var_0_0.canSelect(arg_24_0)
	return arg_24_0.config and arg_24_0.config.interactType == ChessGameEnum.InteractType.Player or arg_24_0.config.interactType == ChessGameEnum.InteractType.AssistPlayer
end

function var_0_0.dispose(arg_25_0)
	if arg_25_0.avatar ~= nil then
		if arg_25_0.avatar.loader then
			arg_25_0.avatar.loader:dispose()

			arg_25_0.avatar.loader = nil
		end

		if not gohelper.isNil(arg_25_0.avatar.sceneGo) then
			gohelper.setActive(arg_25_0.avatar.sceneGo, false)
			gohelper.destroy(arg_25_0.avatar.sceneGo)
		end

		ChessGameController.instance:dispatchEvent(ChessGameEvent.DeleteInteractAvatar, arg_25_0.id)

		arg_25_0.avatar = nil
	end

	local var_25_0 = {
		"_handler",
		"chessEffectObj"
	}

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if arg_25_0[iter_25_1] ~= nil then
			arg_25_0[iter_25_1]:dispose()

			arg_25_0[iter_25_1] = nil
		end
	end
end

function var_0_0.showStateView(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0:getHandler().showStateView then
		return arg_26_0:getHandler():showStateView(arg_26_1, arg_26_2)
	end
end

return var_0_0
