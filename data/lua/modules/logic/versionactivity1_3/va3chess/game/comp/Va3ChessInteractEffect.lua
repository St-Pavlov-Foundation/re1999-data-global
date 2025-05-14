module("modules.logic.versionactivity1_3.va3chess.game.comp.Va3ChessInteractEffect", package.seeall)

local var_0_0 = class("Va3ChessInteractEffect")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
	arg_1_0.effectGoDict = {}
	arg_1_0.assetItemList = {}
	arg_1_0.loadedEffectTypeList = {}
end

function var_0_0.onAvatarLoaded(arg_2_0)
	local var_2_0 = arg_2_0._target.avatar.loader

	if not var_2_0 then
		return
	end

	local var_2_1 = var_2_0:getInstGO()

	arg_2_0._target.avatar.goLostTarget = gohelper.findChild(var_2_1, "piecea/vx_vertigo")
	arg_2_0.effectGoContainer = var_2_1

	arg_2_0:refreshSearchFailed()
end

function var_0_0.refreshSearchFailed(arg_3_0)
	if arg_3_0._target.originData and arg_3_0._target.originData.data and arg_3_0._target.avatar and arg_3_0._target.avatar.goLostTarget then
		gohelper.setActive(arg_3_0._target.avatar.goLostTarget, arg_3_0._target.originData.data.lostTarget)
	end
end

function var_0_0.showEffect(arg_4_0, arg_4_1)
	arg_4_0.showEffectType = arg_4_1

	if not arg_4_0.effectGoDict[arg_4_0.showEffectType] then
		arg_4_0:loadEffect()

		return
	end

	arg_4_0:_realShowEffect()
end

function var_0_0._realShowEffect(arg_5_0)
	local var_5_0 = arg_5_0.effectGoDict[arg_5_0.showEffectType]

	gohelper.setActive(var_5_0, false)
	gohelper.setActive(var_5_0, true)

	if arg_5_0.showEffectType == Va3ChessEnum.EffectType.ArrowHit then
		local var_5_1
		local var_5_2 = arg_5_0._target.objType

		if var_5_2 == Va3ChessEnum.InteractType.Player or var_5_2 == Va3ChessEnum.InteractType.AssistPlayer then
			var_5_1 = AudioEnum.chess_activity142.ArrowHitPlayer
		else
			var_5_1 = AudioEnum.chess_activity142.MonsterBeHit
		end

		AudioMgr.instance:trigger(var_5_1)
	end
end

function var_0_0.loadEffect(arg_6_0)
	local var_6_0 = arg_6_0.showEffectType

	if tabletool.indexOf(arg_6_0.loadedEffectTypeList, var_6_0) then
		return
	end

	table.insert(arg_6_0.loadedEffectTypeList, var_6_0)

	local var_6_1 = Va3ChessEnum.EffectPath[var_6_0]

	loadAbAsset(var_6_1, true, arg_6_0._onLoadCallback, arg_6_0)
end

function var_0_0._onLoadCallback(arg_7_0, arg_7_1)
	if arg_7_1.IsLoadSuccess then
		table.insert(arg_7_0.assetItemList, arg_7_1)
		arg_7_1:Retain()

		local var_7_0 = gohelper.clone(arg_7_1:GetResource(), arg_7_0.effectGoContainer)

		arg_7_0.effectGoDict[arg_7_0.showEffectType] = var_7_0

		gohelper.setActive(var_7_0, false)
		arg_7_0:showEffect(arg_7_0.showEffectType)
	end
end

function var_0_0.dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.loadedEffectTypeList) do
		removeAssetLoadCb(Va3ChessEnum.EffectPath[iter_8_1], arg_8_0._onLoadCallback, arg_8_0)
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.assetItemList) do
		iter_8_3:Release()

		arg_8_0.assetItemList[iter_8_2] = nil
	end

	arg_8_0.assetItemList = {}

	for iter_8_4, iter_8_5 in pairs(arg_8_0.effectGoDict) do
		if not gohelper.isNil(iter_8_5) then
			gohelper.destroy(iter_8_5)
		end

		arg_8_0.effectGoDict[iter_8_4] = nil
	end

	arg_8_0.effectGoDict = {}
	arg_8_0._target = nil
	arg_8_0.effectGoContainer = nil
end

return var_0_0
