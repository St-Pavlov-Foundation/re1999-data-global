module("modules.logic.activity.controller.chessmap.ActivityChessInteractObject", package.seeall)

local var_0_0 = class("ActivityChessInteractObject")
local var_0_1 = {
	[ActivityChessEnum.InteractType.Player] = ActivityChessInteractPlayer,
	[ActivityChessEnum.InteractType.TriggerFail] = ActivityChessInteractTriggerFail
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
	arg_1_0.id = arg_1_1.id

	local var_1_0 = Activity109Config.instance:getInteractObjectCo(arg_1_0.originData.actId, arg_1_0.id)

	if var_1_0 then
		arg_1_0.objType = var_1_0.interactType
		arg_1_0.config = var_1_0
		arg_1_0._handler = (var_0_1[var_1_0.interactType] or ActivityChessInteractBase).New()

		arg_1_0._handler:init(arg_1_0)
	else
		logError("can't find interact_object : " .. tostring(arg_1_1.actId) .. ", " .. tostring(arg_1_1.id))
	end

	arg_1_0.goToObject = ActivityChessGotoObject.New(arg_1_0)
	arg_1_0.effect = ActivityChessInteractEffect.New(arg_1_0)
	arg_1_0.avatar = nil
end

function var_0_0.setAvatar(arg_2_0, arg_2_1)
	arg_2_0.avatar = arg_2_1

	arg_2_0:updateAvatarInScene()
end

function var_0_0.updateAvatarInScene(arg_3_0)
	if not arg_3_0.avatar or not arg_3_0.avatar.sceneGo then
		return
	end

	if arg_3_0.originData.posX and arg_3_0.originData.posY then
		local var_3_0, var_3_1, var_3_2 = ActivityChessGameController.instance:calcTilePosInScene(arg_3_0.originData.posX, arg_3_0.originData.posY, arg_3_0.avatar.order)

		arg_3_0.avatar.sceneX = var_3_0
		arg_3_0.avatar.sceneY = var_3_1

		transformhelper.setLocalPos(arg_3_0.avatar.sceneTf, var_3_0, var_3_1, var_3_2)
	end

	local var_3_3 = 0.6

	transformhelper.setLocalScale(arg_3_0.avatar.sceneTf, var_3_3, var_3_3, var_3_3)

	if arg_3_0.avatar.loader then
		local var_3_4 = arg_3_0:getAvatarPath()

		if not string.nilorempty(var_3_4) then
			arg_3_0.avatar.loader:startLoad(string.format("scenes/m_s12_dfw/prefab/picpe/%s.prefab", var_3_4), arg_3_0.onSceneObjectLoadFinish, arg_3_0)
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

function var_0_0.onSceneObjectLoadFinish(arg_4_0)
	if arg_4_0.avatar and arg_4_0.avatar.loader then
		local var_4_0 = arg_4_0.avatar.loader:getInstGO()

		if not gohelper.isNil(var_4_0) then
			local var_4_1 = gohelper.findChild(var_4_0, "Canvas")

			if var_4_1 then
				local var_4_2 = var_4_1:GetComponent(typeof(UnityEngine.Canvas))

				if var_4_2 then
					var_4_2.worldCamera = CameraMgr.instance:getMainCamera()
				end
			end

			for iter_4_0, iter_4_1 in ipairs(var_0_0.DirectionList) do
				arg_4_0.avatar["goFaceTo" .. iter_4_1] = gohelper.findChild(var_4_0, "piecea/char_" .. iter_4_1)
			end
		end

		arg_4_0.avatar.isLoaded = true

		arg_4_0:getHandler():onAvatarLoaded()
		arg_4_0.goToObject:onAvatarLoaded()
		arg_4_0.effect:onAvatarLoaded()
	end
end

function var_0_0.tryGetGameObject(arg_5_0)
	if arg_5_0.avatar and arg_5_0.avatar.loader then
		local var_5_0 = arg_5_0.avatar.loader:getInstGO()

		if not gohelper.isNil(var_5_0) then
			return var_5_0
		end
	end
end

function var_0_0.getAvatarPath(arg_6_0)
	local var_6_0 = arg_6_0.originData.actId
	local var_6_1 = arg_6_0.originData.id
	local var_6_2 = Activity109Config.instance:getInteractObjectCo(var_6_0, var_6_1)

	if var_6_2 then
		return var_6_2.avatar
	end
end

function var_0_0.canSelect(arg_7_0)
	return arg_7_0.config and arg_7_0.config.interactType == ActivityChessEnum.InteractType.Player
end

function var_0_0.getHandler(arg_8_0)
	return arg_8_0._handler
end

function var_0_0.canBlock(arg_9_0)
	return arg_9_0.config and (arg_9_0.config.interactType == ActivityChessEnum.InteractType.Obstacle or arg_9_0.config.interactType == ActivityChessEnum.InteractType.TriggerFail or arg_9_0.config.interactType == ActivityChessEnum.InteractType.Player)
end

function var_0_0.getSelectPriority(arg_10_0)
	local var_10_0

	if arg_10_0.config then
		var_10_0 = ActivityChessEnum.InteractSelectPriority[arg_10_0.config.interactType]
	end

	return var_10_0 or arg_10_0.id
end

function var_0_0.dispose(arg_11_0)
	if arg_11_0.avatar ~= nil then
		if arg_11_0.avatar.loader then
			arg_11_0.avatar.loader:dispose()

			arg_11_0.avatar.loader = nil
		end

		if not gohelper.isNil(arg_11_0.avatar.sceneGo) then
			gohelper.setActive(arg_11_0.avatar.sceneGo, true)
			gohelper.destroy(arg_11_0.avatar.sceneGo)
		end

		ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.DeleteInteractAvatar, arg_11_0.avatar)

		arg_11_0.avatar = nil
	end

	local var_11_0 = {
		"_handler",
		"goToObject",
		"effect"
	}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if arg_11_0[iter_11_1] ~= nil then
			arg_11_0[iter_11_1]:dispose()

			arg_11_0[iter_11_1] = nil
		end
	end
end

return var_0_0
