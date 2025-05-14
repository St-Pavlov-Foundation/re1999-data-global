module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.TeamChessEffectWrap", package.seeall)

local var_0_0 = class("TeamChessEffectWrap", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._uniqueId = 0
	arg_1_0.effectType = nil
	arg_1_0.path = nil
	arg_1_0.containerGO = nil
	arg_1_0.containerTr = nil
	arg_1_0.effectGO = nil
	arg_1_0._scaleX = 1
	arg_1_0._scaleY = 1
	arg_1_0._scaleZ = 1
	arg_1_0.callback = nil
	arg_1_0.callbackObj = nil
end

function var_0_0.setUniqueId(arg_2_0, arg_2_1)
	arg_2_0._uniqueId = arg_2_1
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.containerGO = arg_3_1
	arg_3_0.containerTr = arg_3_1.transform
end

function var_0_0.play(arg_4_0, arg_4_1)
	if arg_4_0.effectGO then
		arg_4_0:_setWorldScale()
		arg_4_0:setActive(true)

		if arg_4_0.effectType == EliminateTeamChessEnum.VxEffectType.ZhanHou then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_warcry)
		end

		if arg_4_0.effectType == EliminateTeamChessEnum.VxEffectType.WangYu then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_deadwords)
		end

		if arg_4_0.effectType == EliminateTeamChessEnum.VxEffectType.PowerDown then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_adverse_buff)
		end

		if arg_4_0.effectType == EliminateTeamChessEnum.VxEffectType.PowerUp then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_front_buff)
		end

		if arg_4_0.effectType == EliminateTeamChessEnum.VxEffectType.StrongHoldBattle then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_clearing_fight)
		end

		if arg_4_0.effectType == EliminateTeamChessEnum.VxEffectType.Move then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_shift)
		end

		local var_4_0 = arg_4_1

		if arg_4_1 == nil then
			var_4_0 = arg_4_0.effectType ~= nil and EliminateTeamChessEnum.VxEffectTypePlayTime[arg_4_0.effectType] or 0.5
		end

		TaskDispatcher.runDelay(arg_4_0.returnPool, arg_4_0, var_4_0)
	end
end

function var_0_0.returnPool(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.returnPool, arg_5_0)
	TeamChessEffectPool.returnEffect(arg_5_0)
end

function var_0_0.setEffectType(arg_6_0, arg_6_1)
	arg_6_0.effectType = arg_6_1

	local var_6_0 = EliminateTeamChessEnum.VxEffectTypeToPath[arg_6_1]

	arg_6_0:setPath(var_6_0)
end

function var_0_0.setPath(arg_7_0, arg_7_1)
	arg_7_0.path = arg_7_1

	arg_7_0:loadAsset(arg_7_0.path)
end

function var_0_0.loadAsset(arg_8_0, arg_8_1)
	if not string.nilorempty(arg_8_1) and not arg_8_0._loader then
		arg_8_0._loader = PrefabInstantiate.Create(arg_8_0.containerGO)

		arg_8_0._loader:startLoad(arg_8_1, arg_8_0._onResLoaded, arg_8_0)
	end
end

function var_0_0._onResLoaded(arg_9_0)
	arg_9_0.effectGO = arg_9_0._loader:getInstGO()

	arg_9_0:setLayer(UnityLayer.Scene)
	arg_9_0:_setWorldScale()

	if arg_9_0.callback then
		arg_9_0.callback(arg_9_0.callbackObj)
	end
end

function var_0_0.setEffectGO(arg_10_0, arg_10_1)
	arg_10_0.effectGO = arg_10_1

	if arg_10_0._effectScale then
		transformhelper.setLocalScale(arg_10_0.effectGO.transform, arg_10_0._effectScale, arg_10_0._effectScale, arg_10_0._effectScale)
	end

	if arg_10_0._renderOrder then
		arg_10_0:setRenderOrder(arg_10_0._renderOrder, true)
	end
end

function var_0_0.setLayer(arg_11_0, arg_11_1)
	arg_11_0._layer = arg_11_1

	gohelper.setLayer(arg_11_0.effectGO, arg_11_0._layer, true)
end

function var_0_0.setWorldPos(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0.containerTr then
		transformhelper.setPos(arg_12_0.containerTr, arg_12_1, arg_12_2, arg_12_3)
		arg_12_0:clearTrail()
	end
end

function var_0_0.setWorldScale(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0._scaleX = arg_13_1
	arg_13_0._scaleY = arg_13_2
	arg_13_0._scaleZ = arg_13_3
end

function var_0_0._setWorldScale(arg_14_0)
	if arg_14_0.effectGO then
		transformhelper.setLocalScale(arg_14_0.effectGO.transform, arg_14_0._scaleX, arg_14_0._scaleY, arg_14_0._scaleZ)
	end
end

function var_0_0.clearTrail(arg_15_0)
	if arg_15_0.effectGO then
		gohelper.onceAddComponent(arg_15_0.effectGO, typeof(ZProj.EffectTimeScale)):ClearTrail()
	end
end

function var_0_0.setCallback(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.callback = arg_16_1
	arg_16_0.callbackObj = arg_16_2
end

function var_0_0.setActive(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0.containerGO, arg_17_1)
end

function var_0_0.setRenderOrder(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 then
		return
	end

	local var_18_0 = arg_18_0._renderOrder

	arg_18_0._renderOrder = arg_18_1

	if not arg_18_2 and arg_18_1 == var_18_0 then
		return
	end

	if not gohelper.isNil(arg_18_0.effectGO) then
		local var_18_1 = arg_18_0.effectGO:GetComponent(typeof(ZProj.EffectOrderContainer))

		if var_18_1 then
			var_18_1:SetBaseOrder(arg_18_1)
		end
	end
end

function var_0_0.setEffectScale(arg_19_0, arg_19_1)
	arg_19_0._effectScale = arg_19_1

	if arg_19_0.effectGO then
		transformhelper.setLocalScale(arg_19_0.effectGO.transform, arg_19_0._effectScale, arg_19_0._effectScale, arg_19_0._effectScale)
	end
end

function var_0_0.clear(arg_20_0)
	arg_20_0.callback = nil
	arg_20_0.callbackObj = nil

	arg_20_0:setActive(false)
end

function var_0_0.onDestroy(arg_21_0)
	arg_21_0.containerGO = nil
	arg_21_0.effectGO = nil
	arg_21_0.callback = nil
	arg_21_0.callbackObj = nil
	arg_21_0.effectType = nil

	TaskDispatcher.cancelTask(arg_21_0.returnPool, arg_21_0)

	if arg_21_0._loader then
		arg_21_0._loader:onDestroy()

		arg_21_0._loader = nil
	end
end

return var_0_0
