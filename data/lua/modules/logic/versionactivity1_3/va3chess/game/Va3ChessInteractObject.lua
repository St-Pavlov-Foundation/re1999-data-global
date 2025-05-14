module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessInteractObject", package.seeall)

local var_0_0 = class("Va3ChessInteractObject")
local var_0_1 = {
	[Va3ChessEnum.InteractType.Player] = Va3ChessInteractPlayer,
	[Va3ChessEnum.InteractType.AssistPlayer] = Va3ChessInteractPlayer,
	[Va3ChessEnum.InteractType.TriggerFail] = Va3ChessInteractTriggerFail,
	[Va3ChessEnum.InteractType.PushedBlock] = Va3ChessInteractPushed,
	[Va3ChessEnum.InteractType.DestroyableItem] = Va3ChessInteractDestroyable,
	[Va3ChessEnum.InteractType.PushedOnceBlock] = Va3ChessInteractOncePushed,
	[Va3ChessEnum.InteractType.Trap] = Va3ChessInteractTrap,
	[Va3ChessEnum.InteractType.DeductHpEnemy] = Va3ChessInteractDeductHpEnemy,
	[Va3ChessEnum.InteractType.DestroyableTrap] = Va3ChessInteractDestroyableTrap,
	[Va3ChessEnum.InteractType.BoltLauncher] = Va3ChessInteractBoltLauncher,
	[Va3ChessEnum.InteractType.Pedal] = Va3ChessInteractPedal,
	[Va3ChessEnum.InteractType.Brazier] = Va3ChessInteractBrazier,
	[Va3ChessEnum.InteractType.StandbyTrackEnemy] = Va3ChessInteractStandbyTrackEnemy,
	[Va3ChessEnum.InteractType.SentryEnemy] = Va3ChessInteractSentryEnemy
}
local var_0_2 = {
	[Va3ChessEnum.ActivityId.Act142] = {
		[Va3ChessEnum.InteractType.Player] = Act142InteractPlayer,
		[Va3ChessEnum.InteractType.AssistPlayer] = Act142InteractPlayer
	}
}
local var_0_3 = {
	[Va3ChessEnum.GameEffectType.Hero] = Va3ChessHeroEffect,
	[Va3ChessEnum.GameEffectType.Direction] = Va3ChessNextDirectionEffect,
	[Va3ChessEnum.GameEffectType.Sleep] = Va3ChessSleepMonsterEffect,
	[Va3ChessEnum.GameEffectType.Monster] = Va3ChessMonsterEffect,
	[Va3ChessEnum.GameEffectType.Display] = Va3ChessEffectBase
}
local var_0_4 = {
	[Va3ChessEnum.ActivityId.Act142] = {
		[Va3ChessEnum.GameEffectType.Hero] = Va3ChessIconEffect,
		[Va3ChessEnum.GameEffectType.Monster] = Va3ChessIconEffect
	}
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
	arg_1_0.id = arg_1_1.id

	local var_1_0 = Va3ChessConfig.instance:getInteractObjectCo(arg_1_0.originData.actId, arg_1_0.id)

	if var_1_0 then
		arg_1_0.objType = var_1_0.interactType
		arg_1_0.config = var_1_0
		arg_1_0.effectCfg = Va3ChessConfig.instance:getEffectCo(arg_1_0.originData.actId, var_1_0.effectId)

		local var_1_1 = var_1_0.interactType
		local var_1_2 = var_0_2[arg_1_1.actId]

		arg_1_0._handler = (var_1_2 and var_1_2[var_1_1] or var_0_1[var_1_1] or Va3ChessInteractBase).New()

		arg_1_0._handler:init(arg_1_0)
	else
		logError("can't find interact_object : " .. tostring(arg_1_1.actId) .. ", " .. tostring(arg_1_1.id))
	end

	arg_1_0.goToObject = Va3ChessGotoObject.New(arg_1_0)
	arg_1_0.effect = Va3ChessInteractEffect.New(arg_1_0)

	if arg_1_0.effectCfg then
		local var_1_3 = arg_1_0.effectCfg.effectType
		local var_1_4 = var_0_4[arg_1_1.actId]

		arg_1_0.chessEffectObj = (var_1_4 and var_1_4[var_1_3] or var_0_3[var_1_3]).New(arg_1_0)
	end

	arg_1_0.avatar = nil
end

function var_0_0.setIgnoreSight(arg_2_0, arg_2_1)
	arg_2_0._ignoreSight = arg_2_1
end

function var_0_0.GetIgnoreSight(arg_3_0)
	return arg_3_0._ignoreSight
end

function var_0_0.setAvatar(arg_4_0, arg_4_1)
	arg_4_0.avatar = arg_4_1

	arg_4_0:updateAvatarInScene()
end

function var_0_0.updateAvatarInScene(arg_5_0)
	if not arg_5_0.avatar or not arg_5_0.avatar.sceneGo then
		return
	end

	if arg_5_0.originData.posX and arg_5_0.originData.posY then
		local var_5_0, var_5_1, var_5_2 = Va3ChessGameController.instance:calcTilePosInScene(arg_5_0.originData.posX, arg_5_0.originData.posY, arg_5_0.avatar.order, true)

		arg_5_0.avatar.sceneX = var_5_0
		arg_5_0.avatar.sceneY = var_5_1

		transformhelper.setLocalPos(arg_5_0.avatar.sceneTf, var_5_0, var_5_1, var_5_2)
	end

	if arg_5_0.avatar.loader then
		local var_5_3 = arg_5_0:getAvatarPath()

		arg_5_0.avatar.name = SLFramework.FileHelper.GetFileName(var_5_3, false)

		if not string.nilorempty(var_5_3) then
			arg_5_0.avatar.loader:startLoad(string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, var_5_3), arg_5_0.onSceneObjectLoadFinish, arg_5_0)
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

function var_0_0.onSceneObjectLoadFinish(arg_6_0)
	if arg_6_0.avatar and arg_6_0.avatar.loader then
		local var_6_0 = arg_6_0.avatar.loader:getInstGO()

		if not gohelper.isNil(var_6_0) then
			local var_6_1 = gohelper.findChild(var_6_0, "Canvas")

			if var_6_1 then
				local var_6_2 = var_6_1:GetComponent(typeof(UnityEngine.Canvas))

				if var_6_2 then
					var_6_2.worldCamera = CameraMgr.instance:getMainCamera()
				end
			end

			for iter_6_0, iter_6_1 in ipairs(var_0_0.DirectionList) do
				arg_6_0.avatar["goFaceTo" .. iter_6_1] = gohelper.findChild(var_6_0, "dir_" .. iter_6_1)
			end
		end

		arg_6_0.avatar.isLoaded = true

		arg_6_0.effect:onAvatarLoaded()
		arg_6_0.goToObject:onAvatarLoaded()

		if arg_6_0.chessEffectObj then
			arg_6_0.chessEffectObj:onAvatarFinish()
		end

		arg_6_0:getHandler():onAvatarLoaded()
		arg_6_0:showStateView(Va3ChessEnum.ObjState.Idle)
	end
end

function var_0_0.tryGetGameObject(arg_7_0)
	if arg_7_0.avatar and arg_7_0.avatar.loader then
		local var_7_0 = arg_7_0.avatar.loader:getInstGO()

		if not gohelper.isNil(var_7_0) then
			return var_7_0
		end
	end
end

function var_0_0.tryGetSceneGO(arg_8_0)
	if arg_8_0.avatar and not gohelper.isNil(arg_8_0.avatar.sceneGo) then
		return arg_8_0.avatar.sceneGo
	end
end

function var_0_0.getAvatarPath(arg_9_0)
	local var_9_0 = arg_9_0.originData.actId
	local var_9_1 = arg_9_0.originData.id
	local var_9_2 = Va3ChessConfig.instance:getInteractObjectCo(var_9_0, var_9_1)

	if var_9_2 then
		return var_9_2.avatar
	end
end

function var_0_0.getAvatarName(arg_10_0)
	local var_10_0 = arg_10_0.originData.actId
	local var_10_1 = arg_10_0.originData.id
	local var_10_2 = Va3ChessConfig.instance:getInteractObjectCo(var_10_0, var_10_1)

	if var_10_2 then
		return var_10_2.avatar
	end
end

function var_0_0.getObjId(arg_11_0)
	return arg_11_0.id
end

function var_0_0.getObjType(arg_12_0)
	return arg_12_0.objType
end

function var_0_0.getObjPosIndex(arg_13_0)
	return arg_13_0.originData:getPosIndex()
end

function var_0_0.getHandler(arg_14_0)
	return arg_14_0._handler
end

function var_0_0.canBlock(arg_15_0, arg_15_1, arg_15_2)
	if ({
		[Va3ChessEnum.InteractType.Obstacle] = true,
		[Va3ChessEnum.InteractType.Player] = true,
		[Va3ChessEnum.InteractType.AssistPlayer] = true,
		[Va3ChessEnum.InteractType.BoltLauncher] = true,
		[Va3ChessEnum.InteractType.Brazier] = true,
		[Va3ChessEnum.InteractType.StandbyTrackEnemy] = true
	})[arg_15_0.config and arg_15_0.config.interactType or nil] then
		return true
	end

	if arg_15_0:getHandler().checkCanBlock then
		return arg_15_0:getHandler():checkCanBlock(arg_15_1, arg_15_2)
	end
end

function var_0_0.onCancelSelect(arg_16_0)
	if arg_16_0:getHandler() then
		arg_16_0:getHandler():onCancelSelect()
	end

	if arg_16_0.chessEffectObj then
		arg_16_0.chessEffectObj:onCancelSelect()
	end
end

function var_0_0.onSelected(arg_17_0)
	if arg_17_0:getHandler() then
		arg_17_0:getHandler():onSelected()
	end

	if arg_17_0.chessEffectObj then
		arg_17_0.chessEffectObj:onSelected()
	end
end

function var_0_0.canSelect(arg_18_0)
	return arg_18_0.config and arg_18_0.config.interactType == Va3ChessEnum.InteractType.Player or arg_18_0.config.interactType == Va3ChessEnum.InteractType.AssistPlayer
end

function var_0_0.getSelectPriority(arg_19_0)
	local var_19_0

	if arg_19_0.config then
		var_19_0 = Va3ChessEnum.InteractSelectPriority[arg_19_0.config.interactType]
	end

	return var_19_0 or arg_19_0.id
end

function var_0_0.dispose(arg_20_0)
	if arg_20_0.avatar ~= nil then
		if arg_20_0.avatar.loader then
			arg_20_0.avatar.loader:dispose()

			arg_20_0.avatar.loader = nil
		end

		if not gohelper.isNil(arg_20_0.avatar.sceneGo) then
			gohelper.setActive(arg_20_0.avatar.sceneGo, true)
			gohelper.destroy(arg_20_0.avatar.sceneGo)
		end

		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.DeleteInteractAvatar, arg_20_0.id)

		arg_20_0.avatar = nil
	end

	local var_20_0 = {
		"_handler",
		"goToObject",
		"effect",
		"chessEffectObj"
	}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if arg_20_0[iter_20_1] ~= nil then
			arg_20_0[iter_20_1]:dispose()

			arg_20_0[iter_20_1] = nil
		end
	end
end

function var_0_0.showStateView(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0:getHandler().showStateView then
		return arg_21_0:getHandler():showStateView(arg_21_1, arg_21_2)
	end
end

return var_0_0
